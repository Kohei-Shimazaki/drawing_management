class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :company
  has_many :has_tasks, class_name: 'Task', foreign_key: :staff_id
  has_many :has_approved_tasks, class_name: 'Task', foreign_key: :approver_id

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :validatable, invite_for: 2.weeks

  def self.import(user)
    xlsx = Roo::Excelx.new(user.dig(:file).tempfile)
    xlsx.each_row_streaming(offset: 1) do |row|
      User.invite!(employee_number: row[0].value, name: row[1].value, email: row[2].value)
    end
  end
end
