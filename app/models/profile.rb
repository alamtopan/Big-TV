class Profile < ActiveRecord::Base
  # Attributess dari model profile
  attr_accessible :address, :city, :codepos, :first_name, :last_name, 
                  :no_hp, :no_phone, :province, :jenis_kelamin, :tanggal_lahir,
                  :referal, :tipe_identitas, :no_identitas ,:user_id, :referal_id,
                  :address_shipping, :file_ktp, :billing_method, :avatar ,:referral_info#, :file_faktur

  has_attached_file :file_ktp, styles:  { 
                                     :medium => "600x600>", 
                                     :thumb => "100x100>" 
                                    }, 
                                    :default_url => "/assets/no-image.png" # role field file ktp

  has_attached_file :avatar, styles:  { 
                                     :medium => "600x600>", 
                                     :thumb => "100x100>" 
                                    }, 
                                    :default_url => "/assets/no-image.png" # role field avatar

   # has_attached_file :file_faktur, styles:  { 
   #                                   :medium => "600x600>", 
   #                                   :thumb => "100x100>" 
   #                                  }, 
   #                                  :default_url => "/assets/no-image.png"
	
	belongs_to :user

  # validates_presence_of   :first_name, :last_name, :city, :address, :no_hp, :province, :jenis_kelamin, :tanggal_lahir,
  #                         :referal, :tipe_identitas, :no_identitas, :address_shipping
  # Fungsi tambahan
  def full_name
    [first_name, last_name].select(&:'present?').join(' ')
  end

  def regional
    [city, province, codepos].select{|r| r.present?}.join(',')
  end

  def name_first
    full_name.split(' ').first
  end

  def name_last
    full_name.split(' ').last
  end

  def billing_method_code
    billing_method.to_s.downcase === "email" ? "E" : "P"
  end

end

