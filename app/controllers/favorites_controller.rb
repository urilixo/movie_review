class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie
  before_action :set_user

  def create
    @user.favorites.create(movie: @movie)
    redirect_to @movie
  end

  def destroy
    favorite = @user.favorites.find(params[:id])
    favorite.destroy

    redirect_to @movie, status: :see_other
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end

  def set_user
    @user = current_user
  end
end
