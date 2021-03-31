class CreateLikeUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :like_users do |t|
      t.integer :give_user ,null: false
      t.integer :receive_user ,null: false

      t.timestamps
    end
  end
end
