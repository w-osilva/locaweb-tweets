module TweetsHelper

  def extract_tweet(tweet, format: '')
    case format
    when 'most_mentions' then tweet
    when 'most_relevants' then tweet[tweet.keys.first].first
    else raise ArgumentError, 'format is invalid'
    end
  end

end