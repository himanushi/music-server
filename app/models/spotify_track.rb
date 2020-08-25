class SpotifyTrack < ApplicationRecord
  table_id :spt

  belongs_to :track
  belongs_to :spotify_album

  enum status: { pending: 0, active: 1, ignore: 2 }

  class << self
    def mapping(data)

      # @type var track_attrs: { isrc: String }
      track_attrs = to_track_attrs(data)

      # @type var track: Track
      track = Track.find_or_create_by(track_attrs)

      (data["artists"] || []).each do |artist_data|

        # @type var artist: Artist?
        artist = SpotifyArtist.find_by(spotify_id: artist_data["id"])&.artist

        if artist.present? && artist&.tracks&.where(id: track.id)&.empty?

           # @type var artist: Artist
          artist.tracks.push(track)
        end
      end

      {
        track:        track,
        spotify_id:   data["id"],
        name:         data["name"],
        disc_number:  data["disc_number"],
        track_number: data["track_number"],
        has_lyrics:   data["explicit"],
        playable:     data["is_playable"] || true,
        duration_ms:  data["duration_ms"],
        preview_url:  data["preview_url"],
        popularity:   data["popularity"],
        status:       track.status,
      }.merge(track_attrs)
    end

    def to_track_attrs(data)
      {
        isrc: data.dig("external_ids", "isrc"),
      }
    end
  end

  def music_service_id
    spotify_id
  end

  def artwork_m
    @artwork_m ||= spotify_album.artwork_m
  end
end
