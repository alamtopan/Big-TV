class GatepayController < ApplicationController

  def notify
    order = Order.find_by_code(params[:TRANSIDMERCHANT])
    response_text = 'Stop'

    if order && order.total.to_f == params[:AMOUNT].to_f &&
        Payment.track_payment(order, params, request.env)
      response_text = 'Continue'
    end

    Rails.logger.info ':: NOTIFY RESPONSE ...'
    Rails.logger.info response_text
    render text: response_text
  rescue
    render text: 'STOP'
  end

  def redirect
    @order = Order.find_by_code(params[:TRANSIDMERCHANT])
    redirect_to(root_path) and return unless @order

    @payment_channel = PaymentChannel.new(params[:PAYMENTCHANNEL])

    if @payment_channel.atm? && !@order.success?
      render 'publics/_atm_payment_instruction', layout: 'detail'
    else
      redirect_to thanks_path(token: @order.token)
    end
  end
end
