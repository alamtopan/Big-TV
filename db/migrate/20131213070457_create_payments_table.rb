class CreatePaymentsTable < ActiveRecord::Migration
   def up
     create_table :payments do |t|
       t.string    :transaction_no
       t.string    :status
       t.string    :bank_issuer
       t.string    :credit_card
       t.string    :order_id
       t.string    :bank
       t.text      :track_record
       t.text      :access_record
       t.timestamps
     end
   end

   def down
     drop_table :payments
   end
end
