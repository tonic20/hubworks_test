class AddUniquenessToPayments < ActiveRecord::Migration
  def up
    # if it could be possible remove duplicate data and add unique index on database level

    # remove duplicate payments
    execute %{
      DELETE FROM payments WHERE id IN
        (SELECT payments.id
         FROM payments
         LEFT OUTER JOIN (
            SELECT MIN(id) AS id, service_id, line_item_id
            FROM payments
            GROUP BY service_id, line_item_id
         ) AS a ON payments.id = a.id
         WHERE a.id IS NULL)
    }

    add_index :payments, [:service_id, :line_item_id], unique: true
  end

  def down
    # raise ActiveRecord::IrreversibleMigration, "Can't recover the deleted data"
    remove_index :payments, [:service_id, :line_item_id]
  end
end