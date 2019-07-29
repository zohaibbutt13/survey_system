class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :activities, as: :trackable
  has_many :activities, dependent: :destroy
  belongs_to :company
  has_one :user_setting
  has_many :surveys
  has_and_belongs_to_many :groups

  validates :first_name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :last_name, presence: true, uniqueness: true, length: { maximum: 20 }

  ROLE = { admin: 'admin', supervisor: 'supervisor', member: 'member' }
end
