module SeedReferralCategory
  def self.seed
  	title_list = [
                  "Hypermart",
                  "Matahari",
                  "Dealer",
                  "Koran/Billboard",
                  "Pelanggan BigTV",
                  "SPG",
                  "Others"
                 ]

  	title_list.each_with_index do |title,index|
	  	ReferralCategory.create( :name => title )
		end
  end
end
