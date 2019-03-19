namespace :db do
  desc "Rebuild the development database from scrach"
  task :rebuild => :environment do
    sh "rm -f db/development.sqlite3"
    sh "rm -f db/test.sqlite3"
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  end
end