class CreateLoads < ActiveRecord::Migration
  def change
    create_table :loads do |t|
      t.string :origin_location, null: false
      t.string :customer_name, null: false
      t.string :customer_location, null: false
      t.string :carrier_name
      t.string :driver_name
      t.string :truck_number

      t.integer :order_number, null: false
      t.string :product_description, null: false
      t.datetime :requested_date, null: false
      t.datetime :ship_date
      t.string :status, default: 'new', null: false

      weight_columns t

      t.datetime :deleted_at
      t.timestamps null: false
    end
  end

  def weight_columns(table)
    table.integer :weight_tare
    table.integer :weight_gross
    table.integer :weight_net
  end
end
