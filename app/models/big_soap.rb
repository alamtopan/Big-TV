module BigSoap
  SERVICE_URL = "http://103.21.218.52/WEBSERVICE/SERVICE.ASMX"
  USERID  = "APIUSER"
  PASSWD  = "APIUSER@123"
  NAMESPACE = "http://tempuri.org/"

  class Client
    attr_reader :last_request

    def construct_envelope(&block)
      Nokogiri::XML::Builder.new do |xml|
        xml.Envelope("xmlns:soap" => "http://schemas.xmlsoap.org/soap/envelope/",
                     "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
                     "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema") do
          xml.parent.namespace = xml.parent.namespace_definitions.first
          xml['soap'].Header do
            # Header information goes here
            xml.MQUserNameToken("xmlns" => BigSoap::NAMESPACE) do
              xml.User_id           BigSoap::USERID
              xml.Password          BigSoap::PASSWD
              xml.ExternalPartyName "WEB"
            end
          end
          xml['soap'].Body(&block)
        end
      end
    end

    def get_customer_info(customer_no)
      envelope = construct_envelope do |xml|
        xml.GetCustomerInfo('xmlns' => BigSoap::NAMESPACE) do
          xml.CustomerInfoXML BigSoap::Template.get_customer_info(customer_no)
          xml.ReferenceNo     Time.now.to_i
        end
      end

      BigSoap::CustomerInfo.new(post(envelope)).after_get_info #rescue nil
    end

    def create_customer(customer)
      envelope = construct_envelope do |xml|
        xml.CreateCustomer('xmlns' => BigSoap::NAMESPACE) do
          xml.CustomerXML BigSoap::Template.create_customer(customer)
          xml.ReferenceNo Time.now.to_i
        end
      end

      BigSoap::CustomerInfo.new(post(envelope)).after_create rescue nil
    end

    def post(data)
      @last_request = data.to_xml
      result = Typhoeus::Request.post(BigSoap::SERVICE_URL, body: data.to_xml, headers: {'Content-Type' => "text/xml; charset=utf-8"})
      process_response(result)
    end

    def process_response(response)
      handle_error(response) if response.body =~ /(soap:Fault)|(Bad Request)/
      Nokogiri::XML(response.body)
    end

    def handle_error(response)
      msg = if response.body =~ /soap:Fault/
              xml   = Nokogiri::XML(response.body)
              xpath = '/soap:Envelope/soap:Body/soap:Fault//ExceptionMessage'
              xml.xpath(xpath).text
            else
              response.body
            end

      raise BigSoap::Error.new(msg, @last_request, response)
    end
  end
end