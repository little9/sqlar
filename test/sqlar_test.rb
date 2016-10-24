require 'test_helper'

class SqlarTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sqlar::VERSION
  end

  def test_it_does_something_useful
 
  end

  def test_that_you_can_create_a_new_sqlar
    sqlar = Sqlar::Sqlar.new()
    sqlar.create_sqlar("test.sqlite3")
    assert(File.file?("test.sqlite3"))
    assert(SQLite3::Database.open("test.sqlite3"))
    File.delete("test.sqlite3")
  end

  def test_that_you_can_insert_into_a_sqlar
   sqlar = Sqlar::Sqlar.new()
   sqlar.create_sqlar("test.sqlite3") 
   SQLite3::Database.open("test.sqlite3")
   blob = sqlar.get("test/test.jpg")
   sqlar.insert("test.sqlite3",blob)
   File.delete("test.sqlite3")
  end

  def test_that_you_extract_from_a_sqlar
  end

  
end
