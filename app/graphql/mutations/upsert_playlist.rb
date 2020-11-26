class Mutations::UpsertPlaylist < Mutations::BaseMutation
  description "プレイリストを作成更新する"

  class PlaylistPublicTypeEnum < BaseEnum
    value "NON_OPEN", value: "non_open", description: "非公開"
    value "OPEN",     value: "open", description: "公開"
  end

  argument :playlist_id, TTID, required: false, description: "IDがない場合は作成"
  argument :track_id, TTID, required: true, description: "ジャケットトラックID"
  argument :name, String, required: true, description: "タイトル"
  argument :description, String, required: false, description: "説明"
  argument :public_type, PlaylistPublicTypeEnum, required: true, description: "公開種別"
  argument :track_ids, [TTID], required: true, description: "トラックID"

  field :playlist, PlaylistType, null: true, description: "作成更新されたプレイリスト"
  field :error, String, null: true

  def mutate(playlist_id: nil, track_id:, name:, description: nil, public_type:, track_ids: [])
    begin

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
        error: nil,
      }
    rescue => error
      {
        playlist: nil,
        error: error.message,
      }
    end
  end
end
