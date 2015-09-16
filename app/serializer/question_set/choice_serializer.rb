class QuestionSet::ChoiceSerializer < ActiveModel::Serializer
  attributes :id, :text, :answer
end