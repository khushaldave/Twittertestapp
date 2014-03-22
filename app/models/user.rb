class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save!
    end
  end

  def tweet(tweet)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.config.twitter_key
      config.consumer_secret     = Rails.application.config.twitter_secret
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    
    client.update(tweet)
  end

  def get_timeline()
   client = Twitter::REST::Client.new do |config|
   config.consumer_key        = Rails.application.config.twitter_key
   config.consumer_secret     = Rails.application.config.twitter_secret
   config.access_token        = oauth_token
   config.access_token_secret = oauth_secret
    end
    
    # read user's timeline by id
    #timeline = client.user_timeline id

    # read user's timeline of yours
    your_timeline = client.user_timeline
    return your_timeline
  end
end