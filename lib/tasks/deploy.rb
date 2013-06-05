namespace :deploy do
  STAGING_APP = 'podclik-stage'

  def run(*cmd)
    system(*cmd)
    raise "Command #{cmd.inspect} failed!" unless $?.success?
  end

  def confirm(message)
    print "\n#{message}\nAre you sure? [Yn] "
    raise 'Aborted' if STDIN.gets.chomp != 'Y'
  end

  desc 'Deploy to staging'
  task :staging do
    confirm("This will deploy the 'develop' branch to staging.")

    puts 'Pushing...'
    run "git push git@heroku.com:#{STAGING_APP}.git develop:master -f"
  end
end
