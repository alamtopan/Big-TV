module BigSoap
  class CustomerInfo
    attr_reader :raw_info
    def initialize(data)
      entitied = HTMLEntities.new.decode data.to_xml
      @raw_info = Hash.from_xml(entitied)['Envelope']['Body']
    end

    def after_get_info
      raw_info['GetCustomerInfoResponse']['GetCustomerInfoResult']['RESPONSEINFO']['CUSTOMERINFO']
    end

    def after_create
      raw_info['CreateCustomerResponse']['CreateCustomerResult']['RESPONSEINFO']['CUSTOMERINFO']
    end
  end
end

# SAMPLE DATA:
# {
#     "CUSTOMERNO"=>"1000000488",
#     "CUSTOMERTYPE"=>"POSTPAID",
#     "CUSTOMERTYPEDESC"=>"Postpaid",
#     "CATEGORY"=>"VIP",
#     "CATEGORYDESC"=>"VIP",
#     "INDIVIDUAL"=>"Y",
#     "TITLE"=>nil,
#     "FIRSTNAME"=>"Usep",
#     "MIDDLENAME"=>nil,
#     "LASTNAME"=>"Andriyawan",
#     "OPENTITY"=>"BIGTVCOR",
#     "OPENTITYNAME"=>"BIGTV CORPORATE OFFICE",
#     "CURRENCYCODE"=>"IDR",
#     "CURRENCYDESC"=>"Indonesian Rupiah",
#     "COMPANYNAME"=>nil,
#     "BILLINGMEDIA"=>nil,
#     "PARENT"=>"N",
#     "GROUPID"=>nil,
#     "NATIONALITY"=>nil,
#     "UINTYPE"=>nil,
#     "UIN"=>nil,
#     "NOTES"=>nil,
#     "CONTACTINFO"=>{
#         "CONTACTNAME"=>nil,
#         "EMAIL"=>nil,
#         "ALTEMAIL"=>nil,
#         "HOMEPHONE"=>nil,
#         "WORKPHONE"=>nil,
#         "MOBILEPHONE"=>nil,
#         "FAXNBR"=>nil
#     },
#     "ADDRESSINFO"=>[
#         {
#             "ADDRESSTYPECODE"=>"PRI",
#             "ADDRESS1"=>"Serpong Garden Blok D8 No 17",
#             "ADDRESS2"=>nil,
#             "STREET"=>nil,
#             "AREA"=>"Cisauk",
#             "CITY"=>nil,
#             "DISTRICT"=>"Tangerang Selatan",
#             "STATE"=>"Banten",
#             "ZIPCODE"=>nil,
#             "COUNTRY"=>"Indonesia"
#         },
#         {
#             "ADDRESSTYPECODE"=>"BIL",
#             "ADDRESS1"=>"Serpong Garden Blok D8 No 17",
#             "ADDRESS2"=>nil,
#             "STREET"=>nil,
#             "AREA"=>"Cisauk",
#             "CITY"=>nil,
#             "DISTRICT"=>"Tangerang Selatan",
#             "STATE"=>"Banten",
#             "ZIPCODE"=>nil,
#             "COUNTRY"=>"Indonesia"
#         }
#     ],
#     "FLEX_ATTRIBUTE_INFO"=>{
#         "ATTRIBUTE1"=>nil,
#         "ATTRIBUTE2"=>nil,
#         "ATTRIBUTE3"=>nil,
#         "ATTRIBUTE4"=>nil,
#         "ATTRIBUTE5"=>nil,
#         "ATTRIBUTE6"=>nil,
#         "ATTRIBUTE7"=>nil,
#         "ATTRIBUTE8"=>nil,
#         "ATTRIBUTE9"=>nil,
#         "ATTRIBUTE10"=>nil
#     },
#     "CONTRACTINFO"=>[
#         {
#             "CONTRACTNO"=>"14385",
#             "STARTDATE"=>"17-11-2013",
#             "ENDDATE"=>"31-12-9999",
#             "CONTRACTSTATUS"=>"Inactive",
#             "ISBULK"=>"N",
#             "BILLFREQUENCY"=>"1M",
#             "SALESMANDESC"=>nil,
#             "NOOFROOMS"=>"1",
#             "OUTLETS"=>"1",
#             "NOTES"=>nil,
#             "PLANINFO"=>{
#                 "PLANCODE"=>" BIGDEAL",
#                 "PLANDESC"=>" TRIAL BIG DEAL",
#                 "SERVICEGROUPINFO"=>[
#                     {
#                         "SERVICEGROUPDESC"=>"Hardware Rental Group",
#                         "SERVICEINFO"=>[
#                             {
#                                 "SERVICEDESC"=>"STB Rental"
#                             },
#                             {
#                                 "SERVICEDESC"=>"Smartcard Rental"
#                             }
#                         ]
#                     },
#                     {
#                         "SERVICEGROUPDESC"=>"BIG DEAL GROUP [OCTOBER]",
#                         "SERVICEINFO"=>[
#                             {
#                                 "SERVICEDESC"=>"BOX RENTAL SERVICE"
#                             },
#                             {
#                                 "SERVICEDESC"=>"BIG EZ STYLE ACTION SERVICE"
#                             },
#                             {
#                                 "SERVICEDESC"=>"BIG EZ SERVICE"
#                             },
#                             {
#                                 "SERVICEDESC"=>"BIG BASIC SERVICE"
#                             },
#                             {
#                                 "SERVICEDESC"=>"BIG DEAL SERVICE [OCTOBER]"
#                             }
#                         ]
#                     }
#                 ]
#             }
#         },
#         {
#             "CONTRACTNO"=>"14881",
#             "STARTDATE"=>"06-12-2013",
#             "ENDDATE"=>"05-01-2014",
#             "CONTRACTSTATUS"=>"Inactive",
#             "ISBULK"=>"N",
#             "BILLFREQUENCY"=>"1M",
#             "SALESMANDESC"=>nil,
#             "NOOFROOMS"=>"1",
#             "OUTLETS"=>"1",
#             "NOTES"=>nil,
#             "PLANINFO"=>{
#                 "PLANCODE"=>" BIGDEAL",
#                 "PLANDESC"=>" TRIAL BIG DEAL",
#                 "SERVICEGROUPINFO"=>[
#                     {
#                         "SERVICEGROUPDESC"=>"Hardware Rental Group",
#                         "SERVICEINFO"=>[
#                             {
#                                 "SERVICEDESC"=>"STB Rental"
#                             },
#                             {
#                                 "SERVICEDESC"=>"Smartcard Rental"
#                             }
#                         ]
#                     },
#                     {
#                         "SERVICEGROUPDESC"=>"BIG DEAL GROUP [OCTOBER]",
#                         "SERVICEINFO"=>[
#                             {
#                                 "SERVICEDESC"=>"BOX RENTAL SERVICE"
#                             },
#                             {
#                                 "SERVICEDESC"=>"BIG EZ STYLE ACTION SERVICE"
#                             },
#                             {
#                                 "SERVICEDESC"=>"BIG EZ SERVICE"
#                             },
#                             {
#                                 "SERVICEDESC"=>"BIG BASIC SERVICE"
#                             },
#                             {
#                                 "SERVICEDESC"=>"BIG DEAL SERVICE [OCTOBER]"
#                             }
#                         ]
#                     }
#                 ]
#             }
#         },
#         {
#             "CONTRACTNO"=>"15664",
#             "STARTDATE"=>"21-02-2014",
#             "ENDDATE"=>"31-12-9999",
#             "CONTRACTSTATUS"=>"Inactive",
#             "ISBULK"=>"N",
#             "BILLFREQUENCY"=>"1M",
#             "SALESMANDESC"=>nil,
#             "NOOFROOMS"=>"1",
#             "OUTLETS"=>"1",
#             "NOTES"=>"NOTES",
#             "PLANINFO"=>{
#                 "PLANCODE"=>" NBDEAL",
#                 "PLANDESC"=>" NEW BIG DEAL",
#                 "SERVICEGROUPINFO"=>{
#                     "SERVICEGROUPDESC"=>"BIG DEAL GROUP [OCTOBER]",
#                     "SERVICEINFO"=>[
#                         {
#                             "SERVICEDESC"=>"BOX RENTAL SERVICE"
#                         },
#                         {
#                             "SERVICEDESC"=>"BIG EZ STYLE ACTION SERVICE"
#                         },
#                         {
#                             "SERVICEDESC"=>"BIG EZ SERVICE"
#                         },
#                         {
#                             "SERVICEDESC"=>"BIG BASIC SERVICE"
#                         },
#                         {
#                             "SERVICEDESC"=>"BIG DEAL SERVICE [OCTOBER]"
#                         }
#                     ]
#                 }
#             }
#         },
#         {
#             "CONTRACTNO"=>"15794",
#             "STARTDATE"=>"06-03-2014",
#             "ENDDATE"=>"31-12-9999",
#             "CONTRACTSTATUS"=>"Active",
#             "ISBULK"=>"N",
#             "BILLFREQUENCY"=>"1M",
#             "SALESMANDESC"=>nil,
#             "NOOFROOMS"=>"1",
#             "OUTLETS"=>"1",
#             "NOTES"=>"UNCLEAN_20140305",
#             "PLANINFO"=>{
#                 "PLANCODE"=>" ADDHWPLN",
#                 "PLANDESC"=>" HD BOX CHARGE-ADDITIONAL",
#                 "SERVICEGROUPINFO"=>[
#                     {
#                         "SERVICEGROUPDESC"=>"Second Set Hardware Rental",
#                         "SERVICEINFO"=>[
#                             {
#                                 "SERVICEDESC"=>"STB Rental Two"
#                             },
#                             {
#                                 "SERVICEDESC"=>"Smartcard Rental Two"
#                             }
#                         ]
#                     },
#                     {
#                         "SERVICEGROUPDESC"=>"Three Set Hardware Rental",
#                         "SERVICEINFO"=>[
#                             {
#                                 "SERVICEDESC"=>"STB Rental Three"
#                             },
#                             {
#                                 "SERVICEDESC"=>"Smartcard Rental Three"
#                             }
#                         ]
#                     }
#                 ]
#             }
#         },
#         {
#             "CONTRACTNO"=>"1978",
#             "STARTDATE"=>"26-08-2013",
#             "ENDDATE"=>"31-12-9999",
#             "CONTRACTSTATUS"=>"Inactive",
#             "ISBULK"=>"N",
#             "BILLFREQUENCY"=>"1M",
#             "SALESMANDESC"=>nil,
#             "NOOFROOMS"=>"1",
#             "OUTLETS"=>"1",
#             "NOTES"=>nil,
#             "PLANINFO"=>{
#                 "PLANCODE"=>" BALLPLAN",
#                 "PLANDESC"=>" All Channel [Free]",
#                 "SERVICEGROUPINFO"=>{
#                     "SERVICEGROUPDESC"=>"All Channel Group",
#                     "SERVICEINFO"=>[
#                         {
#                             "SERVICEDESC"=>"BIG Deal Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"BIG Plus Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"BIG Family Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"BIG Family Sport Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"BIG Family Movie Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Tier Chinese 1 Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"HongKong Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Box Office Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Kids Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Teens Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"ESPN Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Ultimate Sport Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Indian Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Japan Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Australian Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Korean Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"HBO Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Promo Channel [Prepaid]"
#                         },
#                         {
#                             "SERVICEDESC"=>"FTA Internasional Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"FTA Nasional Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"In House Channels"
#                         },
#                         {
#                             "SERVICEDESC"=>"Kids and Education Channels"
#                         }
#                     ]
#                 }
#             }
#         },
#         {
#             "CONTRACTNO"=>"1979",
#             "STARTDATE"=>"26-08-2013",
#             "ENDDATE"=>"31-12-9999",
#             "CONTRACTSTATUS"=>"Inactive",
#             "ISBULK"=>"N",
#             "BILLFREQUENCY"=>"1M",
#             "SALESMANDESC"=>nil,
#             "NOOFROOMS"=>"1",
#             "OUTLETS"=>"1",
#             "NOTES"=>nil,
#             "PLANINFO"=>{
#                 "PLANCODE"=>" VHWRENTPLN",
#                 "PLANDESC"=>" Hardware Rental [Free]",
#                 "SERVICEGROUPINFO"=>{
#                     "SERVICEGROUPDESC"=>"Hardware Rental Group",
#                     "SERVICEINFO"=>[
#                         {
#                             "SERVICEDESC"=>"STB Rental"
#                         },
#                         {
#                             "SERVICEDESC"=>"Smartcard Rental"
#                         }
#                     ]
#                 }
#             }
#         }
#     ]
# }