class Exam::Choice < ActiveRecord::Base
  belongs_to :question, class_name: "Exam::Question", inverse_of: :choices
end
