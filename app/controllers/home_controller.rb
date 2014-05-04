class HomeController < ApplicationController
 
  def index
  end
  def show
  	@user_timeline=current_user.get_timeline()
  	#@tweets=current_user.search()
  	#@user_followers=current_user.get_followers()
  end
def contact_us
end
def about_us
end

def plans
end

def subscribe
	flash[:notice] = "You have successfully subscribed to this plan."
	redirect_to root_url
end

def contactthank
	flash[:notice] = "Thanks for Contacting! We will contact you within 24 hours."
	redirect_to root_url
end

def help
  end
end
