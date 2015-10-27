require 'pry'
require 'minitest'
require 'minitest/autorun'
require './complete_me'

class CompleteMeTest < Minitest::Test
  attr_reader :tree

  def setup
    @tree = CompleteMe.new
  end

  def test_empty_tree
    assert tree.children = {}
  end

  def test_it_inserts_a_letter
    tree.insert("c")
    assert_equal ["c"], tree.children.keys
  end

  def test_it_inserts_2_letters
    tree.insert("a")
    tree.insert("b")
    assert_equal ["a", "b"], tree.children.keys
  end

  def test_correctly_inserts_words_with_different_first_letters
    tree.insert("art")
    tree.insert("bat")
    assert_equal ["a", "b"], tree.children.keys
  end

  def test_correctly_inserts_words_with_same_first_letters
    tree.insert("art")
    tree.insert("air")
    assert_equal ["a"], tree.children.keys
  end

  def test_flags_false_for_full_word
    tree.insert("art")
    assert tree.flag
  end

  def test_flags_true_for_full_word
    tree.insert("art")
    refute tree.children["a"].flag
  end





end
