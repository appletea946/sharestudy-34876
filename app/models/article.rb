class Article < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :article_tag_relations
  has_many :tags, through: :article_tag_relations
  has_many :like_articles
  has_many :article_group_relations
  has_many :groups, through: :article_group_relations

  def self.search(switch = 'false', tag_id = '', keyword = '', current_user_id)
    result_sql = 'SELECT * FROM articles'
    if switch == 'false' && tag_id.empty? && keyword.empty?
      result_sql += ' ORDER BY created_at DESC'
    else
      add_sql = ['', '', '']
      add_sql[0] = 'id IN (SELECT article_id FROM like_articles WHERE user_id = :current_user_id)' if switch == 'true'

      add_sql[1] = 'id IN (SELECT article_id FROM article_tag_relations WHERE tag_id = :tag_id)' unless tag_id.empty?

      add_sql[2] = 'title LIKE :keyword' unless keyword.empty?
      add_sql = add_sql.reject { |item| item.empty? }
      result_sql = result_sql + ' WHERE ' + add_sql.join(' AND ') + ' ORDER BY created_at DESC'
    end
    Article.find_by_sql([result_sql, { tag_id: tag_id, keyword: "%#{keyword}%", current_user_id: current_user_id }])
  end
end
