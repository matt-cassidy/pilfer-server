class Api::ProfilesController < ApplicationController
  protect_from_forgery with: :null_session

  before_action      :authenticate_token
  skip_before_action :require_github_authentication

  def create
    @app.profiles.create!(:hostname     => params[:hostname],
                          :pid          => params[:pid],
                          :description  => params[:description],
                          :payload      => params[:profile],
                          :file_sources => params[:file_sources])
    head :ok
  end

  private
  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      @app = App.find_by_token(token)
    end
  end
end
