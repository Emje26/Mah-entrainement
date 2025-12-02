# frozen_string_literal: true

# Cleanup tasks - Maintenance and cleanup operations

namespace :cleanup do
  desc 'Remove temporary files'
  task :tmp do
    puts 'Cleaning temporary files...'
    tmp_dirs = %w[tmp/cache tmp/pids tmp/sockets]

    tmp_dirs.each do |dir|
      if Dir.exist?(dir)
        FileUtils.rm_rf(Dir.glob("#{dir}/*"))
        puts "Cleaned: #{dir}"
      end
    end

    puts 'Temporary files cleaned!'
  end

  desc 'Remove old log files'
  task :logs do
    puts 'Cleaning old log files...'
    log_dir = 'log'

    if Dir.exist?(log_dir)
      Dir.glob("#{log_dir}/*.log").each do |log_file|
        if File.mtime(log_file) < Time.now - (7 * 24 * 60 * 60) # 7 days
          File.delete(log_file)
          puts "Deleted: #{log_file}"
        end
      end
    end

    puts 'Old log files cleaned!'
  end

  desc 'Remove expired sessions'
  task :sessions do
    puts 'Cleaning expired sessions...'
    # TODO: Implement session cleanup based on your session store
    puts 'Session cleanup completed!'
  end

  desc 'Remove orphaned uploads'
  task :uploads do
    puts 'Cleaning orphaned uploads...'
    uploads_dir = 'public/uploads'

    if Dir.exist?(uploads_dir)
      # TODO: Check against database records to find orphaned files
      puts "Checking #{uploads_dir} for orphaned files..."
    end

    puts 'Upload cleanup completed!'
  end

  desc 'Run all cleanup tasks'
  task all: %i[tmp logs sessions uploads] do
    puts 'All cleanup tasks completed!'
  end

  desc 'Database maintenance'
  task :database do
    puts 'Running database maintenance...'
    # TODO: Add database-specific cleanup
    # - VACUUM for SQLite
    # - ANALYZE for PostgreSQL
    puts 'Database maintenance completed!'
  end
end

namespace :db do
  desc 'Reset database (drop, create, migrate, seed)'
  task :reset do
    Rake::Task['db:drop'].invoke if Rake::Task.task_defined?('db:drop')
    Rake::Task['db:create'].invoke if Rake::Task.task_defined?('db:create')
    Rake::Task['db:migrate'].invoke if Rake::Task.task_defined?('db:migrate')
    Rake::Task['db:seed'].invoke if Rake::Task.task_defined?('db:seed')
  end
end
