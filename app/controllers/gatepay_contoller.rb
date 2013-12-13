class GatepayController
  
  def notify
    amount = params[:AMOUNT]
    transid = params[:TRANSIDMERCHANT]
    word = params[:WORDS]
    status = params[:STATUSTYPE]
    response = params[:RESPONSECODE]
    approval = params[:APPROVALCODE]
    result_msg = params[:RESULTMSG]
    payment_chanerl = params[:PAYMENTCHANNEL]
    payment_code = params[:PAYMENTCODE]
    session_id = params[:SESSIONID]
    bank = params[:BANK]
    mcn = params[:MCN]
    payment_date = params[:PAYMENTDATETIME]
    verify_id = params[:VERIFYID]
    verify_score = params[:VERIFYSCORE]
    verify_status = params[:VERIFYSTATUS]
    
      order = Order.where('code = ?',transid).first
      if order
        code = order.code
        total = order.total
        if result_msg == 'FAILED' 
          order.status = 'Failed'
          order.save
          gatepay_update(transid,{trxstatus: 'Failed'})
          return 'STOP'
        else
          order.status = 'Success'
          order.save
          gatepay_update(transid,params_all)
        end
      else
        return 'STOP'
      end
    end
    'CONTINUE'
  end

  def redirect
    order_number = params[:TRANSIDMERCHANT];
    purchase_amt = params[:AMOUNT];
    status_code = params[:STATUSCODE];
    words = params[:WORDS];
    paymentchannel = params[:PAYMENTCHANNEL];
    session_id = params[:SESSIONID];
    paymentcode = params[:PAYMENTCODE];
    redirect_to thanks_path
  end

  private
    def gatepay_update(transid,params={})
      gatepay = Gatepay.find_by_transid(transid)
      gatepay.update_attributes(params)
      gatepay.save
    end

    def params_all
      { trxstatus: 'Success', word: params[:WORDS], statustype: params[:STATUSTYPE],
        response_code: params[:RESPONSECODE], approvalcode: params[:APPROVALCODE],
        trxstatus: params[:RESULTMSG], payment_channel: params[:PAYMENTCHANNEL],
        paymentcode: params[:PAYMENTCODE], session_id: params[:SESSIONID], 
        bank_issuer: params[:BANK], creditcard: params[:MCN], payment_date_time: params[:PAYMENTDATETIME],
        verifyid: params[:VERIFYID], verifyscore: params[:VERIFYSCORE], verify_status: params[:VERIFYSTATUS]
      }
    end
  
end