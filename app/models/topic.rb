class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public
  has_many :posts, dependent: :destroy

  default_scope order('created_at DESC')

  scope :visible_to, lambda { |user| user ? scoped : where(public: true) }

  def self.paginate(params)
    if params[:page].present?
      page = params[:page].to_i - 1
    else
      page = 0
    end
    params[:per_page].present? ? per_page = params[:per_page] : per_page = 5
    limit(per_page).offset(page.to_i * per_page)
  end


end
