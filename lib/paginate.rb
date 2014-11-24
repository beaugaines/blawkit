module Paginate

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # nb:  this is an instance method b/c the act of extending
    # the recipient class already makes this a class method
    def paginate(params)
      if params[:page].present?
        page = params[:page].to_i - 1
      else
        page = 0
      end
      params[:per_page].present? ? per_page = params[:per_page] : per_page = 5
      limit(per_page).offset(page * per_page)
    end
  end

end
