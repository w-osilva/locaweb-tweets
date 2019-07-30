module Twitter
  module Concerns
    module TweetsSort

      def sort_most_relevants(tweets)
        tweets.sort_by do |tweet|
          [
             -tweet["followers_count"].to_i,
             -tweet["retweet_count"].to_i,
             -tweet["favourites_count"].to_i
          ]
        end
      end

      def sort_most_mentions(tweets)
        tweets.sort_by do |tweet|
          [
             -tweet[tweet.keys.first].first["followers_count"].to_i,
             -tweet[tweet.keys.first].first["retweet_count"].to_i,
             -tweet[tweet.keys.first].first["favourites_count"].to_i
          ]
        end
      end

    end
  end
end
