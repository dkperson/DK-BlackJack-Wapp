class CredentialsController < ApplicationController
  # GET /credentials
  # GET /credentials.json
  def index
    @credentials = Credential.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @credentials }
    end
  end

  # GET /credentials/1
  # GET /credentials/1.json
  def show
    @credential = Credential.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @credential }
    end
  end

  # GET /credentials/new
  # GET /credentials/new.json
  def new
    @users = User.all
    if session[:user_id] != nil # the current user:  registered and logged in
      @user = User.find(session[:user_id])
      respond_to do |format|
        format.html { redirect_to :controller => "users", :action => "index" }
        format.json { head :no_content }
      end
    else
      @credential = Credential.new
      respond_to do |format|
        format.html
        format.json { render json: @credential }
      end
    end

  end

  # GET /credentials/1/edit
  def edit
    @credential = Credential.find(params[:id])
  end

  # POST /credentials
  # POST /credentials.json
  def create
    @credential = Credential.new(credential_params)

    respond_to do |format|
      if @credential.save
				# try to find a user with the credential name
				user = User.find_by_name(@credential.name)
				password_ok = user ? (user.password == @credential.password) : false
				if user == nil then # not registered user
					format.html { redirect_to new_user_path, alert: "#{@credential.name}, you are not registered, please register!" } # make them register
				elsif user && password_ok then
					session[:user_id] = user.id
					format.html { redirect_to users_path } # go to Leaderboard.
				else # OK user, bum password
        format.html { 
					redirect_to new_credential_path, notice: 'Attention! your login failed'
				}
				end
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /credentials/1
  # PUT /credentials/1.json
  def update
    @credential = Credential.find(params[:id])

    respond_to do |format|
      if @credential.update_attributes(credential_params)
        format.html { redirect_to @credential, notice: 'Credential was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @credential.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credentials/1
  # DELETE /credentials/1.json
  def destroy
    @credential = Credential.find(params[:id])
    @credential.destroy

    respond_to do |format|
      format.html { redirect_to credentials_url }
      format.json { head :no_content }
    end
  end
end

private
def credential_params
  params[:credential].permit(:name, :password)
end