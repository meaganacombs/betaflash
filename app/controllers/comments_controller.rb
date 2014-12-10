class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:update]
  
  
   def find_user_name(comment)
    id = comment.user_id
    user = User.find(id)
    return user.name
  end
  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit, redirect to comments page
  def edit
     @comment = Comment.find(params[:comment_id])
    @user = User.find(params[:user_id])
    redirect_to('/pins') unless @comment.user_id==@user.id
    session[:return_to] ||= request.referer
  end

  # POST /comments
  #redirect to comments page
  def create
    @pin = Pin.find_by(id: params[:pin_id])
    @comment = Comment.new(comment_params)
 
    respond_to do |format|
      if @comment.save
        format.html { redirect_to (:back), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to (:back), notice: 'comment was not posted, try again' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_photo
    @comment = Comment.find_by(id: params[:id])
    @comment.avatar = nil
    @comment.save
    redirect_to (:back), notice: 'image removed' 
  end
  # PATCH/PUT /comments/1
  #redirect_to comments page
  def update
  respond_to do |format|
      if @comment.update(comment_params)
        format.html {redirect_to session.delete(:return_to), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: '/pins' }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
#redirect to comments page
  def destroy
     @comment = Comment.find_by(id: params[:id])
    @user = User.find(params[:user_id])
    redirect_to(:back) and return unless @comment.user_id==@user.id
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to (:back), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
 
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

  def set_pin
    @pin = Pin.find(params[:id])
  end
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :pin_id, :user_id, :avatar)
    end
  
  def pin_param
    @pin = Pin.find(params[:pin_id])
  end
  
#checks if comment was created by the current user so that only the user who created the comment can edit or delete it
  def correct_user
    @comment = Comment.find_by(id: params[:id])
    @user = User.find(params[:comment][:user_id])
    redirect_to('/pins') unless @comment.user_id==@user.id
  end
  
 
  
   
  
end
