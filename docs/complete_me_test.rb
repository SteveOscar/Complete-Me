require 'pry'
require 'minitest'
require 'minitest/autorun'
require './complete_me'

class CompleteMeTest < Minitest::Test
  attr_reader :tree

  def setup
    @tree = CompleteMe.new
  end

  # def test_empty_tree
  #   assert tree.children = {}
  # end
  #
  # def test_it_inserts_a_letter
  #   tree.insert("c")
  #   assert_equal ["c"], tree.children.keys
  # end
  #
  # def test_it_inserts_2_letters
  #   tree.insert("a")
  #   tree.insert("b")
  #   assert_equal ["a", "b"], tree.children.keys
  # end
  #
  # def test_correctly_inserts_words_with_different_first_letters
  #   tree.insert("art")
  #   tree.insert("bat")
  #   assert_equal ["a", "b"], tree.children.keys
  # end
  #
  # def test_correctly_inserts_words_with_same_first_letters
  #   tree.insert("art")
  #   tree.insert("air")
  #   assert_equal ["a"], tree.children.keys
  # end
  #
  # def test_flag_start_as_false
  #   refute tree.flag
  # end
  #
  # def test_flags_true_for_full_word
  #   tree.insert("art")
  #   refute tree.children["a"].flag
  # end
  #
  # def test_counts_singe_letter_word
  #   tree.insert("a")
  #   assert_equal 1, tree.count
  # end
  #
  # def test_counts_two_single_letter_words
  #   tree.insert("a")
  #   tree.insert("b")
  #   assert_equal 2, tree.count
  # end

  def test_counts_one_word
    tree.insert("abc")
    tree.insert("cat")
    assert_equal 2, tree.count
  end

  # def test_counts_words_with_common_prefix
  #   tree.insert("art")
  #   tree.insert("bat")
  #   assert_equal 2, tree.count
  # end
  #
  # def test_it_populates_a_file
  #   text = "car\nbat\nzoo"
  #   result = tree.populate(text)
  #   assert tree.count = 3
  # end


end
