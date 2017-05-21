require_relative 'node'
class LinkedList

  attr_accessor :head, :tail

  def initiliaze
  	@head = nil
  	@tail = nil
  end

  def append node
  	if @tail.nil?
  		@tail = node
  		@head = node
  	else
  		@tail.next_node = node
  		@tail = node
  	end
  end

  def prepend node
  	if @tail.nil?
  		@tail = node
  		@head = node
  	else
  		node.next_node = @head
  		@head = node 
  	end
  end

  def size
  	return 0 if @head.nil?
  	count = 1
  	current = @head
  	until current.next_node.nil?
  		count += 1
  		current = current.next_node
  	end
  	count
  end

  def at index
  	return nil if !(0..size).include? index
  	return @head if index == 0
  	count = 0
  	current = @head
  	until count == index
  		count += 1
  		current = current.next_node
  	end
  	return nil if current.nil?
  	current
  end

  def pop
  	return nil if size == 0
  	pop = @tail
  	if size == 1
  		@tail = nil
  		@head = nil
  	else
  		@tail = at(size - 2)
  		@tail.next_node = nil
  	end
  	pop
  end

  def to_s
  	result = ''
  	return "Empty. . ." if size == 0
  	size.times do |i|
  	  result += " (#{at(i).value}) ->"
  	end
  	result
  end

  def contains? value
  	current = @head
  	until current == nil
  		return true if current.value == value
  		current = current.next_node
  	end
  	false
  end

  def find value
  	if contains? value
  		index = 0
  		loop do 
  			return index if at(index).value == value
  			index += 1 
  		end
  	else	
  		nil
  	end
  end

  def insert_at node, index
  	return nil if !(1..size).include? index
  	prev_node = at(index - 1)
  	node.next_node = prev_node.next_node
  	prev_node.next_node = node
  end

  def remove_at index
  	return nil if !(0..size).include? index
  	prev_node = at(index - 1)
  	next_node = at(index + 1)
  	if at(index) == @head
  		@head = next_node
  	elsif at(index) == @tail
  		@tail = prev_node
  		@tail.next_node = nil
  	else
  		prev_node.next_node = next_node
  	end
  end
end