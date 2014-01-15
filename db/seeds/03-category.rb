module SeedCategory
  def self.seed
    Category::DEFAULT.each do |cat|
      category = Category.find_or_create_by_name(cat)
    end
  end
end