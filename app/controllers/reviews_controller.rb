class ReviewsController < ApplicationController
    before_action :set_movie

    def index
        @reviews = @movie.reviews.all
    end

    def new
        @review = @movie.reviews.new
    end

    def create
        @review = @movie.reviews.new(review_params)
        if @review.save
            redirect_to @movie, notice: "Review succesfully created!"
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    def edit
        @review = @movie.reviews.find(params[:id])
    end

    def update
        @review = @movie.reviews.find(params[:id])
        if @review.update(review_params)
            redirect_to [@movie, @review], notice: "Review succesfully updated!"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def show
        @review = @movie.reviews.find(params[:id])
    end

    def destroy
        @review = @movie.reviews.find(params[:id])
        @review.destroy
        redirect_to movie_reviews_url, status: :see_other, alert: "Review succesfully deleted."
    end

    private

    def set_movie
        @movie = Movie.find(params[:movie_id])
    end

    def review_params
        params.require(:review).
            permit(:name, :stars, :comment)
    end
end
