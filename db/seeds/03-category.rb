module SeedCategory
  def self.seed
    Category::Config::NAMES.each do |cat|
      category = Category.find_or_create_by_name(cat)
    end
  end
end