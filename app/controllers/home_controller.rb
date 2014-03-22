class HomeController < ApplicationController
  def show
  	@user_timeline=current_user.get_timeline()
  end
end
