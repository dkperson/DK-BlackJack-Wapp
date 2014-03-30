class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  def index
    #@games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    #@game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    #@game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    #@game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
   # @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
   # @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
   # @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  def setup # for a new game
    @user = User.find(session[:user_id])
    @dealer = Play::Dealer.new
    @players = []
    @players << Play::Player.new(@user.name)

    @dealer.deal(@players)


    session[:dealer] = @dealer
    session[:players] = @players

    redirect_to :action => "play"
  end

  def play
    @user = User.find(session[:user_id])
    @dealer = session[:dealer]
    @players = session[:players]
  end

  def hit
    dealer = session[:dealer]
    players = session[:players]
    player = players.first
    dealer.hit(player)
    session[:dealer] = dealer
    session[:players] = players

    redirect_to :action => "play"
  end

  def stand

    dealer = session[:dealer]
    players = session[:players]
    players.first.stand = true
    while dealer.status == :ready
      if dealer.hand_total < 17
        dealer.hit(dealer)
      else
        dealer.stand = true
      end
    end
    session[:dealer] = dealer
    session[:players] = players

    redirect_to :action => "play"
  end

  def games_params
    params.require(:game).permit(:deck)
  end
end