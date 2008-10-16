# $Id: login_controller.rb 7 2008-05-30 08:50:28Z davep $

class LoginController < ApplicationController

  before_filter :authorize, :except => :login
  
  # Set the layout.
  layout "main"

  def index
    redirect_to :action => :login
  end
  
  def add_user
    @user = User.new( params[ :user ] )
    if request.post? and @user.save
      flash[ :notice ] = "User #{@user.name} created"
      @user = User.new
    end
  end

  def login
    session[ :user_id ] = nil
    if request.post?
      user = User.authenticate( params[ :name ], params[ :password ] )
      if user
        session[ :user_id ] = user.id
        uri = session[ :original_uri ]
        session[ :original_uri ] = nil
        redirect_to uri || { :controller => :welcome }
      else
        flash[ :notice ] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[ :user_id ] = nil
    flash[ :notice ] = "You have been logged out"
    redirect_to :action => "login"
  end
  
end
