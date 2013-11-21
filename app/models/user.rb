class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  include Gravtastic
  gravtastic

  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  before_create :set_member

  mount_uploader :avatar, AvatarUploader

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation,
    :remember_me, :role, :avatar, :current_password, :email_favorites

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

  # Devise hack to allow edit of registrations without changing password
  attr_accessor :current_password

  def update_with_password(params={}) 
    current_password = params.delete(:current_password)

    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation)
    end 
    update_attributes(params) 

    clean_up_passwords
  end

  def favorited post
    favorites.find_by_post_id(post.id)
  end

  def voted post
    votes.find_by_post_id(post.id)
  end

  def posts_count
    posts.count
  end
  
  def comments_count
    comments.count
  end

  def self.top_rated
    self.select('users.*').
    select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank').
    joins(:posts).
    joins(:comments).
    group('users.id').
    order('rank DESC')
  end
  
  private
  
  def set_member
    self.role = 'member'
  end

end
