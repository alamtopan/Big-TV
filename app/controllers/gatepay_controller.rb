class GatepayController < ApplicationController

  # Fungsi Pembayaran
  def notify
    order = Order.find_by_code(params[:TRANSIDMERCHANT])
    response_text = 'Stop'

    if order && order.grand_total.to_f == params[:AMOUNT].to_f &&
        Payment.track_payment(order, params, request.env)
      response_text = 'Continue'
    end

    Rails.logger.info ':: NOTIFY RESPONSE ...'
    Rails.logger.info response_text
    render text: response_text
  rescue
    render text: 'STOP'
  end

  # Redirect fungsi pembayaran
  def redirect
    @order = Order.find_by_code(params[:TRANSIDMERCHANT])
    redirect_to(root_path) and return unless @order

    @payment_channel = PaymentChannel.new(params[:PAYMENTCHANNEL])
    if @payment_channel.atm? && !@order.success?
      CustomerMailer.delay.atm_payment_instruction(@order, params[:PAYMENTCODE])
      redirect_to payment_instruction_path(token: @order.token, code: params[:PAYMENTCODE])
    else
      redirect_to thanks_path(token: @order.token)
    end
  end
end
