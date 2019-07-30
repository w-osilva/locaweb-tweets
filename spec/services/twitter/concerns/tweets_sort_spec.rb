require 'rails_helper'

describe Twitter::Concerns::TweetsSort, type: :concern do

  let(:service){ Twitter::Tweets.new }

  describe "#sort_most_mentions" do
    let(:tweets) {[
        { "Aaron"  => [{ 'followers_count' => 10, 'retweet_count'=>5, 'favourites_count'=>1 }] },
        { "John"   => [{ 'followers_count' => 10, 'retweet_count'=>5, 'favourites_count'=>2 }] },
        { "Mary"   => [{ 'followers_count' => 10, 'retweet_count'=>10, 'favourites_count'=>5 }] },
        { "Bart"   => [{ 'followers_count' => 10, 'retweet_count'=>15, 'favourites_count'=>5 }] },
        { "Marcus" => [{ 'followers_count' => 15, 'retweet_count'=>5, 'favourites_count'=>10 }] },
    ]}
    it "sort by followers_count, retweet_count, favourites_count" do
      expect(service.sort_most_mentions(tweets)).to be === [
        { "Marcus" => [{ 'followers_count' => 15, 'retweet_count'=>5, 'favourites_count'=>10 }] },
        { "Bart"   => [{ 'followers_count' => 10, 'retweet_count'=>15, 'favourites_count'=>5 }] },
        { "Mary"   => [{ 'followers_count' => 10, 'retweet_count'=>10, 'favourites_count'=>5 }] },
        { "John"   => [{ 'followers_count' => 10, 'retweet_count'=>5, 'favourites_count'=>2 }] },
        { "Aaron"  => [{ 'followers_count' => 10, 'retweet_count'=>5, 'favourites_count'=>1 }] },
      ]
    end
  end

  describe "sort_most_relevants" do
    let(:tweets) {[
        { 'followers_count' => 10, 'retweet_count'=>5, 'favourites_count'=>1 },
        { 'followers_count' => 10, 'retweet_count'=>5, 'favourites_count'=>2 },
        { 'followers_count' => 10, 'retweet_count'=>10, 'favourites_count'=>5 },
        { 'followers_count' => 10, 'retweet_count'=>15, 'favourites_count'=>5 },
        { 'followers_count' => 15, 'retweet_count'=>5, 'favourites_count'=>10 }
    ]}
    it "sort by followers_count, retweet_count, favourites_count" do
      expect(service.sort_most_relevants(tweets)).to be === [
        { 'followers_count' => 15, 'retweet_count'=>5, 'favourites_count'=>10 },
        { 'followers_count' => 10, 'retweet_count'=>15, 'favourites_count'=>5 },
        { 'followers_count' => 10, 'retweet_count'=>10, 'favourites_count'=>5 },
        { 'followers_count' => 10, 'retweet_count'=>5, 'favourites_count'=>2 },
        { 'followers_count' => 10, 'retweet_count'=>5, 'favourites_count'=>1 },
      ]
    end
  end

end