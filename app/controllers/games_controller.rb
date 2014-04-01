class GamesController < ApplicationController

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
end