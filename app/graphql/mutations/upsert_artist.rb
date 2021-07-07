class Mutations::UpsertArtist < Mutations::BaseMutation
  description "アーティストを最新の状態にする"

  argument :artist_name, String, required: false, description: <<~DESC
    アーティスト名から全ての音楽サービスのアーティストを登録。登録後、関連アルバム、トラックを全て保存する。
    (ありきたりなアーティスト名の場合は関係のないアーティストが登録される可能性があるため注意)
  DESC
  argument :artist_id, String, required: false, description: "アーティストに関連する音楽サービスアーティストを更新。関連アルバム、トラックを全て更新する。"
  argument :apple_music_id, String, required: false, description: "Apple Music のアーティストを登録。登録後、関連アルバム、トラックを全て保存する。"

  field :artists, [ArtistType], null: true, description: "追加されたアーティスト"
  field :error, String, null: true

  def mutate(artist_name: nil, artist_id: nil, apple_music_id: nil)
    begin
      artists = []

      if artist_name.present?
        artists += Artist.create_by_name(artist_name).map(&:create_albums)
      end

      if artist_id.present?
        artists << Artist.find(artist_id)
      end

      if apple_music_id.present?
        artists << AppleMusicArtist.create_by_music_service_id(apple_music_id)&.artist
      end

      artists.compact.uniq.map {|artist| artist.create_albums }

      Rails.cache.clear
      {
        artists: artists.compact.uniq,
        error: nil,
      }
    rescue => error
      {
        artists: nil,
        error: error.message,
      }
    end
  end
end
