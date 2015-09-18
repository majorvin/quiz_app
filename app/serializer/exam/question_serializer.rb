class Exam::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :text, :value

  has_many :choices
end