class Mutations::DeletePlaylist < Mutations::BaseMutation
  description "プレイリストを削除する"

  argument :playlist_id, TTID, required: false

  field :result, String, null: true, description: "削除結果"
  field :error, String, null: true

  def mutate(playlist_id:)
    ::Playlist.validate_author(playlist_id, context[:current_info][:user].id) if playlist_id

    ActiveRecord::Base.transaction do
      ::Playlist.find(playlist_id).destroy!
    end

    {
      result: "ok",
    }
  end
end
