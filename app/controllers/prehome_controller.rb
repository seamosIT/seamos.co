class PrehomeController < ApplicationController  
  include ApplicationHelper
  
  before_action :redirect_admin_or_politician_users

  def index
  end

  private

  def redirect_admin_or_politician_users
    redirect_to admin_dashboard_index_path if current_user && admin_or_politician?(current_user)
  end
end
