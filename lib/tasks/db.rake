# ref: https://qiita.com/k-yamada-github/items/e8dbd6f53c638a930588
namespace :db do
  desc 'Dump the database to tmp/dbname.dump'
  task dump: %i[environment load_config] do
    config = ActiveRecord::Base.configurations[Rails.env]
    ignore_table_option = %w[ar_internal_metadata schema_migrations].map { |table| "--ignore-table=#{config['database']}.#{table}" }.join(' ')
    sh "mysqldump -u #{config['username']} -p#{config['password']} #{config['database']} -h #{config['host']} --no-create-info #{ignore_table_option} > tmp/vgm_db.dump"
  end

  desc 'Restore the database from tmp/dbname.dump'
  task restore: %i[environment load_config] do
    config = ActiveRecord::Base.configurations[Rails.env]
    sh "mysql -u #{config['username']} -p#{config['password']} #{config['database']} -h #{config['host']} < tmp/vgm_db.dump"
  end
end
