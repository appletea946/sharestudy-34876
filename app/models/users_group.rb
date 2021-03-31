class UsersGroup
  include ActiveModel::Model
  attr_accessor :name, :password, :user_id

  with_options presence: true do
    validates :name
    validates :password
    validates :user_id
  end

  def save
    group = Group.create(name: name, password: password, user_id: user_id)
    UserGroupRelation.create(group_id: group.id, user_id: user_id)
  end
end
