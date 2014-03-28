class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    if session[:user_id] != nil # the current user:  registered and logged in
    @user = User.find(session[:user_id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
    else
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { head :no_content }
      end
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html {
          redirect_to new_credential_path,
                      notice: 'You have successfully registered!'
        }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def logout
    session[:user_id] = nil
    session[:game_id] = nil
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end


  def user_params
    params.require(:user).permit(:name, :password)
  end


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


end