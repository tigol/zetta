namespace :db do
  namespace :mongo do

    desc "gets database"
    task :db => :environment do
      @db = Mongoid::Sessions.default
    end

    desc "dumps all collections mongo:dump"
    task :dump => ['mongo:db'] do
      config = Mongoid.sessions[:default]
      database = config[:database]
      host = config[:hosts][0]

      use_credential = !config[:username].nil?
      timestamp = Time.now.strftime("%Y-%m-%d-%H%M%S")
      path = File.join(Rails.root, 'db', 'backup', "#{timestamp}")

      auth = use_credential ? "--username #{config[:usrename]} --password #{config[:password]}" : ""
      command = "mongodump --db #{database} --host #{host} #{auth} --out #{path}"
      puts command
      system command
      puts "done"
    end

    desc "restore all collections from a directory mongo:restore[directory]"
    task :restore, [:directory] => ['mongo:db'] do |t, args|
      config = Mongoid.sessions[:default]
      database = config[:database]
      host = config[:hosts][0]

      use_credential = !config[:username].nil?
      
      path = File.join(Rails.root, 'db', 'backup', args[:directory])

      auth = use_credential ? "--username #{config[:usrename]} --password #{config[:password]}" : ""
      command = "mongorestore --db #{database} --host #{host} #{auth} #{path}"
      puts command
      system command
      puts "done"
    end
  end
end