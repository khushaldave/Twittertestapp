class TwittertweetsController < ApplicationController
  def index
  	@tweetssources = Twittertweet.group(:source).count
  	@tweetssources.to_json
  end

  def search
  	hashtag=params[:searchtweet][:hashtag]
  	 @tweets = Twittertweet.where('tweet_text ilike ?', '%' + hashtag + '%' )
  	 @tweetssources = Twittertweet.group(:source).count
    # _data=[]
     #@tweetssources.each do |t|
     #_data  << [t.source,t.count]
     #end
     respond_to do |format|
     format.html {redirect_to @tweets.index}
     format.js 
    end
end

end
