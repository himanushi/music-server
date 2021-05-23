class Mutations::UpsertPlaylist < Mutations::BaseMutation
  description "プレイリストを作成更新する"

  argument :playlist_id, TTID, required: false, description: "IDがない場合は作成"
  argument :track_id, TTID, required: false, description: "ジャケットトラックID"
  argument :name, String, required: true, description: "タイトル"
  argument :description, String, required: false, description: "説明"
  argument :public_type, PlaylistPublicTypeEnum, required: true, description: "公開種別"
  argument :track_ids, [TTID], required: false, description: "トラックID"

  field :playlist, PlaylistType, null: true, description: "作成更新されたプレイリスト"
  field :error, String, null: true

  def mutate(playlist_id: nil, track_id: nil, name:, description: "", public_type:, track_ids: [])
    Playlist.validate_author(playlist_id, context[:current_info][:user].id) if playlist_id

    playlist =
      Playlist.upsert(
        id: playlist_id,
        track_id: track_id,
        user_id: context[:current_info][:user].id,
        name: name,
        description: description,
        public_type: public_type,
        track_ids: track_ids
      )

    {
      playlist: playlist,
    }
  end
end
