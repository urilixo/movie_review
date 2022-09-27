module MoviesHelper
  def total_gross(movie)
    movie.flop? ? 'Flop!' : number_to_currency(movie.total_gross, precision: 0)
  end

  def release_date(movie)
    movie.released_on.strftime('%B %d, %Y')
  end

  def review_score(movie)
    movie.average_stars_as_percent.zero? ? content_tag(:strong, 'No reviews') : movie.average_stars_as_percent
  end

  def review_count(movie)
    movie.reviews_amount.zero? ? 'No ' : movie.reviews_amount
  end

  def get_image(movie)
    movie.cover_image.attached? ? movie.cover_image : 'placeholder'
  end
end
