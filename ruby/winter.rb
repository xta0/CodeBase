#!/usr/bin/ruby2.1.0
#encoding:utf-8

# 求解三和问题，看了winter和赵劼的手写代码有感
# 

#input : "1,2,3,-3,-2,-1"

# preprocess
input = ARGV[0]
puts "inputs: #{input}"
input = input.split(",").select{|i| i.length > 0}.map(&:to_i).uniq
puts "after preprocess: #{input} count:#{input.count}"
input = input.sort
puts "after sort:#{input}"

$COUNT = input.count

round = 0
input.each{ |i|

	lpos = round+1
	rpos = $COUNT - 1
	
	while (lpos < rpos)

			#a+b = -c
			if input[lpos] + input[rpos] > -i 
				rpos -= 1
			elsif input[lpos] + input[rpos] < -i
				lpos += 1
			else
				puts "Hit:{#{input[lpos]},#{input[rpos]},#{i}} --> {l:#{lpos},r:#{rpos}}"
				lpos += 1
				rpos -= 1
			end

	end
	round +=1
}

