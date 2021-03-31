class ArticleGroupRelation < ApplicationRecord
  belongs_to :article
  belongs_to :group
end
