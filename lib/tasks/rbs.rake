# 少し修正
module RbsRails
  module ActiveRecord
    class Generator
      private def relation_decl
        <<~RBS
          class #{relation_class_name} < ::ActiveRecord::Relation
            include _ActiveRecord_Relation[#{klass.name}]
            include Enumerable[#{klass.name}, self]
          #{enum_scope_methods(singleton: false).indent(2)}
          #{scopes(singleton: false).indent(2)}
          end
        RBS
      end

      private def collection_proxy_decl
        <<~RBS
          class #{klass.name}::ActiveRecord_Associations_CollectionProxy < ::ActiveRecord::Associations::CollectionProxy
          end
        RBS
      end
    end
  end
end

# ref: https://github.com/pocke/rbs_rails/blob/v0.2.0/README.md
task copy_signature_files: :environment do
  require 'rbs_rails'

  to = Rails.root.join('sig/rbs_rails/')
  to.mkpath unless to.exist?
  RbsRails.copy_signatures(to: to)
end

task generate_rbs_for_model: :environment do
  require 'rbs_rails'

  out_dir = Rails.root / 'sig'
  out_dir.mkdir unless out_dir.exist?

  Rails.application.eager_load!

  ActiveRecord::Base.descendants.each do |klass|
    next if klass.abstract_class?
    # Rails の使用していないモジュール除外
    next if [ActionText, ActionMailbox, ActiveStorage].include?(klass.module_parent)

    path = out_dir / "app/models/#{klass.name.underscore}.rbs"
    FileUtils.mkdir_p(path.dirname)

    sig = RbsRails::ActiveRecord.class_to_rbs(klass, mode: :class)
    path.write sig
  end
end

task generate_rbs_for_path_helpers: :environment do
  require 'rbs_rails'
  out_path = Rails.root.join 'sig/path_helpers.rbs'
  rbs = RbsRails::PathHelpers.generate
  out_path.write rbs
end
