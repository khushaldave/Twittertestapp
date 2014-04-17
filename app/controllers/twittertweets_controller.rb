class TwittertweetsController < ApplicationController
  def search
  	hashtag=params[:hashtag]
  	 @tweets = Twittertweet.where('tweet_text ilike ?', '%' + hashtag + '%' )
  	   render json: @tweets
  end
end
