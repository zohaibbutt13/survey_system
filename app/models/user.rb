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

  validates :first_name,
            presence: { message: 'First name must not be blank.' },
            length: { maximum: 150, message: 'First name must not have more than 150 characters.' }
  validates :last_name, 
            presence: { message: 'Last name must not be blank.' },
            length: { maximum: 150, message: 'Last name must not have more than 150 characters.' }

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
end