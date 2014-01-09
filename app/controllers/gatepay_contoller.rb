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
    order = Order.find_by_code(params[:TRANSIDMERCHANT]) 
    redirect_to thanks_path
  end
end
