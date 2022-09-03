class MoviesController < ApplicationController
    def index
        @movies = Movie.released
    end

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            redirect_to @movie
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @movie = Movie.find(params[:id])
    end

    def edit
        @movie = Movie.find(params[:id])
    end

    def update
        @movie = Movie.find(params[:id])
        if @movie.update(movie_params)
            redirect_to @movie
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        redirect_to movie_url, status: :see_other
    end

    private

    def movie_params
        params.require(:movie).
            permit(:title, :description, :total_gross, :rating, :released_on)
    end
end
