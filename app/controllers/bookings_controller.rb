# $Id: bookings_controller.rb 21 2008-05-30 21:34:31Z davep $

class BookingsController < ApplicationController

  # Add some security.
  before_filter :authorize, :except => [ :index, :show, :overdue, :despatched, :feed, :timeline ]
  
  # Set the layout.
  layout "main", :except => [ :feed, :timeline ]

  # GET /bookings
  # GET /bookings.xml
  # GET /bookings.json
  # GET /bookings.yaml
  def index

    respond_to do |format|
      format.html { @booking_pages, @bookings = paginate( Booking, :order_by => "expected_pickup", :conditions => Booking.waiting_pickup_condition ) }
      format.xml  { render :xml  => Booking.find_waiting_pickup.to_xml }
      format.json { render :json => Booking.find_waiting_pickup.to_json }
      format.yaml { render :text => Booking.find_waiting_pickup.to_yaml }
    end
    
  end

  # GET /bookings/overdue
  # GET /bookings/overdue.xml
  # GET /bookings/overdue.json
  # GET /bookings/overdue.yaml
  def overdue

    respond_to do |format|
      format.html {
        @booking_pages, @bookings = paginate( Booking, :order_by => "expected_pickup", :conditions => Booking.overdue_condition )
        @title_other = "Overdue Bookings"
        render :template => "bookings/index"
      }
      format.xml  { render :xml  => Booking.find_overdue.to_xml }
      format.json { render :json => Booking.find_overdue.to_json }
      format.yaml { render :text => Booking.find_overdue.to_yaml }
    end
    
  end

  # GET /bookings/despatched
  # GET /bookings/despatched.xml
  # GET /bookings/despatched.json
  # GET /bookings/despatched.yaml
  def despatched

    respond_to do |format|
      format.html {
        @booking_pages, @bookings = paginate( Booking, :order_by => "despatched_when desc", :conditions => Booking.despatched_condition )
        @title_other = "Despatched Bookings"
        render :template => "bookings/index"
      }
      format.xml  { render :xml  => Booking.find_despatched.to_xml }
      format.json { render :json => Booking.find_despatched.to_json }
      format.yaml { render :text => Booking.find_despatched.to_yaml }
    end
    
  end

  # GET /bookings/feed
  # GET /bookings/feed.rss
  def feed
    @bookings = Booking.find_waiting_pickup
    respond_to do |format|
      format.rss
    end
  end

  # GET /bookings/timeline
  # GET /bookings/timeline.xml
  def timeline
    @bookings = Booking.find_waiting_pickup
    respond_to do |format|
      format.xml
    end
  end

  # GET /bookings/1
  # GET /bookings/1.xml
  # GET /bookings/1.json
  # GET /bookings/1.yaml
  def show
  
    @booking = Booking.find( params[ :id ] )

    respond_to do |format|
      format.html
      format.xml  { render :xml  => @booking.to_xml }
      format.json { render :json => @booking.to_json }
      format.yaml { render :text => @booking.to_yaml }
    end
    
  end
  
  # GET /bookings/new
  def new
    @booking = Booking.new
    @booking.booked_when     = Time.now
    @booking.expected_pickup = @booking.booked_when + 1.hour
  end

  # GET /bookings/1/edit
  def edit
    @booking = Booking.find( params[ :id ] )
  end

  # POST /bookings
  # POST /bookings.xml
  def create
    
    if params[ :cancel ]
      flash[ :notice ] = "New booking cancelled"
      redirect_to bookings_url
    else

      @booking = Booking.new( params[ :booking ] )

      respond_to do |format|
        if @booking.save
          flash[ :notice ] = "New booking saved"
          format.html { redirect_to bookings_url }
          format.xml { } # TODO: What should I return here?
        else
          format.html { render:action => "new" }
          format.xml { render :xml => @booking.errors.to_xml }
        end
      end
      
    end
    
  end

  # GET /bookings/1/despatch
  def despatch
    if ( @booking = Booking.find( params[ :id ] ) )
      @booking.despatched_when = Time.now
    end
  end

  # PUT /bookings/1
  # PUT /bookings/1.xml
  def update

    if params[ :cancel ]
      flash[ :notice ] = "Booking edit cancelled"
      redirect_to bookings_url( :page => params[ :source_page ] )
    else
      
      @booking = Booking.find( params[ :id ] )
      
      respond_to do |format|
        if @booking.update_attributes( params[ :booking ] )
          format.html {
            flash[ :notice ] = @booking.despatched? ? "Booking despatched" : "Booking updated"
            redirect_to bookings_url( :page => params[ :source_page ] )
          }
          format.xml { render :nothing => true }
        else
          format.html { render :action => @booking.despatched? ? "despatch" : "edit" }
          format.xml  { render :xml => @booking.errors.to_xml }
        end
      end
      
    end
    
  end

end
