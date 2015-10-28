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

  # def auto_suggest(prefix)
  #   if
  #
  #   end
  # end

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

end
