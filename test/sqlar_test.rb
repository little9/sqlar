require 'test_helper'

class SqlarTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sqlar::VERSION
  end

  def test_that_you_can_create_a_new_sqlar
    sqlar = Sqlar::Sqlar.new("test.sqlite3")
    assert(File.file?("test.sqlite3"))
    File.delete("test.sqlite3")
  end

  def test_that_you_can_insert_into_a_sqlar
   sqlar = Sqlar::Sqlar.new("test.sqlite3")
   blob = sqlar.get_blob("test/test.jpg")
   sqlar.insert(blob)
   File.delete("test.sqlite3")
  end

  def test_that_you_get_rows_for_exisiting
    sqlar = Sqlar::Sqlar.new("test/existing_test.sqlite")
    assert_equal(5974, sqlar.files[0]['sz'])
  end

  def test_that_you_can_extract_a_file
    sqlar = Sqlar::Sqlar.new("test/existing_test.sqlite")
    sqlar.extract('Users/jlittle/Desktop/0-0-0.jpg')
    assert(File.file?('Users/jlittle/Desktop/0-0-0.jpg'))
  end

  def test_that_you_can_exact_all_files
    sqlar = Sqlar::Sqlar.new("test/existing_test.sqlite")
    sqlar.extract_all()
    assert(File.file?('Users/jlittle/Desktop/0-0-0.jpg'))
  end
  
end
