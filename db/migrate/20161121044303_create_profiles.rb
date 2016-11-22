class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :guest, index: true, foreign_key: true
      t.string :name
      t.string :address
      t.integer :zipcode
      t.string :phone
      t.text :bio

      t.timestamps null: false
    end
  end
end
