class QuestionSet::CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :enabled, :max_question

  has_many :questions
end