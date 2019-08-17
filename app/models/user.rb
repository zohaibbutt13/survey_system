class User < ActiveRecord::Base
  after_create do
    UserSetting.create(
      :emails_subscription => '1',
      :show_graphs => '1',
      :show_history => '1',
      :company_id => self.company_id,
      :user_id => self.id)    
  end

  ROLE = { admin: 'admin', supervisor: 'supervisor', member: 'member' }

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
  has_many :user_responses

  accepts_nested_attributes_for :company
  
  #Make a scope of email uniqness within company 
  validates :email, uniqueness: { scope: :company_id }
  validates_presence_of :email
  validates_format_of :email, with: email_regexp

  validates :first_name, presence: true, length: { maximum: 150, message: 'must not have more than 150 characters.' }
  validates :last_name, presence: true, length: { maximum: 150, message: 'must not have more than 150 characters.' }

  #Commented for Test Cases
  after_create :create_user_activity
  after_update :update_user_activity
  after_destroy :destroy_user_activity

  has_attached_file :image, styles: { thumb: "50x50>" }  
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def self.count_of_members_and_supervisors?(company, user)
    current_supervisors_count = company.users.where(role: ROLE[:supervisor]).count
    current_members_count = company.users.where(role: ROLE[:member]).count
    max_supervisors = company.subscription_package.max_supervisors
    max_members = company.subscription_package.max_members
    (user.supervisor? && current_supervisors_count < max_supervisors) || (user.member? && current_members_count < max_members)  
  end

  def email_required?
    false
  end

  def email_changed?
    false
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

  def count_surveys
    count = User.joins(groups: :surveys)
    .select("surveys.id as id, surveys.name as name")
    .where("groups_users.user_id = ? and surveys.expiry > ?", id, DateTime.now )
  end

  def admin_user_id
    company.users.find_by(role: 'admin').id
  end

  def create_user_activity
    # Admin is created only at time of registration so activity is not created
    unless admin?
      Activity.create(trackable: self, action: 'created', owner_id: admin_user_id, company_id: company_id)
    end
  end

  def update_user_activity
    Activity.create(trackable: self, action: 'updated', owner_id: admin_user_id, company_id: company_id)
  end

  def destroy_user_activity
    Activity.create(trackable: self, action: 'deleted', owner_id: admin_user_id, company_id: company_id)
  end
end