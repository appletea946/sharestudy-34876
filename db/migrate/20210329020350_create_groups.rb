class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :password, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
