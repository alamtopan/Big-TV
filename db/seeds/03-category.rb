module SeedCategory
  def self.seed
    categories = ['Premium','Extra','Other','Ez']
    categories.each do |cat|
      category = Category.find_or_create_by_name(cat)
    end
  end
end