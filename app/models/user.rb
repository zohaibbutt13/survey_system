class User < ActiveRecord::Base
  after_create do
    UserSetting.create(
      :emails_subscription => '1',
      :show_graphs => '1',
      :show_history => '1',
      :company_id => self.company_id,
      :user_id => self.id)    
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  belongs_to :company
  has_one :user_setting
  has_many :surveys
  has_and_belongs_to_many :groups

  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name, presence: true, length: { maximum: 20 }

  #Image uploading Code for Surveys
  has_attached_file :image, styles: { thumb: "50x50>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def admin?
    role == User::ROLE[:admin]
  end

  def supervisor?
    role == User::ROLE[:supervisor]
  end

  def member?
    role == User::ROLE[:member]
  end

  ROLE = {admin: 'admin', supervisor: 'supervisor', member: 'member'}
end