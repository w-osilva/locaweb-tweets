module Twitter
  module Concerns
    module TweetsFormat

      def format_tweet(tweet)
        {
            "screen_name" => tweet["user"]["screen_name"],
            "followers_count" => tweet["user"]["followers_count"],
            "retweet_count" => tweet["retweet_count"],
            "favorite_count" => tweet["user"]["favourites_count"],
            "text" => tweet["text"],
            "created_at" => tweet["created_at"] ,
            "profile_link" => "https://twitter.com/#{tweet["user"]["screen_name"]}",
            "link" => "https://twitter.com/#{tweet["user"]["screen_name"]}/status/#{tweet["id_str"]}"
        }
      end

      def format_most_relevants(tweets)
        tweets.map{ |tweet| format_tweet(tweet) }
      end

      def format_most_mentions(tweets)
        tweets.map{ |tweet| { tweet["user"]["screen_name"].to_s => [format_tweet(tweet)]} }
      end

    end
  end
end