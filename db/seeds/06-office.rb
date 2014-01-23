require 'csv'
module SeedOffice
  def self.seed
    fixture_path = "#{Rails.root}/db/fixtures"
    location_attributes = ["Alamat","Area","Telepon","Fax"]
    regionals = ["Sumatra",
                 "Jawa Madura",
                 "Kalimantan", 
                 "Sulawesi", 
                 "Bali", 
                 "Nusa Tenggara", 
                 "Maluku Papua"].map do |regional_name|
                    Regional.find_or_create_by_name(regional_name)
                 end

    categories = ['Retailer', 'Mall', 'Dealer'].map do |category_name|
      CategoryOffice.find_or_create_by_name(category_name.gsub('Retailer','Hypermart'))
    end
    
    regionals.each do |regional|
      regional_prefix = regional.name.gsub(/\W/,'_')
      categories.each do |category|
        category_prefix = category.name.gsub('Hypermart','Retailer').titleize
        csv_path = "#{fixture_path}/#{regional_prefix}_#{category_prefix}.csv".downcase

        CSV.new(File.read(csv_path), headers: true).each do |csv|
          next if csv[category_prefix].blank?
          office = Office.find_or_initialize_by_name(csv[category_prefix])
          office.address = csv['Alamat']
          office.phone_area = csv['Area']
          office.no_phone = csv['Telepon']
          office.no_fax = csv['Fax']
          office.regional_id = regional.id
          office.category_office_id = category.id
          office.save
        end if File.exist?(csv_path)

      end
    end
  end
end