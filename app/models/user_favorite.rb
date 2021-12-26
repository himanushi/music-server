# frozen_string_literal: true

class UserFavorite
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def artist_ids
    ::Favorite.where(user_id: user_id, favorable_type: ::Artist.name).pluck(:favorable_id)
  end

  def album_ids
    ::Favorite.where(user_id: user_id, favorable_type: ::Album.name).pluck(:favorable_id)
  end

  def track_ids
    ::Favorite.where(user_id: user_id, favorable_type: ::Track.name).pluck(:favorable_id)
  end

  def playlist_ids
    ::Favorite.where(user_id: user_id, favorable_type: ::Playlist.name).pluck(:favorable_id)
  end
end
