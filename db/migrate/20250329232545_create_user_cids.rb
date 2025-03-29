class CreateUserCids < ActiveRecord::Migration[8.0]
  def change
    create_table :user_cids do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cid, null: false, foreign_key: true
      t.datetime :first_diagnosed_at

      t.timestamps
    end
  end
end
