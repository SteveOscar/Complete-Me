require 'pry'
require 'minitest'
require 'minitest/autorun'
require './complete_me'

class CompleteMeTest < Minitest::Test
  attr_reader :tree

  def setup
    @tree = CompleteMe.new
  end

  def test_it_inserts_a_letter
    tree.insert("c")
    assert_equal ["c"], tree.children.keys
  end

  def test_it_inserts_2_letters
    tree.insert("a")
    tree.insert("b")
    tree.insert("c")
    assert_equal ["a", "b", "c"], tree.children.keys
  end

  def test_it_inserts_words
    tree.insert("art")
    tree.insert("bat")
    tree.insert("cat")
    assert_equal ["a", "b", "c"], tree.children.keys
  end



end
