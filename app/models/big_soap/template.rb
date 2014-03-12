module BigSoap::Template
  def self.get_customer_info(customer_no)
    "<REQUESTINFO>" + 
      "<KEY_NAMEVALUE>"+
         "<KEY_NAME>CUSTOMERNO</KEY_NAME>"+
         "<KEY_VALUE>#{customer_no}</KEY_VALUE>"+
      "</KEY_NAMEVALUE>"+
    "</REQUESTINFO>"
  end

  def self.create_customer(customer)
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