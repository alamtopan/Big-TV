module SeedGroup
  def self.seed
    fixture_path = "#{Rails.root}/db/fixtures"

    yaml_group = YAML.load_file("#{fixture_path}/group_item.yml")
    groups = yaml_group['groups']

    groups.each_with_index do |data|
      group = GroupItem.find_or_initialize_by_name(data["group"]["name"])
      group.colour =   data["group"]["colour"]
      group.position = data["group"]["position"]
      group.save!

      data["group"]["items"].each do |channel_item|
        data_channel = channel_item['item']
        item = UnitItem.find_or_initialize_by_name(data_channel['name'])
        item.group_item_id = group.id
        item.status_hd = data_channel['hd']
        item.logo = File.new("#{Rails.root}/public/logo/#{data_channel['logo']}") if data_channel['logo'].present?
        item.save
      end
    end
  end
end