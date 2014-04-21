module Api
	module V1
      class TwittertweetsController < ApplicationController
        before_filter :restrict_access
      	respond_to :json
        def search
  	      hashtag=params[:hashtag]
  	      @tweets = Twittertweet.all.where('tweet_text ilike ?', '%' + hashtag + '%' )
  	     respond_with @tweets
        end

        private
        #def restrict_access
         # api_key = ApiKey.find_by_access_token(params[:access_token])
          #head :unauthorized unless api_key
        #end
        def restrict_access
          authenticate_or_request_with_http_token do |token, options|
            ApiKey.exists?(access_token: token)
          end
        end
       end
    end
end