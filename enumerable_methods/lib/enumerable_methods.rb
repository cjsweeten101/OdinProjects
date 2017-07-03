module Enumerable
  def my_each
  	i = 0 
  	while i < self.length do 
  	  yield(self[i])
  	  i += 1
  	end
  	self
  end

  def my_each_with_index 
  	i = 0 
  	while i < self.length do 
  	  yield(self[i], i)
  	  i += 1
  	end
  	self
  end

  def my_select 
  	result = []
  	self.my_each do |v| 
  	  result << v if (yield v)
  	end
  	result
  end

  def my_all?
  	result = true
  	if block_given?
  	  self.my_each do |v|
  	    result = false if !(yield v)
  	  end
  	else
  	  self.my_each do |v|
  	  	result = false if !v
  	  end
  	end
  	result
  end

  def my_any?
    result = false
    if block_given?
      self.my_each do |v|
        result = true if (yield v)
      end
    else
      self.my_each do |v|
        result = true if v
      end
    end
    result
  end

  def my_none?
    result = true
    if block_given?
      self.my_each {|v| result = false if (yield v)}
    else
      self.my_each {|v| result = false if (v)}
    end
    result
  end

  def my_count *args
    count = 0
    if args.empty? && !block_given?
      self.my_each { count += 1 }
    elsif block_given?
      self.my_each {|v| count += 1 if (yield v)}
    else
      self.my_each do |v|
        args.each do |arg|
          count += 1 if arg == v
        end
      end
    end
    count
  end

  def my_map proc = nil
    result = []
    return to_enum(:my_select) unless block_given? || proc
    if proc
      self.my_each {|v| result << proc.call(v)}
    else
      self.my_each {|v| result << (yield v)}
    end
    result
  end

  def my_inject *args
    args.empty? ? i = 0 : i = args[0]
    total = self.to_a[i]
    self.to_a[i+1..self.to_a.length].my_each { |i| total = yield(total,i)}
    total
  end
end

def multiply_els arr
  arr.my_inject {|tot , i| tot*i}
end