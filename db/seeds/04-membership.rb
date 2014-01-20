module SeedMembership
  def self.seed
    fixture_path = "#{Rails.root}/db/fixtures"

    yaml_membership = YAML.load_file("#{fixture_path}/membership.yml")
    memberships = yaml_membership['membership']

    memberships.each_with_index do |member,n|
      membership = Membership.find_or_initialize_by_name(member["membership_#{n}"]["name"])
      membership.description  =  member["membership_#{n}"]["description"]
      membership.category_id  =  Category.find_by_name(member["membership_#{n}"]["category"]).id
      membership.is_published =  member["membership_#{n}"]["published"]
      membership.is_featured  =  member["membership_#{n}"]["featured"]
      membership.save!
      # price
      prices = member["membership_#{n}"]["prices"]
      prices.each_with_index do |prc,i_prc|
        i_price = prc["price_#{i_prc}"]
        price = MembershipPrice.find_or_initialize_by_membership_id(membership.id)
        price.price = i_price['price']
        price.total_period = i_price['total']
        price.periode_name = i_price['periode']
        price.save
      end
      # item
      items = member["membership_#{n}"]["items"]
      items.each_with_index do |itm,i_itm|
        i_item = itm["item_#{i_itm}"]
        puts i_item['name']
        puts i_itm
        item = MembershipItem.new
        item.membership_id = membership.id
        item.unit_item_id = UnitItem.find_or_create_by_name(i_item['name']).id
        item.save
      end if items.present?
    end
  end
end