class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :created_by

      t.timestamps
    end
  end
end
