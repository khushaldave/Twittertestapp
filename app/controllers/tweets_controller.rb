class TweetsController < ApplicationController
  skip_before_filter :verify_authenticity_token
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
    @tweets=current_user.search(hashtag)
   # if @tweet.nil?
    #  flash.now[:notice] = "Soory no tweets Found !"
     #  render "search"
     #end
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

end
