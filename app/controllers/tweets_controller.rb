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
  	@tweet=current_user.search(tweet_params[:hashtag])
  end


  def tweet_params
    params.require(:searchtweet).permit(:hashtag)
  end
  
end
