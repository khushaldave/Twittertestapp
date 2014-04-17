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
   your_timeline = client.home_timeline
    return your_timeline
  end

def search(hashtag)
   client = Twitter::REST::Client.new do |config|
   config.consumer_key        = Rails.application.config.twitter_key
   config.consumer_secret     = Rails.application.config.twitter_secret
   config.access_token        = oauth_token
   config.access_token_secret = oauth_secret
    end
    geoloc="53.349740,27.256845,10000mi"
    tweets = client.search(hashtag,{:geocode => geoloc ,:lang => "en" , :count => 10 })
    return tweets
  end

def searcht(hashtag)
   client = Twitter::REST::Client.new do |config|
   config.consumer_key        = Rails.application.config.twitter_key
   config.consumer_secret     = Rails.application.config.twitter_secret
   config.access_token        = "104530869-eH4dtBYKv715t86K0vzLf2zAWLEHmrkt7YoZ21G4"
   config.access_token_secret = "UWYk13H2egWESZjcOd7RfB4BGuPiuIk7FDevYZ85QZZVt"
    end
    geoloc="53.349740,27.256845,10000mi"
    tweets = client.search(hashtag,{:geocode => geoloc ,:lang => "en" , :count => 10 })
    return tweets
  end

def get_followers()
   client = Twitter::REST::Client.new do |config|
   config.consumer_key        = Rails.application.config.twitter_key
   config.consumer_secret     = Rails.application.config.twitter_secret
   config.access_token        = oauth_token
   config.access_token_secret = oauth_secret
    end
    your_followers = client.followers
    return your_followers
  end

end