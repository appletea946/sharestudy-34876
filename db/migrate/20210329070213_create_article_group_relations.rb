class CreateArticleGroupRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :article_group_relations do |t|
      t.references :article, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
