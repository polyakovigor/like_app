class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index]
  skip_after_action :track_action

  def index
    @users = User.order('email ASC').page(params[:page])
  end

  def navigation
    @events = Event.visits(@user).page(params[:page])
  end

  def user_sign_in
    @event = Event.sign_in(@user).first
  end

  def user_sign_out
    @event = Event.sign_out(@user).first
  end

  def user_likes; end

  def user_comments; end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
