# $Id: application.rb 11 2008-05-30 10:15:08Z davep $

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'd1bc1228c7e17858b4400cc5429abe8f'

  session :session_key => "_packman_session_id"

  private

  # Checks that the user is logged in and, if not, saves the
  # target URL and redirects them to the login page.
  def authorize
    unless User.find_by_id( session[ :user_id ] )
      session[ :original_uri ] = request.request_uri
      flash[ :notice ] = "Please log in"
      redirect_to :controller => :login, :action => :login
    end
  end
  
end
