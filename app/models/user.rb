class User < ActiveRecord::Base
  after_create :before_create_user
  #before_create :create_login
  attr_accessor :login
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :authentication_keys => [:login]

  validates :username, uniqueness: true, length: { maximum: 10}

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  #def create_login
    #email = self.email.split(/@/)
    #login_taken = User.where( :login => email[0]).first
    #unless login_taken
      #self.login = email[0]
    #else
      #self.login = self.email
    #end
  #end

  protected
  def confirmation_required?
    true
  end

  private
  def before_create_user
    add_role :registered
  end
end
