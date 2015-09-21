class User < ActiveRecord::Base
  after_create :send_email_to_admin
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_paranoid

  validates :email, :first_name, :last_name, presence: true

  scope :where_email_like, -> (text) { where("email ilike ?", "%#{text}%") }

  private

  def send_email_to_admin
    SignupMailer.send_notification(self).deliver_now
  end
end
