class Mutations::AddPlaylistItems < Mutations::BaseMutation
  description "プレイリストに曲を追加する"

  argument :playlist_id, TTID, required: true, description: "プレイリストID"
  argument :track_ids, [TTID], required: true, description: "追加したい曲ID"

  field :playlist, PlaylistType, null: true, description: "曲追加されたプレイリスト"
  field :error, String, null: true

  def mutate(playlist_id: nil, track_ids: [])
    begin
      Playlist.validate_author(playlist_id, context[:current_info][:user].id)
      playlist = Playlist.find(playlist_id).add_items(track_ids: track_ids)

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
