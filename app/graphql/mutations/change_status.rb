class Mutations::ChangeStatus < Mutations::BaseMutation
  description "ステータス変更。関連するアルバム, トラック, 各音楽サービスアルバム、各音楽サービストラックも同じステータスで更新される。"

  argument :id, TTID, required: true, description: "変更したいオブジェクトID"
  argument :status, StatusEnum, required: true, description: "変更したいステータス"

  field :model, ModelHasStatusUnion, null: true, description: "変更されたステータスを持ったモデル"
  field :error, String, null: true

  def mutate(id:, status:)
    begin
      table_id = ::TTID.to_hash(id)[:table_id]

      klass =
        case table_id
        when Artist.table_id
          Artist
        when Album.table_id
          Album
        when Track.table_id
          Track
        else
          raise StandardError, "変更できるのはArtist, Album, Track のみ"
        end

      model = klass.find(id)
      model.__send__(:"#{status}!")

      {
        model: model,
        error: nil,
      }
    rescue => error
      {
        model: nil,
        error: error.message,
      }
    end
  end
end
