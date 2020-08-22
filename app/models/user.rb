class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :icon
  has_one :admin_company, class_name: 'Company', foreign_key: :admin_id, dependent: :destroy
  belongs_to :company, optional: true
  has_many :team_assigns, dependent: :destroy
  has_many :teams, through: :team_assigns, source: :team
  has_one :owner_team, class_name: 'Team', foreign_key: :owner_id, dependent: :destroy
  has_many :notifications, through: :teams
  has_many :notification_reads, dependent: :destroy
  has_many :has_read_notifications, through: :notification_reads, source: :notification
  has_many :messages, dependent: :destroy
  has_many :message_reads, dependent: :destroy
  has_many :has_read_messages, through: :message_reads, source: :message
  has_many :has_tasks, class_name: 'Task', foreign_key: :staff_id, dependent: :nullify
  has_many :has_approved_tasks, class_name: 'Task', foreign_key: :approver_id, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :like_questions, through: :likes, source: :question
  has_many :like_comments, through: :likes, source: :comment

  validates :name, presence: true, length: {maximum: 25}
  validates :email, presence: true, length: {maximum: 90},
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation {email.downcase!}
  validates :employee_number, presence: true, length: {maximum: 20}, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :validatable, invite_for: 2.weeks

  def self.guest
    find_or_create_by!(email: "guest@example.com", employee_number: 100001, name: "guest", company_id: 1,) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.import(user_params, current_user)
    xlsx = Roo::Excelx.new(user_params.dig(:file).tempfile)
    xlsx.each_row_streaming(offset: 1) do |row|
      if row[0].present? && row[1].present? && row[2].present?
        User.invite!(employee_number: row[0].value, name: row[1].value, email: row[2].value, company_id: current_user.company_id)
      end
    end
  end
end
