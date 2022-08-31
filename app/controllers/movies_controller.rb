class MoviesController < ApplicationController
    def index
        @movies = ['Titanic', 'Your name', 'Spirited Away']
    end
end
