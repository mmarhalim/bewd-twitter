class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && (BCrypt::Password.new(@user.password) == params[:user][:password])
      session = @user.sessions.create
      cookies.permanent.signed[:twitter_session_token] = {
        value: session.token,
        httponly: true
      }

      render 'sessions/create'
    else
      render json: {
        success: false
      }
    end
  end

  def authenticated
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      @user = session.user
      render 'sessions/authenticated'
    else
      render json: {
        authenticated: false
      }
    end
  end

  def destroy
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session&.destroy
      render json: {
        success: true
      }
    end
  end
  
end