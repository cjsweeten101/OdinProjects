def fibs n
  seq = [0,1]
  n.times do |n|
  	if n == 0 || n == 1
  	  print "#{seq[n]} "
  	  next
  	end
  	seq << seq[n-2] + seq[n-1]
  	print "#{seq[n]} "
  end
end

def fibs_rec n, start
  return start if n == 1 || n == 0
  start << start[-1] + start[-2]
  fibs_rec(n-1, start)
end

puts fibs_rec(8,[0,1])