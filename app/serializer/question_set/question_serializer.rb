class QuestionSet::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text

  has_many :choices

  def choices
    object.choices.order("id")
  end
end