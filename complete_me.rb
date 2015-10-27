require 'pry'

class CompleteMe
  attr_accessor :children, :flag, :word, :total

  def initialize(word = nil, flag = false)
    @children = {}
    @flag = flag
    @word = word
    @total = 0
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

  def keys(node)
    node.children.keys
  end

  def count(node)
    node.children.keys.each do |key|
      @total += 1 if node.children[key].flag
    end
    total
  end



end
