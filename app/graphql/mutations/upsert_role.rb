class Mutations::UpsertRole < Mutations::BaseMutation
  description "ロールを追加更新する"

  argument :id, TTID, required: false, description: "変更したいロール。IDを指定しない場合は追加される"
  argument :name, String, required: false, description: "ロール名。IDを指定しない場合は必須。"
  argument :description, String, required: false, description: "ロールの説明。IDを指定しない場合は必須。"
  argument :allowed_actions, [String], required: false, description: "変更したいアクション。全て上書きされる。IDを指定しない場合は必須。"

  field :role, RoleType, null: true, description: "追加更新されたロール"
  field :error, String, null: true

  def mutate(id: nil, name: nil, description: nil, allowed_actions: [])
    if id.blank? && (name.blank? || description.blank? || allowed_actions.blank?)
      raise StandardError, "IDを指定しない場合は全てを入力する必要あり"
    end

    unless (_actions = allowed_actions - AllowedAction::ALL_ACTIONS).blank?
      raise StandardError, "存在しないアクションを指定している(#{_actions.join(', ')})"
    end

    begin
      role =
        if id.present?
          role = ::Role.find(id)
          role.name = name if name.present?
          role.description = description if description.present?
          if allowed_actions.present?
            role.allowed_actions = []
            role.allowed_actions = allowed_actions.map {|_name| AllowedAction.new(name: _name) }
          end
          role
        else
          _allowed_actions = allowed_actions.map {|_name| AllowedAction.new(name: _name) }
          ::Role.new(name: name, description: description, allowed_actions: _allowed_actions)
        end

      role.save!

      Rails.cache.clear
      {
        role: role,
        error: nil,
      }
    rescue => error
      {
        role: nil,
        error: error.message,
      }
    end
  end
end
