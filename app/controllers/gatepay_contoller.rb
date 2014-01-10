class GatepayController < ApplicationController
  
  def notify
    if params[:RESULTMSG].to_s.upcase == 'SUCCESS'
      order = Order.find_by_code(params[:TRANSIDMERCHANT])
    end
    response_text = 'STOP'

    if order.total.to_f == params[:AMOUNT].to_f
      if Payment.track_payment(order, params, request.env)
        response_text = 'CONTINUE'
      end
    end if order
    render text: response_text
  rescue
    render text: 'STOP'
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
