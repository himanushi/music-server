module Searchable
  extend ActiveSupport::Concern

  included do
    has_many :words, class_name: "#{self.name}Word", dependent: :destroy
    before_update :create_words
  end

  module ClassMethods
    def search(text)
      word_class = "#{self.name}Word".constantize
      ids = word_class.search_ids(text)
      where(id: ids)
    end
  end

  def words_attributes
    words.bigram_attributes(self.name)
  end

  def create_words
    ActiveRecord::Base.transaction do
      words.delete_all

      if self.status == "active"
        word_class = "#{self.class.name}Word".constantize
        word_class.insert_all self.words_attributes
      end
    end
  end
end
