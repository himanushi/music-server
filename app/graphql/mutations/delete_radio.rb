class Mutations::DeleteRadio < Mutations::BaseMutation
  description "ラジオ削除"

  argument :radio_id, TTID, required: true

  field :playlist, PlaylistType, null: true

  def mutate(radio_id:)
    radio = Radio.find(radio_id)
    playlist = radio.playlist

    ::Playlist.validate_author(playlist.id, context[:current_info][:user].id) if playlist.id

    ActiveRecord::Base.transaction do
      radio.destroy!
    end

    {
      playlist: playlist,
    }
  end
end
