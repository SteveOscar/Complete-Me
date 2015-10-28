require 'pry'
require 'set'
class CompleteMe
  attr_accessor :children, :is_word, :word

  def initialize(word = nil, is_word = false)
    @children = {}
    @is_word = is_word
    @word = word
  end

  def add_letter(letter, string)
    val = word ? word + letter : letter
    if val == string
      children[letter] = CompleteMe.new(val, true)
    else
      children[letter] = CompleteMe.new(val)
    end
  end

  def insert(string)
    node = self
    string.each_char do |letter|
      node.add_letter(letter, string) unless node.children.has_key?(letter)
      node = node.children[letter]
    end
  end

  def populate(text)
    words = text.split("\n")
    words.each { |word| insert(word)}
  end

  # a  count -> [2].reduce(:+) + (0) => 2
  # b* count -> [1].reduce(:+) + (1) => 2
  # c*       ->            1         => 1
  def count
    if children.empty?
      is_word ? 1 : 0
    else
      elements = children.map do |letter, child_trie|
        child_trie.count
      end
      elements.reduce(:+) + (is_word ? 1 : 0)
    end
  end

  def auto_suggest(prefix)
    node = self
    prefix.each_char do |letter|
      return unless node.children.has_key?(letter #removed Set.new after return
      node = node.children[letter]
    end
    return node.retrieve_endings
  end

  def retrieve_endings
    if children.empty?
      word if is_word
    else
      endings = children.map do |letter, child_trie|
        child_trie.retrieve_endings
      end
      endings << word if is_word
      puts endings
    end
  end

end
  # def auto_suggest(prefix)
  #   node = self
  #   prefix.each_char do |letter|
  #     return Set.new
  #     node = node.children
  #   end
  #   return node.prefixes
  # end
  #
  # def prefixes
  #   results = Set.new
  #   results.add if is_word?
  #   return if children.empty?
  # end
