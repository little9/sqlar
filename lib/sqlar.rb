require "sqlar/version"
require 'sqlite3'
require 'pathname'
require 'sqlar_blob'
require 'fileutils'

module Sqlar
  class Sqlar
    attr_accessor :files
    
    def initialize(db_name)
      @db_name = db_name
      
      begin
        SQLite3::Database.open(@db_name) do |db|
          db.results_as_hash = true
          rows = db.execute("SELECT * FROM sqlar")
          if rows.nil?
            create_sqlar()
          else
            @files = rows
          end
        end
      rescue
        SQLite3::Database.new(@db_name)
        create_sqlar()
      end
    end
    
    def create_sqlar()
      SQLite3::Database.open(@db_name) do |db|
        db.execute("CREATE TABLE sqlar(
      name TEXT PRIMARY KEY, 
      mode INT,               
      mtime INT,              
      sz INT,                 
      data BLOB              
    )" )
      end
    end
    
    def insert(blob)
      SQLite3::Database.open(@db_name) do |db|
        blob.name[0] = ''
        db.execute("INSERT INTO sqlar (name, mode, mtime, sz,data) VALUES (?,?,?,?,?)",blob.name,blob.mode,blob.mtime,blob.sz,blob.data)
      end
    end

    def extract(name)
      SQLite3::Database.open(@db_name) do |db|
        blob = db.get_first_value("SELECT data FROM sqlar WHERE name = ?",name)
        path = name.gsub(File.basename(name), '')
        FileUtils.makedirs(path)
        f = File.new(path+File.basename(name), "wb")
        f.write(blob)
      end
    end

    def extract_all()
      SQLite3::Database.open(@db_name) do |db|
        db.results_as_hash = true
        db.execute("SELECT * FROM sqlar") do |rows|
          blob = rows['data']
          path = rows['name'].gsub(File.basename(rows['name']), '')
          begin
            FileUtils.makedirs(path)
            f = File.new(path+File.basename(rows['name']), "wb")
            f.chmod(rows['mode'])
            f.write(blob)
            File.utime(rows['mtime'], rows['mtime'],File.absolute_path(f.path))
          rescue SystemCallError => e      
            puts e
          ensure
            f.close if f
          end
        end
      end
    end
    
    def get_blob(file)
      begin
        file = File.open file, "rb"
        stat = file.lstat
        blob = file.read 
        sqlar_blob = SqlarBlob.new
        sqlar_blob.name = File.absolute_path(file.path)
        sqlar_blob.mode = stat.mode
        sqlar_blob.mtime = stat.mtime.to_i
        sqlar_blob.sz = file.size
        sqlar_blob.data = SQLite3::Blob.new blob
      rescue SystemCallError => e      
        puts e
      ensure
        file.close if file
      end
      return sqlar_blob
    end
  end
end






