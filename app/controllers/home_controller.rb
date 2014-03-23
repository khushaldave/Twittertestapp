class HomeController < ApplicationController
  def show
  	@user_timeline=current_user.get_timeline()
  	#@tweets=current_user.search()
  	#@user_followers=current_user.get_followers()
  end
end
