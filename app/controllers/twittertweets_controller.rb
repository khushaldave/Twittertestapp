class TwittertweetsController < ApplicationController
  def index
  	@tweetssources = Twittertweet.group(:source).count
  	@tweetssources.to_json
  end

  def search
  	hashtag=params[:searchtweet][:hashtag]
  	 @tweets = Twittertweet.where('tweet_text ilike ?', '%' + hashtag + '%' )
  	 @tweetssources = Twittertweet.group(:source).count
  	 @ThisHashSource=Twittertweet.where('tweet_text ilike ?', '%' + hashtag +'%').group(:source).count
    # _data=[]
     #@tweetssources.each do |t|
     #_data  << [t.source,t.count]
     #end
     respond_to do |format|
     format.html {redirect_to @tweets.index}
     format.js 
    end
end
 def getSources
 	@sources=[]
    hashtag=params[:searchtweet][:hashtag]
  	@ThisHashSource=Twittertweet.where('tweet_text ilike ?', '%' + hashtag +'%').group(:source).count
  	@ThisHashSource.each do |key,val|
    @sources<<
    {
    	:source => key,
    	:value => val
    }
end
  	render json: @sources
  end

end
