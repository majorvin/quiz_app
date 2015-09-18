class QuestionSet::CategoryAvailableSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_grade, :attempts

  def attempts
    exams = Exam::List.where("user_id = ? AND category_id = ?", scope.id, object.id)
    exams.count
  end

  def last_grade
    exams = Exam::List.where("user_id = ? AND category_id = ?", scope.id, object.id)

    exams.order("id ASC").last.grade.to_f if exams.count > 0
  end
end