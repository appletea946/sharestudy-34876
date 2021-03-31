class Group < ApplicationRecord
  has_many :user_group_relations, dependent: :destroy
  has_many :users, through: :user_group_relations
  has_many :article_group_relations
  has_many :articles, through: :article_group_relations

  def self.search(switch = 'false', keyword = '', current_user_id)
    result_sql = 'SELECT * FROM groups'
    if switch == 'false' && keyword.empty?
      result_sql += ' ORDER BY created_at DESC'
    else
      add_sql = ['', '']
      add_sql[0] = 'id IN (SELECT group_id FROM user_group_relations WHERE user_id = :current_user_id)' if switch == 'true'

      add_sql[1] = 'name LIKE :keyword' unless keyword.empty?
      add_sql = add_sql.reject { |item| item.empty? }
      result_sql = result_sql + ' WHERE ' + add_sql.join(' AND ') + ' ORDER BY created_at DESC'
    end
    Group.find_by_sql([result_sql, { keyword: "%#{keyword}%", current_user_id: current_user_id }])
  end
end
