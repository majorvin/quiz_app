class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_paranoid

  validates :email, :first_name, :last_name, presence: true

  scope :where_email_like, -> (text) { where("email ilike ?", "%#{text}%") }
end
