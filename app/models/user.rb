class User < ActiveRecord::Base
  ROLE = {admin: 'admin', supervisor: 'supervisor', member: 'member'}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  default_scope { where(company_id: Company.current_id) }

  has_many :activities, as: :trackable
  has_many :activities, dependent: :destroy
  belongs_to :company
  has_one :user_setting
  has_many :surveys
  has_and_belongs_to_many :groups

  accepts_nested_attributes_for :company

  validates :first_name, presence: true, length: { maximum: 150 }
  validates :last_name, presence: true, length: { maximum: 150 }

  def admin?
    role == User::ROLE[:admin]
  end

  def supervisor?
    role == User::ROLE[:supervisor]
  end

  def member?
    role == User::ROLE[:member]
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
