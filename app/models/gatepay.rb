class Gatepay < ActiveRecord::Base
  attr_accessible :transid,:trxstatus,:words,:statustype,:response_code,:approvalcode,
                  :payment_channel,:paymentcode,:session_id,:bank_issuer,:creditcard,
                  :payment_date_time,:verifyid,:verifyscore,:verifystatus      
end
