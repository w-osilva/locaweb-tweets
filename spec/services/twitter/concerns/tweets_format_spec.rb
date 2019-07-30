require 'rails_helper'

describe Twitter::Concerns::TweetsFormat, type: :concern do

  let(:service) {Twitter::Tweets.new}
  let(:response) {VCR.use_cassette("tweeps.locaweb.com.br/tweeps") {Twitter::Api.singleton.get}}
  let(:tweets) {response['statuses']}

  describe "#format_tweet" do
    it "should return a hash with tweet attributes" do
      tweet = tweets.first
      expect(service.format_tweet(tweet)).to include(
                                                 'screen_name' => tweet["user"]["screen_name"],
                                                 'followers_count' => tweet["user"]["followers_count"],
                                                 'retweet_count' => tweet["retweet_count"],
                                                 'favorite_count' => tweet["user"]["favourites_count"],
                                                 'text' => tweet["text"],
                                                 'created_at' => tweet["created_at"],
                                                 'profile_link' => "https://twitter.com/#{tweet["user"]["screen_name"]}",
                                                 'link' => "https://twitter.com/#{tweet["user"]["screen_name"]}/status/#{tweet["id_str"]}",
                                             )
    end
  end


  describe "#format_most_relevants" do
    it "should return an Array of tweets, with default format" do
      expect(service.format_most_relevants(tweets).class).to eql Array
      tweet = tweets.first
      expect(service.format_most_relevants(tweets).first).to include(
                                                                'screen_name' => tweet["user"]["screen_name"],
                                                                'followers_count' => tweet["user"]["followers_count"],
                                                                'retweet_count' => tweet["retweet_count"],
                                                                'favorite_count' => tweet["user"]["favourites_count"],
                                                                'text' => tweet["text"],
                                                                'created_at' => tweet["created_at"],
                                                                'profile_link' => "https://twitter.com/#{tweet["user"]["screen_name"]}",
                                                                'link' => "https://twitter.com/#{tweet["user"]["screen_name"]}/status/#{tweet["id_str"]}",
                                                            )
    end
  end

  describe "#format_most_mentions" do
    it "should return an Array with tweets, with custom format" do
      expect(service.format_most_mentions(tweets).class).to eql Array

      tweet = tweets.first
      expect(service.format_most_mentions(tweets).first).to include(
                                                                 tweet["user"]["screen_name"] => [
                                                                     {
                                                                         'screen_name' => tweet["user"]["screen_name"],
                                                                         'followers_count' => tweet["user"]["followers_count"],
                                                                         'retweet_count' => tweet["retweet_count"],
                                                                         'favorite_count' => tweet["user"]["favourites_count"],
                                                                         'text' => tweet["text"],
                                                                         'created_at' => tweet["created_at"],
                                                                         'profile_link' => "https://twitter.com/#{tweet["user"]["screen_name"]}",
                                                                         'link' => "https://twitter.com/#{tweet["user"]["screen_name"]}/status/#{tweet["id_str"]}",
                                                                     }
                                                                 ]
                                                             )
    end
  end

end