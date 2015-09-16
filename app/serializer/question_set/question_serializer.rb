class QuestionSet::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text

  # has_many :choices
end