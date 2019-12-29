class TweetsController < ApplicationController
  before_action :set_twitter_client, only: [:reply, :show]

  def reply
    @reply = @twitter.mentions_timeline
    puts @reply
  end

  # @twitter.mentions_timeline(current_user.nickname,{count:3}).each do |mention|
    
  # end

  # def reply
  #   @twitter.user_timeline(current_user.nickname, { count: 3 } ).each do |timeline|
  #     puts.timeline
  #     @tweet = @twitter.status(timeline.id)
  #     puts @tweet.created_at
  #     puts @tweet.text
  #   end
  # end

  def new
    @tweet = Tweet.new
    @tweet_text = params[:content]
  end
  
  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      # render html: "OK!!!!!"
      flash[:success] = "でけた"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @tweets = Tweet.all
    # @tweets = Tweets.paginate(page: params[:page])
  end

  # def show
  #   @tweet = Tweet.find(params[:id])
  #   @image = @twitter.user.profile_image_url
  # end

  private

  def set_twitter_client
    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_API_KEY"]
      config.consumer_secret     = ENV["TWITTER_API_SECRET_KEY"]
      # config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      # config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
      config.access_token        = current_user.token
      config.access_token_secret = current_user.secret
    end
  end

  def tweet_params
    params.require(:tweet).permit(:comment, :content)
  end
end
