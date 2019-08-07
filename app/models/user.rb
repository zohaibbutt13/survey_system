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

  accepts_nested_attributes_for :company

  validates :first_name, presence: true, length: { maximum: 150, message: 'must not have more than 150 characters.' }
  validates :last_name, presence: true, length: { maximum: 150, message: 'must not have more than 150 characters.' }

  after_create :create_user_activity
  after_update :update_user_activity
  after_destroy :destroy_user_activity

  has_attached_file :image, styles: { thumb: "50x50>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

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

  def admin_user_id
    User.where("role = ? AND company_id = ?", 'admin', company_id).first.id
  end

  def create_user_activity
    # Admin is created only at time of registration so activity is not created
    unless admin?
      Activity.create(trackable: self, action: 'created', owner_id: admin_user_id,
                    company_id: company_id)
    end
  end

  def update_user_activity
    Activity.create(trackable: self, action: 'updated', owner_id: admin_user_id,
                    company_id: company_id)
  end

  def destroy_user_activity
    Activity.create(trackable: self, action: 'deleted', owner_id: admin_user_id,
                    company_id: company_id)
  end
end
