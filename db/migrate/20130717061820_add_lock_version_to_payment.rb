class AddLockVersionToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :lock_version, :integer, default: 0
  end
end