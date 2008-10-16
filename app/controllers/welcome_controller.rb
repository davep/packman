# $Id: welcome_controller.rb 7 2008-05-30 08:50:28Z davep $

class WelcomeController < ApplicationController

  # Set the layout.
  layout "main"

  # GET /welcome
  def index
    respond_to do |format|
      format.html
      format.wml { render :layout => false }
    end
  end

  # Renders the current situation details.
  def current_situation
    render :partial => "current_situation"
  end
  
end
