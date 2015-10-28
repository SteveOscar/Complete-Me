require 'pry'
require 'minitest'
require 'minitest/autorun'
require './complete_me'

class CompleteMeTest < Minitest::Test
  attr_reader :tree

  def setup
    @tree = CompleteMe.new
    @words = "finally\numbrella\nfrank\nunderwear\nfinished\nunusual"
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

  def test_keys_dont_repeat
    tree.insert("a")
    tree.insert("a")
    assert_equal ["a"], tree.children.keys
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

  def test_is_word_starts_as_false
    refute tree.is_word
  end

  def test_children_starts_empty
    assert tree.children.empty?
  end

  def test_is_words_true_for_full_word
    tree.insert("art")
    refute tree.children["a"].is_word
  end

  def test_counts_singe_letter_word
    tree.insert("a")
    assert_equal 1, tree.count
  end

  def test_counts_two_single_letter_words
    tree.insert("a")
    tree.insert("b")
    assert_equal 2, tree.count
  end

  def test_counts_one_word
    tree.insert("abc")
    assert_equal 1, tree.count
  end

  def test_count_distinguishes_words_with_same_prefix
    tree.insert("ab")
    tree.insert("abc")
    tree.insert("abba")
    assert_equal 3, tree.count
  end

  def test_counts_words_with_different_prefix
    tree.insert("art")
    tree.insert("bat")
    tree.insert("zoo")
    assert_equal 3, tree.count
  end

  def test_it_counts_more_complex_tree
    text = @words
    result = tree.populate(text)
    assert tree.count == 6
  end

  def test_it_populates_a_simple_file
    text = "car\nbat\nzoo"
    result = tree.populate(text)
    assert tree.count == 3
  end

  def test_it_inserts_many_keys
    text = "z\na\nx\nw\nc\nl\nq\ne"
    result = tree.populate(text)
    assert_equal 8, tree.children.keys.length
  end

  def test_it_populates_more_complex_words
    text = @words
    result = tree.populate(text)
    assert tree.count == 6
  end

  def test_it_auto_suggests_basic_words
    skip
    tree.insert("cat")
    tree.insert("car")
    tree.insert("cab")
    assert_equal 3, tree.auto_suggest("ca")
  end

end
