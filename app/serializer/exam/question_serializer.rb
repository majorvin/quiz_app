class Exam::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text, :value

  has_many :choices

  def choices
    object.choices.order("id")
  end
end