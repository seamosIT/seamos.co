class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :set_random_polls
  before_action :set_politician, only: :politician_profile

  def show
    if current_user
      @user = current_user
      @tags = Tag.joins(:polls).where(polls: {active: true}).uniq
      @participations = @user.votes.map(&:poll).reverse
      @participations = @participations.reject{ |p| p.active == false }
      @interests = @user.interests
    else
      flash[:error] = t(".not_logged_in")
      redirect_to root_path
    end
  end

  def politician_profile
    @polls = @politician.polls.first(6)
  end

  private

  def set_politician
    @politician = User.includes({polls: [:tags]}).find_by(id: params[:id])
    unless @politician && @politician.politico?
      flash[:error] = "El usuario que buscas no es político"
      redirect_to root_path
    end
  end
end
