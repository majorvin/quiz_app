class Exam::ListSerializer < ActiveModel::Serializer
  attributes :id, :workflow_state, :name

  has_many :questions

  def name
    object.category.name
  end
end