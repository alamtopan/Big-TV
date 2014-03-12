class BigApi
  include HTTParty
  attr_accessor :client, :connected

  module Config
    API_URL   = "http://103.21.218.52/WEBSERVICE/SERVICE.ASMX"
    WDSL_URL  = "#{API_URL}?WSDL" 
    USERNAME  = "APIUSER"
    PASSWORD  = "APIUSER@123"
  end

  module Parameter
    def self.auth
      "<REQUESTINFO>
          <AUTHENTICATEUSER>
            <USER_ID>#{Config::USERNAME}</USER_ID>
            <PASSWORD>#{Config::PASSWORD}</PASSWORD>
          </AUTHENTICATEUSER>
        </REQUESTINFO>"
    end

    def self.referenceNo
      "99#{Time.now.to_i*(rand(900)+1)}"
    end

    def self.user(customer)
      profile = customer.profile

      return "<REQUESTINFO> 
        <CUSTOMERINFO>
          <CUSTOMERNO></CUSTOMERNO> 
          <CUSTOMERTYPE></CUSTOMERTYPE> 
          <CATEGORY></CATEGORY> 
          <INDIVIDUAL>Y</INDIVIDUAL>
          <TITLE></TITLE> 
          <FIRSTNAME>#{profile.name_first.upcase}</FIRSTNAME> 
          <MIDDLENAME></MIDDLENAME> 
          <LASTNAME>#{profile.name_last.upcase}</LASTNAME> 
          <OPENTITY></OPENTITY> 
          <CURRENCYCODE>IDR</CURRENCYCODE> 
          <COMPANYNAME>BIGTV</COMPANYNAME> 
          <NATIONALITY></NATIONALITY> 
          <UINTYPE></UINTYPE>
          <UIN></UIN>
          <BILLINGMEDIA>#{profile.billing_method_code}</BILLINGMEDIA> 
          <PARENT>N</PARENT>
          <GROUPID></GROUPID> 
          <NOTES></NOTES> 
          <NETWORKENDPOINT>
            <ELEMENTCODE>ENDPOINT1</ELEMENTCODE>
            <PORTNUMBER>4</PORTNUMBER> 
          </NETWORKENDPOINT>
          <CONTACTINFO> 
            <CONTACTNAME>#{profile.full_name.upcase}</CONTACTNAME> 
            <EMAIL>#{customer.email.upcase}</EMAIL> 
            <ALTEMAIL></ALTEMAIL> 
            <HOMEPHONE>#{profile.no_phone.to_s.gsub(/\W/,'')}</HOMEPHONE> 
            <WORKPHONE></WORKPHONE> 
            <MOBILEPHONE>#{profile.no_hp.to_s.gsub(/\W/,'')}</MOBILEPHONE> 
            <FAXNBR></FAXNBR>
          </CONTACTINFO> 
          <USERINFO>
            <USERNAME>#{customer.email.upcase}</USERNAME>
            <PASSWORD>#{customer.password}</PASSWORD> 
          </USERINFO>
          <ADDRESSINFO> 
            <ADDRESSTYPECODE>PRI</ADDRESSTYPECODE> 
            <ADDRESS1>#{profile.address.to_s.upcase}</ADDRESS1> 
            <ADDRESS2></ADDRESS2> 
            <STREET></STREET> 
            <AREA></AREA> 
            <CITY>#{profile.city.to_s.upcase}</CITY> 
            <DISTRICT></DISTRICT> 
            <STATE>#{profile.province.to_s.upcase}</STATE>
            <ZIPCODE>#{profile.codepos.to_s.upcase}</ZIPCODE> 
            <COUNTRY>INA</COUNTRY>
          </ADDRESSINFO> 
          <FLEX-ATTRIBUTE-INFO>
            <ATTRIBUTE1></ATTRIBUTE1> 
            <ATTRIBUTE2></ATTRIBUTE2> 
            <ATTRIBUTE3></ATTRIBUTE3> 
            <ATTRIBUTE4></ATTRIBUTE4> 
            <ATTRIBUTE5></ATTRIBUTE5> 
            <ATTRIBUTE6></ATTRIBUTE6> 
            <ATTRIBUTE7></ATTRIBUTE7> 
            <ATTRIBUTE8></ATTRIBUTE8> 
            <ATTRIBUTE9></ATTRIBUTE9> 
            <ATTRIBUTE10></ATTRIBUTE10>
          </FLEX-ATTRIBUTE-INFO> 
        </CUSTOMERINFO>
      </REQUESTINFO>"
    end

  end

  def initialize
    @client = LolSoap::Client.new(open(BigApi::Config::WDSL_URL).read)
    @connected = false
  end

  def authenticate
    auth_request = client.request('AuthenticateUser')
    auth_request.body do |b|
      b.AuthenticateUserXML Parameter.auth
      b.referenceNo Parameter.referenceNo
    end
    
    raw_response = HTTParty.post(auth_request.url, body: auth_request.content, headers: auth_request.headers)
    @connected = raw_response.code === 200
    client.response(auth_request, raw_response)
  end

  def create_user(customer)
    request = client.request('CreateCustomer')
    request.body do |b|
      b.AuthenticateUserXML Parameter.auth
      b.CustomerXML Parameter.user(customer)
      b.referenceNo Parameter.referenceNo
    end
    raw_response = HTTParty.post(request.url, body: request.content, headers: request.headers)
    client.response(request, raw_response)
  end
end

# How to Use:
# @big_api = BigApi.new
# Auth:
# @big_api.authenticate
# Create User:
# @big_api.create_user(Customer.last)

# 1. Ada request masuk gak?
# 2. Datanya kesimpen gak