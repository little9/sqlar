require "sqlar/version"
require 'sqlite3'
require 'pathname'
require 'sqlar_blob'
module Sqlar
  # Your code goes here...
  class Sqlar
    def create_sqlar(name)
      SQLite3::Database.new(name ) do |db|
        db.execute( "CREATE TABLE sqlar(
      name TEXT PRIMARY KEY, 
      mode INT,               
      mtime INT,              
      sz INT,                 
      data BLOB              
    )" )
      end  
    end
    
    def insert(name,blob)
      SQLite3::Database.open(name) do |db|
        db.execute("INSERT INTO sqlar (name, mode, mtime, sz,data) VALUES (?,?,?,?,?)",blob.name,blob.mode,blob.mtime,blob.sz,blob.data)
      end
    end
    
    def get(file)
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






