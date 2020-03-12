# ref: https://github.com/yamatatsu/graphql-ruby-playground/blob/master/app/graphql/association_loader.rb
class AssociationLoader < GraphQL::Batch::Loader
  attr_reader :klass, :association

  def self.preload(model, association)
    self.for(model.class, association).load(model)
  end

  def initialize(klass, association)
    raise ArgumentError, "association to load must be a symbol (got #{association.inspect})" unless association.is_a?(Symbol)
    raise ArgumentError, "cannot load associations for class #{klass.name}" unless klass < ActiveRecord::Base
    raise TypeError, "association #{association} does not exist on #{klass.name}" unless klass.reflect_on_association(association)

    @klass = klass
    @association = association
  end

  def load(model)
    raise TypeError, "loader for #{klass.name} can't load associations for objects of type #{model.class.name}" unless model.is_a?(klass)
    model.association(@association).loaded? ? Promise.resolve(model) : super
  end

  def perform(models)
    ActiveRecord::Associations::Preloader.new.preload(models, association)
    models.each { |m| fulfill(m, m.public_send(@association)) }
  end
end
