class Company < ActiveRecord::Base
  belongs_to :subscription_package
  has_one :company_setting, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :user_responses, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :surveys, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :options, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :user_settings, dependent: :destroy
  has_many :activities, dependent: :destroy

  after_create do
    CompanySetting.create(
      :max_questions => 100,
      :supervisors_survey_permission => '1',
      :supervisors_settings_permission => '1',
      :members_settings_permission => '1',
      :survey_expiry_days => 5,
      :company_id => self.id)    
  end

  scope :user_companies, -> (email) { Company.joins('INNER JOIN users on users.company_id = companies.id').where("users.email = ?", email) }

  def dashboard_resources(user)
    user_setting = user.user_setting
    company_setting = user.company.company_setting
    [company_setting, user_setting]
  end 

  def filter_surveys(filter_name, options)
    if filter_name == 'name'
      @surveys = surveys.filter_by_name(options[:value])
    end
    @surveys = surveys.where('name LIKE ?', "%#{filters[:name]}%") unless filters[:name].blank?
    @surveys = surveys.where('expiry < ?', filters[:expired_before]) unless filters[:expired_before].blank? 
    @surveys = surveys.where('survey_type = ?', filters[:survey_type]) unless filters[:survey_type].blank?
    @surveys = surveys.where('Date(created_at) = ?', filters[:created_on]) unless filters[:created_on].blank? 
    @surveys = surveys.where('user_id = ?', filters[:created_by_id]) unless filters[:created_by_id].blank?
    
    @surveys  
  end

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 } 
  validates :subdomain, presence: true, uniqueness: true, length: { maximum: 30 }

  def self.current_id=(id)
    Thread.current[:tenant_id] = id
  end

  def self.current_id
    Thread.current[:tenant_id]
  end

end