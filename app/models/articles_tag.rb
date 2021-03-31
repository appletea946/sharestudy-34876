class ArticlesTag
  include ActiveModel::Model
  attr_accessor :title, :content, :name, :user_id, :group_id

  with_options presence: true do
    validates :title
    validates :content
    validates :name
    validates :user_id
  end

  def save
    article = Article.create(title: title, content: content, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    ArticleTagRelation.create(article_id: article.id, tag_id: tag.id)
    ArticleGroupRelation.create(article_id: article.id, group_id: group_id) if group_id != ''
  end
end
