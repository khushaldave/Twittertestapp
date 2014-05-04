class TweetsController < ApplicationController
  skip_before_filter :verify_authenticity_token
 rescue_from Exception, :with => :render_404
  def new
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
    hashtag=params[:hashtag]
    client = Twitter::REST::Client.new do |config|
    config.consumer_key        = Rails.application.config.twitter_key
    config.consumer_secret     = Rails.application.config.twitter_secret
    config.access_token        = current_user.oauth_token
    config.access_token_secret = current_user.oauth_secret
    end
    geoloc="53.349740,27.256845,10000mi"
    @tweets = client.search(hashtag,{:geocode => geoloc ,:lang => "en" , :count => 5 })
    @tweet=[]
    @twittertweet=[]
    @tweets.each do |tweet|
      if(tweet.user.location.present?)
          source=tweet.source.dup
          lattitude=Geocoder.search(tweet.user.location.to_s).first.coordinates.first
          longitude=Geocoder.search(tweet.user.location.to_s).first.coordinates.last
          @tweet<<
            {
              :location => tweet.user.location,
              :text => tweet.text,
              :profile_pic => tweet.user["profile_image_url"],
              :status_count => tweet.user.statuses_count,
              :friends_count => tweet.user.friends_count,
              :lat => lattitude,
              :lng => longitude,
              :Source => ActionController::Base.helpers.strip_tags(source),
              :retweet_count =>tweet.retweet_count,
              :tweet_id => tweet.id
            }
             @twittertweet<<
            {
              :location => tweet.user.location,
              :tweet_text => tweet.text,
              :profile_pic => tweet.user["profile_image_url"].to_s,
              :status_count => tweet.user.statuses_count,
              :friends_count => tweet.user.friends_count,
              :lattitude => lattitude,
              :longitude => longitude,
              :source => ActionController::Base.helpers.strip_tags(source),
                 #adding more parameters
                 :retweet_count =>tweet.retweet_count,
                 :tweet_id => tweet.id
                # remove coloumns if you want
            }
     
      else
      end
    end
     @twittertweet.each do |t|
      @tt=Twittertweet.new(t)
      @tt.save
    end
   end

private

  def render_404(exception = nil)
    logger.info "Exception, redirecting: #{exception.message}" if exception
    flash[:notice] = "Sorry an error has occured"
    redirect_to root_path
   end
 

end
 