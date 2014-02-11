class Profile < ActiveRecord::Base
  attr_accessible :address, :city, :codepos, :first_name, :last_name, 
                  :no_hp, :no_phone, :province, :jenis_kelamin, :tanggal_lahir,
                  :referal, :tipe_identitas, :no_identitas ,:user_id, :referal_id,
                  :address_shipping, :file_ktp, :billing_method, :avatar ,:referral_info#, :file_faktur

  has_attached_file :file_ktp, styles:  { 
                                     :medium => "600x600>", 
                                     :thumb => "100x100>" 
                                    }, 
                                    :default_url => "/assets/no-image.png"

  has_attached_file :avatar, styles:  { 
                                     :medium => "600x600>", 
                                     :thumb => "100x100>" 
                                    }, 
                                    :default_url => "/assets/no-image.png"

   # has_attached_file :file_faktur, styles:  { 
   #                                   :medium => "600x600>", 
   #                                   :thumb => "100x100>" 
   #                                  }, 
   #                                  :default_url => "/assets/no-image.png"
	
	belongs_to :user

  # validates_presence_of   :first_name, :last_name, :city, :address, :no_hp, :province, :jenis_kelamin, :tanggal_lahir,
  #                         :referal, :tipe_identitas, :no_identitas, :address_shipping

  def full_name
    [first_name, last_name].select(&:'present?').join(' ')
  end

  def regional
    [city, province, codepos].select{|r| r.present?}.join(',')
  end

end

