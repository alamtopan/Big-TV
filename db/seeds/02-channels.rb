module SeedChannel
  def self.seed
    fixture_path = "#{Rails.root}/db/fixtures"

    yaml_item = YAML.load_file("#{fixture_path}/channel.yml")
    yaml_item['items'].each do |itm|
      itm = itm['item']
      item = UnitItem.find_or_initialize_by_name(itm["name"])
      item.status_hd = itm['hd']
      item.free = itm['free']
      item.logo = File.new("#{Rails.root}/public/logo/#{itm['logo']}") if itm['logo'].present?
      item.save!
    end
  end
end