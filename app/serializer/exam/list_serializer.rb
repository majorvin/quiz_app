class Exam::ListSerializer < ActiveModel::Serializer
  attributes :id, :workflow_state, :name, :grade, :completed_at

  has_many :questions

  def name
    object.category.name
  end

  def questions
    object.questions.order("RANDOM()")
  end
end