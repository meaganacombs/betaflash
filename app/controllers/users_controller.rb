class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  def new
    @user=User.new
  end
  
  def edit
   
  end
  
  
  def update
     if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
       redirect_to '/pins'
    else
      render 'edit'
    end
  end
  
  def updatePinsVisited
  
    @user = User.find(params[:id])
    pinId = params[:pinId]
    pins_visited = @user.pins_visited + "," + pinId.to_s
    @user.update_attribute(:pins_visited, pins_visited)
    #@user.pins_visited = @user.pins_visited + " " + pinId.to_s
    @user.save
    render '/pins'
  end
  
  
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "welcome to BetaFlash"
      redirect_to '/pins'
    else
      render 'new'
    end
  end
  
   def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
     redirect_to '/signup'
     
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  
  
  def show
    @user = User.find(params[:id])
    #@pins = User.pins
  end
  
  
  
   private
  def create_remember_token
  end
  
  def index
    @users = Users.all
  end
  

  
  def correct_user
      @user = User.find(params[:id])
      redirect_to('/signin') unless current_user?(@user)
    end
  
  
  
end
