class CreateTwittertweets < ActiveRecord::Migration
  def change
    create_table :twittertweets do |t|
      t.string :tweet_id
      t.string :profile_pic
      t.integer :friends_count
      t.integer :status_count
      t.string :tweet_text
      t.float :lattitude
      t.float :longitude
      t.string :source
      t.integer :retweet_count
      t.string :location

      t.timestamps
    end
  end
end
