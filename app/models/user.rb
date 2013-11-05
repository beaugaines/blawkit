class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :posts
  has_many :comments

  before_create :set_member

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :role
  # attr_accessible :title, :body

  validates :email, presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create },
    uniqueness: { case_sensitive: false }

  validates :username, presence: true,
    length: { in: 4..15 }

  # cancan roles
  ROLES = %w(member moderator admin)

  def role?(base_role)
    role.nil? ? false : ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  private
  
  def set_member
    self.role = 'member'
  end

end
