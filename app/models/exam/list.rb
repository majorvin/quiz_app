class Exam::List < ActiveRecord::Base
  include Workflow

  belongs_to :category, class_name: "QuestionSet::Category"
  belongs_to :user, class_name: "User"

  has_many :questions, class_name: "Exam::Question", inverse_of: :list

  workflow do
    state :created do
      event :start, :transitions_to => :in_progress
    end

    state :in_progress do
      event :submit, :transitions_to => :completed
    end

    state :completed
  end

  def complete!
    ActiveRecord::Base.transaction do
      self.submit!
      correct_answer = 0

      self.questions.each do |question|
        correct_answer = correct_answer + 1 if question.choices.where(answer: true).first.id == question.value.to_i
      end

      grade = "%.2f" % (correct_answer.to_f / self.questions.count.to_f * 100)
      self.update_attributes({grade: grade, completed_at: Time.now})

      ExamMailer.send_result(self).deliver_now
    end
  end

  def passed?
    self.grade.to_i >= 90
  end

  def self.find_or_create(user, category_id)
    list = self.where("user_id = ? AND category_id = ? AND workflow_state != ?", user.id, category_id, "completed")

    if list.count > 0
      exam = list.first
    else
      exam = generate_exam_for(user, category_id)
    end
  end

  def self.generate_exam_for(current_user, category_id)
    category = QuestionSet::Category.find(category_id)
    max_questions = category.max_question < category.questions.count ? category.max_question : category.questions.count

    ActiveRecord::Base.transaction do
      questions = category.questions.active.order("RANDOM()").limit(max_questions)
      list = self.create(category: category, user: current_user)

      # temporary use loop
      questions.each do |question|
        exam_question = Exam::Question.create(list: list, text: question.text, question_set_question: question)

        question.choices.each do |choice|
          Exam::Choice.create(question: exam_question, text: choice.text, answer: choice.answer)
        end
      end

      list.reload

      return list
    end
  end
end