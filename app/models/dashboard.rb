class Dashboard

  def initialize user
    @user = user
  end

  attr_reader :user

  def username
    user.name
  end
  

end
  