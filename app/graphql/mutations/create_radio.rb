class Mutations::CreateRadio < Mutations::BaseMutation
  description "ラジオ作成"

  argument :playlist_id, TTID, required: true
  argument :random, Boolean, required: false

  field :radio, Types::Objects::RadioType, null: true

  def mutate(playlist_id:, random: false)
    ::Playlist.validate_author(playlist_id, context[:current_info][:user].id) if playlist_id

    radio = Playlist.find(playlist_id).create_radio(random: random)

    {
      radio: radio,
    }
  end
end
