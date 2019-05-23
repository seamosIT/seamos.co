class PrehomeController < ApplicationController
  include ApplicationHelper

  before_action :redirect_admin_or_politician_users

  def index
    @blog_posts = HTTParty.get('https://seamosit.github.io/posts.json')
    @politicians = if (Rails.env.staging? || Rails.env.development?)
      JSON.parse(File.read("app/helpers/dummy-politicians.json"))
    elsif Rails.env.production?
      JSON.parse(File.read("app/helpers/politicians.json"))
    end
    @discussions = ForumThread.all
    @tags = Tag.joins(:polls).where(polls: {active: true}).uniq
  end

  private

  def redirect_admin_or_politician_users
    redirect_to admin_dashboard_index_path if current_user && admin_or_politician?(current_user)
  end
end
