# model 事前読み込み
(ActiveRecord::Base.connection.tables - %w[schema_migrations]).each do |table|
  table.classify.constantize rescue nil
end
