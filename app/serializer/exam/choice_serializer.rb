class Exam::ChoiceSerializer < ActiveModel::Serializer
  attributes :id, :text, :answer

  def answer
    question = object.question
    list = question.list
    return object.answer if list.completed?
  end
end