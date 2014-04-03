class TweetsController < ApplicationController
  def new
  end

  def create
    current_user.tweet(twitter_params[:message])
  end

  def twitter_params
    params.require(:tweet).permit(:message)
  end

  def search
  	@tweets=current_user.search(tweet_params[:hashtag])
    @loc=[]
    @tweets.each do |tweet|
     if(tweet.user.location.present?)
    @loc<<
    {
    :lat => Geocoder.search(tweet.user.location.to_s).first.coordinates.first,
    :lng => Geocoder.search(tweet.user.location.to_s).first.coordinates.last
     }
   else
   end
   end
  end


  def tweet_params
    params.require(:searchtweet).permit(:hashtag)
  end
  
end
