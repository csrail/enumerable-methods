# Create #my_each, a method that is identical to #each but (obviously) 
# does not use #each. You'll need to remember the yield statement. 
# Make sure it returns the same thing as #each as well.

# yield and #call
# require "./my_each.rb"

#include Enumerable
#my_each do |object| 
#	p object
#end

words_array = ["first", "second", "third"]
numbers_array = [1,2,3,4,5,6,7,8,100]

module Enumerable
  def my_each
  	i = 0
  	while i < self.length
  		yield self[i]
  		i +=1
  	end
    self
  end

  def my_each_with_index
  	i = 0

  	while i < self.length
  		yield self[i], i
  		i +=1
  	end
    self
  end


  def my_select
  	i = 0
  	ary = []
  	while i < self.length
  		ary << self[i] if yield (self[i])
  		i +=1
  	end
  	ary
  end

  def my_all?
    i = 0
    while i < self.length   
      if yield self[i]
        self[i]
      else
        return false
      end
      i +=1
    end
  end

  def my_none?
    i = 0
    while i < self.length
      if yield self[i]
        return false
      else
        !self[i]
      end
      i +=1
    end
  end

  def my_count(value=nil)
    i = 0
    counter = 0

    while i < self.length
      if self[i] == value
        counter +=1
      elsif block_given? 
        if yield self[i]
          counter +=1
        end
      end
      i +=1
    end

    if counter > 0
      counter
    else
      i    
    end
  end

#INITIAL my_map
=begin
  def my_map
    i = 0
    range_array = self.to_a
    ary = []
    while i < range_array.length
      ary << (yield range_array[i])
      i +=1
    end
    ary
  end
=end


  def my_inject(input=nil)
    i = 0
    range_array = self.to_a
    if input != nil
      total = input
    else
      total = 0
    end

    while i < range_array.length
      total = (yield (total), (range_array[i]))
      i +=1
    end
    p total 
  end

=begin
  def my_map(&block)
    i = 0
    range_array = self.to_a
    ary = []
    while i < range_array.length
      ary << (block.call(range_array[i]))
      i +=1
    end
    ary
  end
=end

  def my_map(&block)
    i = 0
    range_array = self.to_a
    ary = []

    if block
      while i < range_array.length
        ary << (block.call(range_array[i]))
        i +=1
      end
    else
      while i < range_array.length
        ary << (yield range_array[i])
        i +=1
      end
    end
    ary
  end

end


p (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]


#TESTs
=begin
###CHECKING FOR my_each

words_array.my_each do |instance|
	p instance
end

#### CHECKING FOR my_each_with_index

words_array.my_each_with_index do |instance, idx|
	p "#{idx.to_s}: #{instance}"
end

###CHECKING FOR my_select

chosen_numbers = numbers_array.my_select do |choice|
	choice * 2 > 5
end

p "Method: my_select"
p chosen_numbers

chosen_numbers_2 = numbers_array.select do |choice|
	choice * 2 > 5
end

p "Ruby's Method: select"
p chosen_numbers_2

###CHECKING FOR my_all?

if [1<2, 1<2, 1<2].my_all? do |result|
  p "hello"
  p result
  end
end

if [1<2, 1<2, 1<2].all? do |result|
  p "hello"
  p result
  end
end

###CHECKING FOR my_none?

if [1<2, 1<2, 1<2].my_none? do |result|
  p "hello"
  p result
  end
end

if [1<2, 1<2, 1<2].none? do |result|
  p "hello"
  p result
  end
end

###CHECKING FOR my_count

ary = [1, 2, 4, 2]
ary.my_count                  #=> 4
ary.my_count(2)               #=> 2
ary.my_count { |x| x%2 == 0 } #=> 3




###CHECKING FOR my_inject
(5..10).my_inject { |sum, n| sum + n} # => 45
(5..10).my_inject(1) { |product, n| product * n } #=> 151200
=end