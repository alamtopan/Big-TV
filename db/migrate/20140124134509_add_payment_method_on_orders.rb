class AddPaymentMethodOnOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_method, :string
    add_column :orders, :charge_fee, :decimal, default: 0
  end

end
