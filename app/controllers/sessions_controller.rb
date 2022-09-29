class SessionsController < ApplicationController

  def new
  end

  def create
    puts "I ended up here"
    if user = User.authenticate_with_credentials(params[:user][:email], params[:user][:password])
      session[:user_id] = user[:id]
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
