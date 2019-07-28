module Twitter
  class Tweets

    LOCAWEB_USER_ID = 42

    # rule: tweets that mention Locaweb user
    # rule: tweets that are not reply to Locaweb tweets
    def all
      response = Api.singleton.get
      tweets = filter_locaweb_mentions response["statuses"]
      remove_replies_to_locaweb tweets
    end

    def filter_locaweb_mentions(tweets)
      tweets.select do |tweet|
        tweet.try(:[], 'entities').try(:[], 'user_mentions').try(:first).try(:[], 'id').to_i == LOCAWEB_USER_ID
      end
    end

    def remove_replies_to_locaweb(tweets)
      tweets.reject{ |tweet| tweet["in_reply_to_user_id"].to_i == LOCAWEB_USER_ID }
    end

    def most_relevants
      sort_most_relevants(format_most_relevants(all))
    end

    def most_mentions
      sort_most_mentions(format_most_mentions(all))
    end

    include Concerns::TweetsFormat
    include Concerns::TweetsSort
  end
end
