class Hand

  attr_reader :content

  def initialize
    @content = {}
  end

  def set(item, value)
    @content[item] = value
  end

  def add(item)
    @content[item] ||= 0
    @content[item] += 1
  end

  def remove(item)
    raise StandardError.new 'Not supposed removing a non existing item' unless @content[item]
    @content[item] -= 1
    @content.delete(item) if @content[item] == 0
  end

  def empty?
    @content.values.sum == 0
  end

  def exhausted?(item)
    @content[item] == 0
  end

  def keys
    @content.keys
  end

end