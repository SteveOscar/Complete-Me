require 'pry'
require 'set'
class CompleteMe
  attr_accessor :children, :flag, :word

  def initialize(word = nil, flag = false)
    @children = {}
    @flag = flag
    @word = word
    @count = 0
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
    @count += 1
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

  def count
    @count
  end

  # def count(sum = 0)
  #   keys = children.keys
  #   keys.each do |key|
  #     sum += 1 if children[key].flag
  #     children[key].count(sum) unless flag
  #   end
  #   sum
  # end

end
