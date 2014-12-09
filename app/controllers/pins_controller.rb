class PinsController < ApplicationController
  before_action :signed_in_user, only: [:create, :update, :edit, :destroy]

  #action linked to viewing comments, sets comments instance to the current pins comments (has_many relationship), get, '/pins/1(.:format)' 
  def show
    @user =  current_user
    @pin=Pin.find(params[:id])
    if(@pin.activity_type.nil?)
      @pin.activity_type = "activity type not set"
    end
    if(@pin.name.nil?)
      @pin.name = "site not yet named"
    end
    @comments = @pin.comments
  end
  
  #action called when user selects "save pin" after double clicking map, requires params :latitude, :longitude, :user_id, :activity_type, :comment, :name, post, '/pins(.:format)'
  def create
    @pin = Pin.new(pin_params)
    @pins = Pin.all
    respond_to do |format|
     if @pin.save
         # save was successful
       redirect_to '/pins'
      format.json {@pins << @pin}
     end
    end  
  end

  #/pins/new(.:format) get
def new 
  render nothing: true
    if pin_params
        return
    end
end
  
  #/pins/:id(.:format), get
  def edit
    @user =  current_user
    @pin = current_user.pins.find_by(id: params[:id])
  end

  #'/pins/:id(.:format)' put
  def update
    @pin = current_user.pins.find_by(id: params[:id])
    if @pin.update_attributes(pin_params)
      flash[:success] = "Profile updated"
       redirect_to '/pins'
    else
      render 'edit'
    end
  end
  
  #find current pin
   def current_pin
    @current_pin ||= Pin.find_by(id: params[:id])
  end
  
  #'/pins' get, creates hash that is rendered as markers in index view using gmaps4rails
  def index
    @current_pin ||= Pin.find_by(id: params[:id])
    @id = current_user.id
    @pinsVisited = current_user.pins_visited
    @pin = Pin.new
    @pins = Pin.all
    @hash = Gmaps4rails.build_markers(@pins) do |pin, marker|
      marker.lat pin.latitude
      marker.lng pin.longitude
      marker.json({ :id => pin.id })
      marker.json({ :activity_type => pin.activity_type})
      marker.json({ :address => pin.address})
      marker.json({ :user_id => pin.user_id})
      marker.json({ :comments => pin.comments })
      end
    
  end
  
  #/pins/:id(.:format) delete 
  def destroy
    Pin.find(params[:id]).destroy
    render '/pins/index'
  end
  
  #checks to see if the current user is the one who created the pin
  def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to root_url if @pin.nil?
   end
    
  private 
  def pin_params
    params.require(:pin).permit(:latitude, :longitude, :user_id, :activity_type, :comment, :name)
    end
  def id_params
    params.require(:pin).permit(:id)
  end
  
end
