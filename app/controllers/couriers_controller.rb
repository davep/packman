# $Id: couriers_controller.rb 24 2008-06-01 20:04:39Z davep $

class CouriersController < ApplicationController

  # Add some security.
  before_filter :authorize, :except => [ :index, :show, :find ]
  
  # Set the layout.
  layout "main"

  # GET /articles
  # GET /articles.xml
  # GET /articles.json
  # GET /articles.yaml
  def index

    respond_to do |format|
      format.html { @courier_pages, @couriers = paginate( Courier, :order => "name" ) }
      format.xml  { render :xml  => Courier.find_all.to_xml }
      format.json { render :json => Courier.find_all.to_json }
      format.yaml { render :text => Courier.find_all.to_yaml }
    end
    
  end

  # GET /couriers/1
  # GET /couriers/1.xml
  # GET /couriers/1.json
  # GET /couriers/1.yaml
  def show

    @courier = Courier.find( params[ :id ] )

    respond_to do |format|
      format.html
      format.xml  { render :xml  => @courier.to_xml }
      format.json { render :json => @courier.to_json }
      format.yaml { render :text => @courier.to_yaml }
    end
    
  end

  # GET /couriers/find/:id
  # GET /couriers/find/:id.xml
  # GET /couriers/find/:id.json
  # GET /couriers/find/:id.yaml
  def find
    if params[ :id ].nil?
      redirect_to :action => :index
    elsif request.post?
      redirect_to :action => :find, :id => params[ :id ]
    else
      respond_to do |format|
        format.html {
          @courier_pages, @couriers = paginate( Courier, :order => "name", :conditions => Courier.name_condition( params[ :id ] ) )
          if @couriers.length == 0
            flash[ :notice ] = "No matching couriers found"
            redirect_to :action => :index
          else
            render :template => "couriers/index"
          end
        }
        format.xml  { render :xml  => Courier.find_by_name( params[ :id ] ).to_xml }
        format.json { render :json => Courier.find_by_name( params[ :id ] ).to_json }
        format.yaml { render :text => Courier.find_by_name( params[ :id ] ).to_json }
      end
    end
  end

  # GET /couriers/new
  def new
    @courier = Courier.new
  end

  # GET /couriers/1/edit
  def edit
    @courier = Courier.find( params[ :id ] )
  end
  
  # POST /couriers
  # POST /couriers.xml
  def create

    if params[ :cancel ]
      flash[ :notice ] = "New courier cancelled"
      redirect_to couriers_url
    else
      @courier = Courier.new( params[ :courier ] )
      
      respond_to do |format|
        if @courier.save
          flash[ :notice ] = "New courier created"
          format.html { redirect_to couriers_url }
          format.xml { } # TODO: What should I return here?
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @courier.errors.to_xml }
        end
      end
    end
    
  end

  # PUT /couriers/1
  # PUT /couriers/1.xml
  def update

    if params[ :cancel ]
      flash[ :notice ] = "Courier edit cancelled"
      redirect_to couriers_url( :page => params[ :source_page ] )
    else
      @courier = Courier.find( params[ :id ] )
      
      respond_to do |format|
        if @courier.update_attributes( params[ :courier ] )
          format.html {
            flash[ :notice ] = "Courier updated"
            redirect_to couriers_url( :page => params[ :source_page ] )
          }
          format.xml { render :nothing => true }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @courier.errors.to_xml }
        end
      end
    end
    
  end

  # DELETE /couriers/1
  # DELETE /couriers/1.xml
  def destroy

    courier = Courier.find( params[ :id ] )
    
    respond_to do |format|
      if courier.destroy
        format.html {
          flash[ :notice ] = "Courier deleted"
          redirect_to couriers_url
        }
        format.xml  { render :nothing => true }
      else
        format.html {
          flash[ :notice ] = "Could not delete"
          redirect_to couriers_url
        }
        format.xml  { render :nothing => true } # Hmm?
      end
    end

  end
  
end
