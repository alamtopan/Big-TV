class Profile < ActiveRecord::Base
  attr_accessible :address, :city, :codepos, :first_name, :last_name, 
                  :no_hp, :no_phone, :province, :jenis_kelamin, :tanggal_lahir,
                  :referal, :tipe_identitas, :no_identitas ,:user_id
	
	belongs_to :user

  def full_name
    [first_name, last_name].select(&:'present?').join(' ')
  end
end
