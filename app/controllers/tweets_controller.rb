class TweetsController < ApplicationController
  def create
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)
    
    if session
      user = session.user
      @tweet = user.tweet.new(tweet_params)

      if tweet.save
        render 'tweets/create'
      else
        render json: { success: false}
      end
    else
      render json: { success: false}
    end    
  end

  def destroy
    @tweet = Tweet.find_by(id: params[:id])
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      if user == tweet.user
        tweet.destroy
      end
    end

  end

  def index
    @tweets = Tweet.all
  end

  def index_by_user
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      @tweets = session.user.tasks
    else
      render json: { tasks: [] }
    end

  end

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end

end
