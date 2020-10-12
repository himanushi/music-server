class Mutations::UpdateMe < Mutations::BaseMutation
  description "カレントユーザー情報更新"

  argument :name, String, required: false

  argument :is_public_artist, Boolean, required: true
  argument :is_public_album,  Boolean, required: true

  argument :new_password, String, required: false
  argument :password_confirmation, String, required: false
  argument :old_password, String, required: false

  field :current_user, Types::Objects::CurrentUserType, null: true
  field :error, String, null: true

  def mutate(**attrs)
    begin
      _attrs = {}

      ### ユーザー情報更新
      _attrs.merge!(attrs.slice(:name))

      ### 公開情報更新
      public_informations = []
      public_informations << PublicInformation.new(public_type: :artist) if attrs.delete(:is_public_artist)
      public_informations << PublicInformation.new(public_type: :album) if attrs.delete(:is_public_album)
      _attrs.merge!({ public_informations: public_informations })

      ### パスワード変更
      old_password = attrs.delete(:old_password)
      new_password = attrs.delete(:new_password)

      ActiveRecord::Base.transaction do

        # 現在のパスワードを検証
        if old_password.present? || new_password.present?
          raise StandardError, "エラー : 現在のパスワードを入力してください" unless old_password.present?
          raise StandardError, "エラー : 新しいパスワードを入力してください" unless new_password.present?
          raise StandardError, "エラー : 現在のパスワードが違います" unless context[:current_info][:user].authenticate(old_password)

          # パスワードを変更したら全てのセッションを削除し、最新セッション作成
          _attrs[:password] = new_password
          _attrs[:password_confirmation] = attrs.delete(:password_confirmation) || ""
        end

        context[:current_info][:user].update!(_attrs)

        # パスワードを変更していた場合
        if old_password.present? || new_password.present?
          context[:current_info][:user].sessions.delete_all
          context[:current_info][:session] = context[:current_info][:user].sessions.create!
        end
      end

      {
        current_user: context[:current_info][:user],
        error: nil,
      }
    rescue => error
      {
        current_user: nil,
        error: error.message
      }
    end
  end
end
