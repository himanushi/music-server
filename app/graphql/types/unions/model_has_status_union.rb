module Types
  module Unions
    class ModelHasStatusUnion < BaseUnion
      description "ステータスをもつモデルのいずれか"
      possible_types Types::Objects::ArtistType, Types::Objects::AlbumType, Types::Objects::TrackType

      def self.resolve_type(object, context)
        case object
        when ::Artist
          Types::Objects::ArtistType
        when ::Album
          Types::Objects::AlbumType
        when ::Track
          Types::Objects::TrackType
        end
      end
    end
  end
end
