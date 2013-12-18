module SeedOffice
  def self.seed
    fixture_path = "#{Rails.root}/db/fixtures"

    yaml_office = YAML.load_file("#{fixture_path}/office.yml")
    office_yml = yaml_office['office']
    regionals = office_yml['regionals']

    regionals.each_with_index do |reg,n|
      regional = Regional.find_or_create_by_name(reg["regional_#{n}"]["name"])
      categories = reg["regional_#{n}"]['categories']
      categories.each_with_index do |cate,c|
        category = CategoryOffice.find_or_create_by_name(cate["category_#{c}"]['name'])
        offices = cate["category_#{c}"]['offices']
        offices.each_with_index do |of,i|
          office = Office.find_or_initialize_by_name(of["office_#{i}"]['name'])
          office.address = of["office_#{i}"]['address']
          office.phone_area = of["office_#{i}"]['area']
          office.no_phone = of["office_#{i}"]['phone']
          office.no_fax = of["office_#{i}"]['fax']
          office.no_fax = of["office_#{i}"]['fax']
          office.longitude = of["office_#{i}"]['longitude']
          office.latitude = of["office_#{i}"]['latitude']
          office.regional_id = regional.id
          office.category_office_id = category.id
          office.save
        end if offices.present?
      end if categories.present?
    end
  end
end