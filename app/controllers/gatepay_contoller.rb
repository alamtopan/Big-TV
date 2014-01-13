class GatepayController < ApplicationController

  def notify
    order = Order.find_by_code(params[:TRANSIDMERCHANT])
    response_text = 'Stop'

    if order && order.total.to_f == params[:AMOUNT].to_f && Payment.track_payment(order, params, request.env)
      response_text = 'Continue'
    end

    Rails.logger.info ':: NOTIFY RESPONSE ...'
    Rails.logger.info response_text

    render text: response_text
  # rescue
  #   render text: 'STOP'
  end

  def redirect
    redirect_params = {}
    if params[:TRANSIDMERCHANT].present?
      payment_token = Digest::SHA1.hexdigest(params[:TRANSIDMERCHANT])[0,10]
      session[payment_token] = params[:TRANSIDMERCHANT]
      redirect_params.merge!(order_id: payment_token)
    end

    redirect_to thanks_path(redirect_params)
  end
end
