module SeedGroup
  def self.seed
    fixture_path = "#{Rails.root}/db/fixtures"

    yaml_group = YAML.load_file("#{fixture_path}/group_item.yml")
    groups = yaml_group['group']

    groups.each_with_index do |gr,n|
      group = GroupItem.find_or_initialize_by_name(gr["group_#{n}"]["name"])
      group.colour =  gr["group_#{n}"]["colour"]
      group.save!
      # item
      items = gr["group_#{n}"]["items"]
      items.each_with_index do |itm,i_itm|
        i_item = itm["item_#{i_itm}"]
        item = UnitItem.find_or_initialize_by_name(i_item['name'])
        item.group_item_id = group.id
        item.status_hd = i_item['hd']
        if i_item['logo'].present?
          item.logo = File.new("#{Rails.root}/public/logo/#{i_item['logo']}")
        end
        item.save
      end
    end
  end
end