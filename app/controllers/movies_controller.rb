class MoviesController < ApplicationController
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  before_action :set_movie, only: %i[show edit update destroy]

  def index
    @movies = Movie.send(movie_filter)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie succesfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @genres = @movie.genres

    @favorite = current_user.favorites.find_by(movie_id: params[:id]) if current_user
  end

  def edit; end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie succesfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, status: :see_other, alert: 'Movie succesfully deleted.'
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end

  def movie_filter
    if params[:filter].in? Movie::FILTERS
      params[:filter].split(' ')[0].downcase
    else
      :all
    end
  end

  def movie_params
    params.require(:movie)
          .permit(:title, :description, :total_gross, :rating,
                  :released_on, :director, :cover_image, :duration, genre_ids: [])
  end
end
