#===================================================
#Classes, objects, and variables
#===================================================
class Adder
  @@grand_total = 0
  
  def initialize(addend)
    @addend = addend
    @total = 0
  end
  
  def add(value)
    result = value + @addend
    @total += result
    @@grand_total += result
    return result
  end
  
  def total
    return @total
  end
  
  def Adder.grand_total
    return @@grand_total
  end
end

a = Adder.new(1)
b = Adder.new(100)
x = a.add(5)
y = a.add(6)
z = b.add(7)
puts "5 + 1: #{x}"
puts "6 + 1: #{y}"
puts "7 + 100: #{z}"

puts "total for a: #{a.total}"
puts "total for b: #{b.total}"
puts "Grand total: #{Adder.grand_total}"

#=========================================================
# Blocks/Closures
#=========================================================
#class Foo
#  def a(x, &block)
#    return x + block.call(42)
#  end
#  
#  def b(x)
#    return x + yield(42)
#  end
#  
#  def c(x, block)
#    return x + block.call(42)
#  end
#end
#
#f = Foo.new
#puts f.a(100) {|v| v + 5}
#puts f.b(100) {|v| v + 5}
#puts f.c(100, lambda{|v| v + 5})

#===================================
# Threads
#===================================
#t1 = Thread.new {
#  puts 'a'
#  sleep 1
#  puts 'b'
#}
#
#t2 = Thread.new {
#  puts 'x'
#  sleep 1
#  puts 'y'
#}
#
#t1.join
#t2.join

#================================================
# Mutual exclusion
#================================================
#m = Mutex.new
#t1 = Thread.new {
#  m.synchronize {
#    puts 'a'
#    sleep 1
#    puts 'b'
#  }
#}
#
#t2 = Thread.new {
#  m.synchronize {
#    puts 'x'
#    sleep 1
#    puts 'y'
#  }
#}
#
#t1.join
#t2.join

#================================================
# Condition variables
#================================================
#m = Mutex.new
#c1 = ConditionVariable.new
#t1 = Thread.new {
#  m.synchronize {
#    puts 'a'
#    c1.wait(m)
#    puts 'b'
#  }
#}
#
#sleep 1
#
#t2 = Thread.new {
#  m.synchronize {
#    puts 'x'
#    c1.signal
#    puts 'y'
#  }
#}
#
#t1.join
#t2.join

