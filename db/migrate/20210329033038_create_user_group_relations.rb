class CreateUserGroupRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_group_relations do |t|
      t.references :user, null: false, presence: true
      t.references :group, null: false, presence: true

      t.timestamps
    end
  end
end
