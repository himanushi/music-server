module Types
  module Objects
    class FavoriteType < Types::Objects::BaseObject
      description 'お気に入り'

      field :artist_ids, [String], null: false, description: "アーティストID"
      field :album_ids, [String], null: false, description: "アルバムID"
      field :track_ids, [String], null: false, description: "トラックID"
      field :playlist_ids, [String], null: false, description: "プレイリストID"
      field :radio_ids, [String], null: false, description: "ラジオID"
    end
  end
end
