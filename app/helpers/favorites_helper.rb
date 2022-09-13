module FavoritesHelper
  def favorite_or_unfavorite(movie, favorite)
    if favorite
      button_to 'Remove from favorites', movie_favorite_path(movie, favorite), method: :delete
    else
      button_to 'Add to favorites', movie_favorites_path(movie)
    end
  end
end
