desc "Searches for missing indices"
task :lazy_susan => :environment do
  DATABASE = ActiveRecord::Base.connection  
  results = {}
  DATABASE.tables.each do |table_name|   
    missing_indexes = gather_missing_indexes(table_name)
    results[table_name] = missing_indexes if missing_indexes.any?
  end
  if results.keys.any?
    generate_migration(results)
  else
    puts "No missing indexes found."
  end
end

def gather_missing_indexes(table_name)
  results = []
  results += columns_to_index(table_name)
  results += joins_to_index(table_name)
  results
end

def columns_to_index(table_name)
  results = []
  columns_to_check = columns_needing_indexes(table_name)
  columns_to_check.each do |column_name|
    results << column_name unless DATABASE.index_exists?(table_name, column_name)
  end
  results
end

def joins_to_index(table_name)
  results = []
  joins_to_check = joins_needing_indexes(table_name)
  joins_to_check.each do |join|
    results << join unless DATABASE.index_exists?(table_name, join)
    results << join.reverse unless DATABASE.index_exists?(table_name, join.reverse)
  end
  results
end

# Every column name that ends in _id, or is "id", should be indexed.
def columns_needing_indexes(table_name)
  results = []
  DATABASE.columns(table_name).each do |column|
    results << column.name.to_sym if column.name.last(3) == "_id"
    results << column.name.to_sym if column.name == "id"
  end
  results
end

# If a table has two column names ending in _id, it's probably a join
# and should be indexed for join lookups in either direction.
def joins_needing_indexes(table_name)
  results = columns_needing_indexes(table_name).reject { |name| name == :id }
  results.size == 2 ? [results.map(&:to_sym)] : []
end

def generate_migration(missing_indexes)
  puts "Generating missing index migration."
  puts timestamped_migration_filename(missing_indexes)
  migration_file = File.open("#{Rails.root}/db/migrate/#{timestamped_migration_filename(missing_indexes)}", "w") do |f|
    f.puts header_boilerplate(missing_indexes)
    f.puts migration_lines(missing_indexes)
    f.puts footer_boilerplate
  end
end

def timestamped_migration_filename(missing_indexes)
  Time.now.utc.strftime("%Y%m%d%H%M%S") + "_lazy_susan_for_#{missing_indexes.first.first}.rb"
end

def header_boilerplate(missing_indexes)
  "class LazySusanFor#{missing_indexes.first.first.classify.pluralize} < ActiveRecord::Migration
  def change"
end

def footer_boilerplate
  "  end\nend"
end

def migration_lines(missing_indexes)
  results = ""
  missing_indexes.each do |table_name, indexes|
    indexes.each do |index|
      if index.class == Array
        results << "    add_index :#{table_name}, #{index}\n"
      else
        results << "    add_index :#{table_name}, :#{index}\n"
      end
    end
  end
  results
end
