class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # NB:  when you pass the hash - user_id: in this case - it
    # restricts the records to which the permission applies - 
    # in this case to objects the user owns. You can only
    # use columns in the db for these conditions
    
    if user.role? :member
        can :manage, Post, user_id: user.id 
        can :manage, Comment, user_id: user.id 
        can :create, Vote
        can :create, Favorite, user_id: user.id
    end

    # mods can delete any post
    if user.role? :moderator
        can :destroy, Post
        can :destroy, Comment
        # exmaple of how to use blocks in cancan
        #can :edit, Wiki do |wiki|
            #user.wikis.editable_by_user.include?(wiki)
        #end
    end

    # admin = God
    if user.role? :admin
        can :manage, :all
    end

    can :read, Topic, public: true
    can :read, Post
  end
end
