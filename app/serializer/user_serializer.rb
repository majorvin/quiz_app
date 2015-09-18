class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :locked, :first_name, :last_name

  def locked
    !object.deleted_at.nil?
  end
end