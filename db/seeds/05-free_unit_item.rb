module SeedFreeUnitItem
  def self.seed
    fixture_path = "#{Rails.root}/db/fixtures"

    yaml_item = YAML.load_file("#{fixture_path}/free_unit_item.yml")
    items = yaml_item['items']

    items.each_with_index do |itm,n|
      item = UnitItem.find_or_initialize_by_name(itm["item_#{n}"]["name"])
      item.status_hd = itm["item_#{n}"]['hd']
      item.free = itm["item_#{n}"]['free']
      if itm["item_#{n}"]['logo'].present?
        item.logo = File.new("#{Rails.root}/public/logo/#{itm["item_#{n}"]['logo']}")
      end
      item.save!
    end
  end
end