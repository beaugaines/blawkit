class FavoriteMailer < ActionMailer::Base
  default from: "beaugaines@yahoo.com"

  def new_comment(user, post, comment)
    @user, @post, @comment = user, post, comment

    headers["Message-ID"] = "<comments/#{@comment.id}@blawkit.com"
    headers["In-Reply-To"] = "<post/#{@post.id}@blawkit.com"
    headers["References"] = "<comments/#{@post.id}@blawkit.com"

    mail(to: @user.email, subject: "New Comment on #{@post.title}")
  end
end
