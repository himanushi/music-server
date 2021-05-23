class Mutations::UpdateMe < Mutations::BaseMutation
  description "カレントユーザー情報更新"

  argument :name, String, required: false

  argument :is_public_artist, Boolean, required: false
  argument :is_public_album,  Boolean, required: false

  argument :new_password, String, required: false
  argument :new_password_confirmation, String, required: false
  argument :current_password, String, required: false

  field :current_user, Types::Objects::CurrentUserType, null: true

  def mutate(**attrs)
    _attrs = {}

    ### ユーザー情報更新
    _attrs.merge!(attrs.slice(:name)) if attrs[:name].present?

    ### 公開情報更新
    public_informations = []
    public_informations << PublicInformation.new(public_type: :artist) if attrs.delete(:is_public_artist)
    public_informations << PublicInformation.new(public_type: :album) if attrs.delete(:is_public_album)
    _attrs.merge!({ public_informations: public_informations })

    ### パスワード変更
    current_password = attrs.delete(:current_password)
    new_password = attrs.delete(:new_password)

    # 現在のパスワードを検証
    if current_password.present? || new_password.present?
      unless current_password.present?
        context.add_error(GraphQL::ExecutionError.new(
          "現在のパスワードを入力してください",
          extensions: { code: "INVALID_VALUE", path: "current_password" })
        )
      end

      unless new_password.present?
        context.add_error(GraphQL::ExecutionError.new(
          "新しいパスワードを入力してください",
          extensions: { code: "INVALID_VALUE", path: "new_password" })
        )
      end

      unless context[:current_info][:user].authenticate(current_password)
        raise GraphQL::ExecutionError.new(
          "現在のパスワードが違います",
          extensions: { code: "FAILED_AUTHENTICATION", path: "current_password" }
        )
      end

      # パスワードを変更したら全てのセッションを削除し、最新セッション作成
      _attrs[:password] = new_password
      _attrs[:password_confirmation] = attrs.delete(:new_password_confirmation) || ""
    end

    ActiveRecord::Base.transaction do
      context[:current_info][:user].update!(_attrs)

      # パスワードを変更していた場合は全てのセッションをクリア
      if current_password.present? || new_password.present?
        context[:current_info][:user].sessions.delete_all
        context[:current_info][:session] = context[:current_info][:user].sessions.create!
      end
    end

    {
      current_user: context[:current_info][:user],
    }
  end
end
