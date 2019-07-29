class TweetsController < ApplicationController
  before_action :set_request_format
  before_action :set_tweets_service

  def most_mentions
    @tweets = @tweets_service.most_mentions
    render_tweets
  end

  def most_relevants
    @tweets = @tweets_service.most_relevants
    render_tweets
  end

  private
  def set_request_format
    request.format = :json if request.content_type == "application/json"
  end

  def set_tweets_service
    @tweets_service ||= Twitter::Tweets.new
  end

  def render_tweets
    respond_to do |format|
      format.html
      format.json { render :json => @tweets }
    end
  end
end
