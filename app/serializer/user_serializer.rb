class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :locked

  def locked
    !object.deleted_at.nil?
  end
end