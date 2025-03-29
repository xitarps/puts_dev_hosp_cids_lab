class CreateCids < ActiveRecord::Migration[8.0]
  def change
    create_table :cids do |t|
      t.string :number
      t.string :description

      t.timestamps
    end
  end
end
