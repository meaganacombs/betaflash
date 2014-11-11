class PinsController < ApplicationController
  before_action :signed_in_user, only: [:create, :update, :edit, :destroy]


  
#   def new 
#     @pin = Pin.new
#   end
  
#   def create
   
#     debugger
  
#     @pin = Pin.new(pin_params)
#     #flash[:notice] = "#{@pin.latitude}"
#     respond_to do |format|
#       if @pin.save

#         format.html { redirect_to @pin, notice: "Save process completed!" }
#         format.json { render json: @pin }
#       else
#         format.html { render :new }
#         #, flash.now[:notice]="Save proccess coudn't be completed!"
#         format.json { render json: @pin.errors}
#       end
    
#     end
    
#   end
  def show
    @pin=Pin.new
  end
  
    def create

    @pin = Pin.new(pin_params)

    if @pin.save
        # save was successful
        
      render '/pins'
        else
        # If we have errors render the form again   
        render 'new'
    end
end

def new 
  render nothing: true
    if pin_params
        # If data submitted already by the form we call the create method
        create
        return
    end

    @pin = Pin.new

    #render 'new' # call it explicit
end
  
  def edit
   # if pin_params
    #update
   # return
    #end
    @user =  current_user
    @pin = current_user.pins.find_by(id: params[:id])
    
  end
  
  def update
    @pin = current_user.pins.find_by(id: params[:id])
    if @pin.update_attributes(pin_params)
      flash[:success] = "Profile updated"
       redirect_to '/pins'
    else
      render 'edit'
    end
  end
  
   def current_pin
    @current_pin ||= Pin.find_by(id: params[:id])
  end
  
  def index
    #debugger
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
      end
    
  end
  
  
  def destroy
    #render nothing: true
    Pin.find(params[:id]).destroy
    render '/pins/index'
  end
  
  def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to root_url if @pin.nil?
    end
    
 
  
  private 
  def pin_params
    params.require(:pin).permit(:latitude, :longitude, :user_id, :activity_type, :comment)
    end
  def id_params
    params.require(:pin).permit(:id)
  end
  
end
