class ProfilesController < ApplicationController
  before_action :fetch_app
  before_action :fetch_profile, :only => [ :show, :file ]

  helper_method :profile_value_for_sort

  def index
    @profiles = @app.profiles
    respond_to do |format|
      format.html
    end
  end

  def show
    @minimum = (params[:minimum] || 5).to_i
    @sort    = params[:sort]
    @summary = params[:summary]

    @sorted_profile = sorted_profile(@profile, @sort, @summary)

    respond_to do |format|
      format.html
    end
  end

  def destroy
    @profile = @app.profiles.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
    end
  end

  def file
    @filename     = params[:filename]
    @file_profile = @profile.file_profiles.by_file_name(@filename).first
    @file_source  = @file_profile.file_source.contents
  end

  private

  def fetch_app
    @app = App.find(params[:app_id])
  end

  def fetch_profile
    @profile = @app.profiles.find(params[:id])
  end

  def sorted_profile(profile, sort, summary)
    return [] unless profile.file_profiles.any?
    profile.file_profiles.sort_by_summary_and_value(summary,sort).to_a
  end
end
