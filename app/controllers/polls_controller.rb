class PollsController < ApplicationController
  include PollsHelper
  before_action :set_poll, only: :show
  before_action :set_random_polls, only: :show
  before_action :set_metas, only: :show
  before_action :set_status_image, only: :show

  def show
    @tag = @poll.default_tag
    @author = @poll.user
  end

  private

  def set_status_image
    @status_image = if @poll.read_attribute_before_type_cast(:poll_type) == 0
      Rails.application.config.cp_base_image_url
    else
      Rails.application.config.pa_base_image_url
    end
    @status_image += @poll.read_attribute_before_type_cast(:state).to_s + ".png"
  end

  def set_poll
    @poll = Poll.includes(:tags, :user).find_by(id: params[:id])
    unless @poll
      flash[:error] = "la propuesta no existe" 
      redirect_to root_path
    end
  end
end
