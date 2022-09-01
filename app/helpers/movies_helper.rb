module MoviesHelper
    def total_gross(movie)
        movie.flop? ? "Flop!" : number_to_currency(movie.total_gross, precision: 0)
    end

    def release_date(movie)
        movie.released_on.strftime("%B %d, %Y")
    end
end
