class Admin::PollsController < ApplicationController
  before_action :validate_admin_user
  # before_action :validate_closing_date, only: :edit
  def toggle_status
    @poll = Poll.find_by(id: params[:id])
    @poll.active = !@poll.active
    if @poll.save
      redirect_to admin_polls_path
    end
  end

  def create
    @poll = Poll.new http_params
    @poll.closing_hour = "23:59" if @poll.closing_hour.blank?
    @poll.user = current_user
    @poll.set_tags(tags_param)
    bind_links
    totals_hash = {}
    Poll.transaction do
      @poll.vote_types.build(name: 'SI')
      @poll.vote_types.build(name: 'NO')
      @poll.save! # We need vote_type.id
      @poll.vote_types.each do |vote_type|
        totals_hash[vote_type.id] = 0
      end
      @poll.totals = totals_hash.to_s
      @poll.save!
    end
    flash[:success] = I18n.t(:accion_exitosa)
    redirect_to admin_dashboard_index_path
  rescue Exception => e
    puts "ERROR POLL CREATION: #{e.inspect}"
    logger.debug "ERROR POLL CREATION: #{e.inspect}"
    logger.debug e.backtrace.to_s
    render :new
  end

  def update
    @poll = Poll.find_by(id: params[:id])
    @poll.tags = []
    @poll.set_tags(tags_param)
    bind_links
    if @poll.update(http_params)
      # ActionCable.server.broadcast 'polls_channel', 'changed'
      flash[:success] = I18n.t(:accion_exitosa)
      redirect_to admin_dashboard_index_path
    else
      render :edit
    end
  end

  def destroy
    @poll = Poll.find_by(id: params[:id])
    @poll.destroy
    # ActionCable.server.broadcast 'polls_channel', 'changed'
    redirect_to admin_polls_path
  end

  def edit
    @poll = Poll.find_by(id: params[:id])
    @used_tags = @poll.tags.map(&:name).join(',')
  end

  def index
    @filtered_polls = Poll.by_title(params[:search_term]).by_status(params[:status])
    @polls = if current_user.politico?
               @filtered_polls.where(user_id: current_user.id).page(params[:page]).per(4)
             else
               Kaminari.paginate_array(@filtered_polls).page(params[:page]).per(4)
             end
    render :index
  end

  def new
    @poll = Poll.new
  end

  def validate_admin_user
    redirect_to root_path if current_user.role_type == 'ciudadano'
  end

  private
    def bind_links
      set_project_link
      @poll.related_links.destroy_all if @poll.external_links.present? && links_param != ""
      links_param.split(',').map(&:strip).uniq.each do |url|
        if url.length > 4
          ExternalLink.create!(url: url, poll: @poll)
        end
      end
    end

    def set_project_link
      unless project_link_param[:project_link].blank?
        @poll.project_link.destroy if @poll.project_link
        ExternalLink.create!(url: project_link_param[:project_link], poll: @poll, is_project_link: true)
      end
    end

    def tags_param
      params[:poll][:tags]
    end

    def links_param
      params[:poll][:links]
    end

    def project_link_param
      params[:poll].permit(:project_link)
    end

    def http_params
      params.require(:poll).permit(
        :closing_date,
        :closing_hour,
        :description,
        :poll_image,
        :poll_image_cache,
        :title,
        :objective,
        :status,
        :state,
        :poll_type,
        :summary,
        :question,
        vote_types_attributes: [:name]
      )
    end

    def validate_closing_date
      poll = Poll.find_by(id: params[:id])
      redirect_to root_path and return if poll.closing_date < Date.today.in_time_zone
    end
end