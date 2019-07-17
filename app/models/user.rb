class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  belongs_to :company
  has_one :user_setting
  has_many :surveys
  has_many :group_members

  validates :first_name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :last_name, presence: true, uniqueness: true, length: { maximum: 20 }
end
