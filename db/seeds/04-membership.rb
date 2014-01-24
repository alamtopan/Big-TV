module SeedMembership
  def self.seed
    fixture_path = "#{Rails.root}/db/fixtures"

    yaml_membership = YAML.load_file("#{fixture_path}/membership.yml")
    memberships = yaml_membership['memberships']

    memberships.each_with_index do |member,n|
      member = member['membership']
      puts "------------------------------------------------------------"
      puts "#{member}"
      puts "------------------------------------------------------------"
      membership = Membership.find_or_initialize_by_name(member["name"])
      membership.description  =  member["description"]
      membership.category_id  =  Category.find_by_name(member["category"]).id
      membership.is_published =  member["published"]
      membership.is_featured  =  member["featured"]
      membership.position  =  member["position"]
      membership.save!
      
      # price
      member["prices"].each_with_index do |prc,i_prc|
        i_price = prc["price"]
        price = MembershipPrice.find_or_initialize_by_membership_id(membership.id)
        price.price = i_price['price']
        price.total_period = i_price['total']
        price.periode_name = i_price['periode']
        price.save
      end if member["prices"].present?

      # item
      member["items"].each_with_index do |itm,i_itm|
        i_item = itm["item"]
        unit_item_id = UnitItem.find_or_create_by_name(i_item['name']).id
        item_conds = {unit_item_id: unit_item_id, membership_id: membership.id}

        if MembershipItem.where(item_conds).blank?
          MembershipItem.create(item_conds)
        end
      end if member["items"].present?
    end if memberships.present?
  end
end