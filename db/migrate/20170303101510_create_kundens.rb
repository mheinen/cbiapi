class CreateKundens < ActiveRecord::Migration[5.0]
  def change
    create_table :kundens do |t|
      t.integer :kundenid
      t.string :vorname
      t.string :nachname
      t.integer :kundeseit
      t.integer :umsatz
      t.integer :alter

      t.timestamps
    end
  end
end
