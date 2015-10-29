require 'pry'
require 'minitest'
require 'minitest/autorun'
require '../lib/complete_me'

class CompleteMeTest < Minitest::Test
  attr_reader :tree

  def setup
    @tree = CompleteMe.new
    @words = "finally\numbrella\nfrank\nunderwear\nfinished\nunusual"
  end

  def test_empty_tree
    assert tree.children = {}
  end

  def test_is_word_starts_as_false
    refute tree.is_word
  end

  def test_children_starts_empty
    assert tree.children.empty?
  end

  def test_node_created_with_word_value
    tree = CompleteMe.new("snow")
    assert_equal "snow", tree.word
  end

  def test_node_created_with_word_flag
    tree = CompleteMe.new("snow", true)
    assert_equal true, tree.is_word
  end

  def test_node_created_with_word_value_but_false_flag
    tree = CompleteMe.new("snow", false)
    assert_equal false, tree.is_word
    assert_equal "snow", tree.word
  end

  def test_weighted_suggestions_starts_empty
    assert tree.weighted.empty?
  end

  def test_empy_insertion_doesn_not_count
    tree.insert("")
    assert_equal 0, tree.count
  end

  def test_number_insertion
    tree.insert("12324")
    assert_equal 1, tree.count
  end

  def test_number_insertion
    tree.insert("12324")
    assert_equal 1, tree.count
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

  def test_it_rejects_intigers
    message = "Only insert strings"
    assert_equal message, tree.insert(9)
  end

  def test_it_rejects_variables
    message = "Only insert strings"
    var = 8
    assert_equal message, tree.insert(var)
  end

  def test_empty_add_letter_to_empty_tree
    tree.add_letter_node("", "")
    assert_equal [""], tree.children.keys
  end

  def test_insertion_always_creates_a_word
    tree.add_letter_node(".", ".")
    assert_equal true, tree.children["."].is_word
  end

  def test_single_letter_insert_is_word
    tree.add_letter_node("a", "a")
    assert_equal true, tree.children["a"].is_word
  end

  def test_add_letter_to_empty_tree
    tree.add_letter_node("a", "abc")
    assert_equal ["a"], tree.children.keys
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

  def test_correctly_inserts_numbers
    tree.insert("007")
    tree.insert("911")
    assert_equal ["0", "9"], tree.children.keys
  end

  def test_correctly_inserts_words_with_same_first_letters
    tree.insert("art")
    tree.insert("air")
    assert_equal ["a"], tree.children.keys
  end

  def test_it_inserts_many_root_children
    text = "z\na\nx\nw\nc\nl\nq\ne"
    result = tree.populate(text)
    assert_equal 8, tree.children.keys.length
  end

  def test_it_stores_keys_in_children_hash
    text = "z\na\nx\nw"
    result = tree.populate(text)
    assert_equal ["z", "a", "x", "w"], tree.children.keys
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

  def test_count_distinguishes_words_on_long_shared_branch
    tree.insert("aaabbbcccc")
    tree.insert("aaabbbcc")
    tree.insert("aaaabb")
    assert_equal 3, tree.count
  end

  def test_counts_words_with_different_prefix
    tree.insert("aar")
    tree.insert("xoo")
    tree.insert("hit")
    assert_equal 3, tree.count
  end

  def test_counts_upcase_words
    tree.insert("CHINA")
    assert_equal 1, tree.count
  end

  def test_it_allows_for_spaces_in_words
    tree.insert("a phrase okay")
    assert_equal 1, tree.count
  end

  def test_counts_proper_nouns_seperately
    tree.insert("china")
    tree.insert("China")
    assert_equal 2, tree.count
  end

  def test_it_counts_more_complex_tree
    text = @words
    result = tree.populate(text)
    assert tree.count == 6
  end

  def test_it_counts_more_complex_tree
    text = @words
    result = tree.populate(text)
    assert tree.count == 6
  end

  def test_it_populates_a_word
    text = "car"
    result = tree.populate(text)
    assert tree.count == 1
  end

  def test_it_populates_several_words
    text = "car\nbat\nzoo"
    result = tree.populate(text)
    assert tree.count == 3
  end

  def test_it_populates_more_complex_words
    text = @words
    result = tree.populate(text)
    assert tree.count == 6
  end

  def test_it_populates_larger_word_list
    tree.populate(medium_word_list)
    assert_equal 1000, tree.count
  end

  def test_it_suggests_one_level_deep
    tree.insert("is")
    assert_equal ["is"], tree.suggest("i")
  end

  def test_it_suggests_two_levels_deep
    tree.insert("isa")
    assert_equal ["isa"], tree.suggest("i")
  end

  def test_it_suggests_with_empty_prefix_search
    tree.insert("cart")
    tree.insert("card")
    assert_equal ["card", "cart"], tree.suggest("")
  end

  def test_it_suggests_basic_words
    tree.insert("cart")
    tree.insert("card")
    assert_equal ["card", "cart"], tree.suggest("ca")
  end

  def test_it_suggests_branched_paths
    tree.insert("art")
    tree.insert("artisinal")
    tree.insert("artitistically")
    assert_equal ["art", "artisinal", "artitistically"], tree.suggest("ar")
  end

  def test_suggests_two_words_for_control_test
    tree.insert("stoically")
    tree.insert("stocking")
    assert_equal ["stocking", "stoically"], tree.suggest("sto")
  end

  def test_suggests_from_a_large_list
    tree.populate(medium_word_list)
    assert_equal ["carbonero", "carboxylase"], tree.suggest("carb")
  end

  def test_suggests_full_list_from_blank_suggest
    tree.populate(medium_word_list)
    assert_equal 1000, tree.suggest("").count
  end

  def test_suggests_nothing_from_a_space
    tree.populate(medium_word_list)
    assert_equal nil, tree.suggest(" ")
  end

  def test_select_successfully_weights_word_suggestions
    tree.insert("stoically")
    tree.insert("stocking")
    tree.select("sto", "stocking")
    assert_equal ["stocking", "stoically"], tree.suggest("sto")
  end

  def test_selects_weights_from_a_large_list
    tree.populate(medium_word_list)
    tree.select("sto", "stocking")
    assert_equal ["stocking", "stoically"], tree.suggest("sto")
  end

  def test_select_adds_multiple_selections
    tree.insert("stoically")
    tree.insert("stocking")
    2.times { tree.select("sto", "stocking") }
    3.times { tree.select("sto", "stoically") }
    assert_equal ["stoically", "stocking"], tree.suggest("sto")
  end

  def medium_word_list
    File.read("../lib/medium.txt")
  end

end
