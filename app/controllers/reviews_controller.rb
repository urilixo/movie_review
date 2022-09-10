class ReviewsController < ApplicationController
    before_action :set_movie
    before_action :require_signin

    def index
        @reviews = @movie.reviews.all
    end

    def new
        @review = @movie.reviews.new
    end

    def create
        @review = @movie.reviews.new(review_params)
        @review.user = current_user
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
        if correct_user?
            @review.destroy
            redirect_to movie_reviews_url, status: :see_other, alert: "Review succesfully deleted."
        else
            redirect_to [@movie, @review], alert: "Unauthorized Access", status: :see_other
        end
    end

    private

    def correct_user?
        @review = @movie.reviews.find(params[:id])
        @review.user.id == current_user.id
    end

    def set_movie
        @movie = Movie.find(params[:movie_id])
    end

    def review_params
        params.require(:review).
            permit(:stars, :comment)
    end
end
