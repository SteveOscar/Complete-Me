require 'pry'
class CompleteMe
  attr_accessor :children, :is_word, :word, :weighted

  def initialize(word = nil, is_word = false)
    @children = {}
    @is_word = is_word
    @word = word
    @weighted = {}
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
      @is_word = true if node.children.has_key?(letter) && letter == string[-1]
    end
  end

  def populate(text)
    words = text.split("\n")
    words.each { |word| insert(word)}
  end

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

  def suggestion_weighting(suggestions)
    weigh = Hash[suggestions.map {|x| [x, 0]}]
    weigh.each do |k, v|
      if @weighted.keys.include?(k)
        weigh[k] = @weighted[k]
      end
    end
    weigh = weigh.sort_by { |k, v| -v }
    return weigh.map { |k, v| k }
    #.sort_by { |k, v| -v }.map { |k, v| k }
  end

  def select(prefix, word)
    if @weighted[word].nil?
      @weighted[word] = 1
    else
      @weighted[word] += 1
    end
  end

  def suggest(prefix)
    node = self
    prefix.each_char do |letter|
      return unless node.children.has_key?(letter) #removed Set.new after return
      node = node.children[letter]
    end
    answer = node.retrieve_endings
    suggestion_weighting(answer)
  end

  def retrieve_endings
    if children.empty?
      word if is_word
    else
      endings = children.map do |letter, child_trie|
        child_trie.retrieve_endings
      end
      endings << word if is_word
      return endings.flatten
    end
  end

  ## add tests that RaiseError

end
