class User < ActiveRecord::Base
  after_create do
    UserSetting.create(
      :emails_subscription => '1',
      :show_graphs => '1',
      :show_history => '1',
      :company_id => self.company_id,
      :user_id => self.id)    
  end

  ROLE = {admin: 'admin', supervisor: 'supervisor', member: 'member'}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  default_scope { where(company_id: Company.current_id) }

  
  has_many :activities, foreign_key: :owner_id, dependent: :destroy
  has_many :activities, as: :trackable
  belongs_to :company
  has_one :user_setting
  has_many :surveys
  has_and_belongs_to_many :groups

  accepts_nested_attributes_for :company

  validates :first_name, presence: true, length: { maximum: 150 }
  validates :last_name, presence: true, length: { maximum: 150 }

  has_attached_file :image, styles: { thumb: "50x50>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def self.count_of_members_and_supervisors?(current_user, member)
    current_supervisors_count = User.where(role: ROLE[:supervisor]).count
    current_memebers_count = User.where(role: ROLE[:member]).count
    max_supervisors = current_user.company.subscription_package.max_supervisors
    max_members = current_user.company.subscription_package.max_members
    (member.supervisor? && current_supervisors_count < max_supervisors) || (member.member? && current_memebers_count < max_members)  
  end

  def admin?
    role == ROLE[:admin]
  end

  def supervisor?
    role == ROLE[:supervisor]
  end

  def member?
    role == ROLE[:member]
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end