class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :icon
  belongs_to :company, optional: true
  has_many :team_assigns, dependent: :destroy
  has_many :teams, through: :team_assigns, source: :team
  has_many :messages, dependent: :destroy
  has_many :has_tasks, class_name: 'Task', foreign_key: :staff_id, dependent: :nullify
  has_many :has_approved_tasks, class_name: 'Task', foreign_key: :approver_id, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :like_questions, through: :likes, source: :question
  has_many :like_comments, through: :likes, source: :comment

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :validatable, invite_for: 2.weeks

  def self.import(user_params, current_user)
    xlsx = Roo::Excelx.new(user_params.dig(:file).tempfile)
    xlsx.each_row_streaming(offset: 1) do |row|
      User.invite!(employee_number: row[0].value, name: row[1].value, email: row[2].value, company_id: current_user.company_id)
    end
  end
end
