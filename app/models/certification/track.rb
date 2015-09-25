class Certification::Track < ActiveRecord::Base
  validates :name, presence: true

  has_many :users
  has_and_belongs_to_many :categories, class_name: "QuestionSet::Category", join_table: :certification_tracks_categories

  scope :enabled, -> { where(enabled: true) }
end