require 'pry'
class CompleteMe
  attr_accessor :children, :is_word, :word, :weighted

  def initialize(word = nil, is_word = false)
    @children = {}
    @is_word = is_word
    @word = word
    @weighted = {}
  end

  def populate(text)
    words = text.split("\n")
    words.each { |word| insert(word)}
  end

  def select(prefix, word)
    @weighted[word].nil? ? @weighted[word] = 1 : @weighted[word] += 1
  end

  def count
    if children.empty?
      is_word ? 1 : 0
    else
      elements = children.map do |letter, child|
        child.count
      end
      elements.reduce(:+) + (is_word ? 1 : 0)
    end
  end

  def add_letter_node(letter, string)
    val = word ? word + letter : letter
    if val == string
      children[letter] = CompleteMe.new(val, true)
    else
      children[letter] = CompleteMe.new(val)
    end
  end

  def insert(string)
    if (string.is_a? String) && string.length > 0
      walk_tree(string, 1)
    else
      return "Only insert strings"
    end
  end

  def walk_tree(string, count)
    node = self
    string.each_char do |letter|
      if node.children.has_key?(letter)
        node.children[letter].is_word = true if count == string.length
      else
        node.add_letter_node(letter, string)
      end
      node = node.children[letter]
      count += 1
    end
  end

  def suggestion_weighting(suggestions)
    weigh = Hash[suggestions.map {|x| [x, 0]}]
    weigh.each { |k, v| weigh[k] = @weighted[k] if @weighted.keys.include?(k) }
    weigh = weigh.sort_by { |k, v| k }.sort_by { |k, v| -v }
    return weigh.map { |k, v| k }
  end

  def suggest(prefix)
    node = self
    prefix.each_char do |letter|
      return unless node.children.has_key?(letter)
      node = node.children[letter]
    end
    suggestion_weighting(node.retrieve_endings)
  end

  def retrieve_endings
    if children.empty?
      word if is_word
    else
      endings = children.map { |letter, child| child.retrieve_endings}
      endings << word if is_word
      return endings.flatten
    end
  end
end
