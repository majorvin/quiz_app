class QuestionSet::Category < ActiveRecord::Base
  validates :name, :max_question, presence: true

  # has_many :questions, class_name: "QuestionSet::Question", inverse_of: :category

  # accepts_nested_attributes_for :questions, allow_destroy: true

  scope :active, -> { where(archived_at: nil) }
  scope :enabled, -> { where(enable: true) }
  scope :where_name_like, -> (text) { where("name ilike ?", "%#{text}%") }
end