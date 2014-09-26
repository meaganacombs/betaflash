class UsersController < ApplicationController
  def new
    @user=User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "welcome to BetaFlash"
      redirect_to '/users/show'
    else
      render 'new'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
 
  
  
  def show
    @user = User.find(params[:id])
   
  end
  
   private
  
  def create_remember_token
  end
  
  def index
    @users = Users.all
   
    end
  end
  
   def edit
    @user = User.find(params[:id])
  end

