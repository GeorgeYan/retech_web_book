class UserController < ApplicationController
  load_and_authorize_resource
  respond_to :json

  def index
    if current_user.has_role?(:admin)

      @users = User.paginate(:page => params[:page], :per_page => 2)

      respond_with(@users) do |format|
        format.json {
          render :json => {
            :current_page => @users.current_page,
            :per_page => @users.per_page,
            :total_entries => @users.total_entries,
            :entries => @users
          }
        }
      end

    end
  end

  def query_page
    if current_user.has_role?(:admin)

      @users = User.paginate(:page => params[:current_page], :per_page => 2)

      respond_with(@users) do |format|
        format.json {
          render :json => {
            :current_page => @users.current_page,
            :per_page => @users.per_page,
            :total_entries => @users.total_entries,
            :entries => @users
          }
        }
      end

    end
  end

end
