class TweetsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def new
  end

  def create
    current_user.tweet(twitter_params[:message])
 
  end

  def twitter_params
    params.require(:tweet).permit(:message)
  end

  def searh
    @tweets=current_user.searcht(:hashtag)
   # if @tweet.nil?
    #  flash.now[:notice] = "Soory no tweets Found !"
     #  render "search"
     #end
      @tweet=[]
      @tweets.each do |tweet|
      if(tweet.user.location.present?)
          source=tweet.source.dup
          @tweet<<
            {
              :location => tweet.user.location,
              :text => tweet.text,
              :profile_pic => tweet.user["profile_image_url"],
              :status_count => tweet.user.statuses_count,
              :friends_count => tweet.user.friends_count,
              :lat => Geocoder.search(tweet.user.location.to_s).first.coordinates.first,
              :lng => Geocoder.search(tweet.user.location.to_s).first.coordinates.last,
              :Source => ActionController::Base.helpers.strip_tags(source)
            }
      else
      end
    end
    render json: @tweet
  end

  def search
    @tweets=current_user.search(tweet_params[:hashtag])
   # if @tweet.nil?
    #  flash.now[:notice] = "Soory no tweets Found !"
     #  render "search"
     #end
      @tweet=[]
      @tweets.each do |tweet|
      if(tweet.user.location.present?)
          source=tweet.source.dup
          @tweet<<
            {
              :location => tweet.user.location,
              :text => tweet.text,
              :profile_pic => tweet.user["profile_image_url"],
              :status_count => tweet.user.statuses_count,
              :friends_count => tweet.user.friends_count,
              :lat => Geocoder.search(tweet.user.location.to_s).first.coordinates.first,
              :lng => Geocoder.search(tweet.user.location.to_s).first.coordinates.last,
              :Source => ActionController::Base.helpers.strip_tags(source)
            }
      else
      end
    end
   end


  def tweet_params
    params.require(:searchtweet).permit(:hashtag)
  end
  
end
