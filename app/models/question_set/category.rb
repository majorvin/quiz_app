class QuestionSet::Category < ActiveRecord::Base
  validates :name, :max_question, presence: true

  has_many :questions, class_name: "QuestionSet::Question", inverse_of: :category

  has_and_belongs_to_many :tracks, class_name: "Certification::Track", join_table: :certification_tracks_categories

  accepts_nested_attributes_for :questions, allow_destroy: true

  scope :active, -> { where(archived_at: nil) }
  scope :enabled, -> { where(enabled: true) }
  scope :where_name_like, -> (text) { where("name ilike ?", "%#{text}%") }
end