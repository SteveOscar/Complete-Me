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

  # def count(sum = 0)
  #   children.keys.each do |trie|
  #     sum += 1 if children[trie].is_word
  #     children[trie].count(sum) unless is_word
  #   end
  #   sum
  # end

  def count
    if children.empty?
      is_word ? 1 : 0
    else
      elements = children.map do |letter, child_trie|
        child_trie.count
      end
      sum = (is_word ? 1 : 0)
      elements.each { |num| sum += num }
      sum
    end
  end

end
