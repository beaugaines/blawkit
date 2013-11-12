class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # members can manage own posts
    if user.role? :member
        can :manage, Post, user_id: user.id 
        can :manage, Comment, user_id: user.id 
        can :create, Vote
    end

    # mods can delete any post
    if user.role? :moderator
        can :destroy, Post
        can :destroy, Comment
    end

    # admin = God
    if user.role? :admin
        can :manage, :all
    end

    can :read, :all
  end
end
