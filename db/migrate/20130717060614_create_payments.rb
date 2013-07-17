class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount, :line_item_id, :service_id
      t.timestamps
    end
  end
end