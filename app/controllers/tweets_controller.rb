class TweetsController < ApplicationController
  before_action :set_twitter_client#, only: [:reply, :show, :response]

  def reply
    @reply = @twitter.mentions_timeline
    puts @reply
  end

  def new
    @tweet = Tweet.new
    @tweet_text = params[:content]
  end
  
  def create
    @tweet = current_user.tweets.build(tweet_params)
    @tweet.picture = TweetsHelper.build(@tweet.content)
    @tweet.save
    flash[:success] = "でけた"
    @twitter.update_with_media("#{@tweet.comment}", "#{@tweet.picture.path}")
    redirect_to @tweet
  end

  def test
    # images = []
    # images << File.new('./public/uploads/tweet/picture/12/mini_magick20200118-57398-148xxil.png')

    # res = @twitter.update_with_media("test #{Time.now}", images)
    # puts res
  end


  def index
    @tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  private

    def set_twitter_client
      @twitter = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET_KEY"]
        config.access_token        = current_user.token
        config.access_token_secret = current_user.secret
      end
    end

    def tweet_params
      params.require(:tweet).permit(:comment, :content, :picture)
    end

end
