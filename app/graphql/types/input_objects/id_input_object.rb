module Types
  module InputObjects
    class IdInputObject < BaseInputObject
      argument :id, [TTID], "ID", required: false
    end
  end
end
