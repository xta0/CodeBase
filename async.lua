-- co = coroutine.create(function()
-- 	for i=1,3 do 
-- 		print("index: ",i)
--         coroutine.yield()
--     end
-- end)
-- coroutine.resume(co) --co 1
-- coroutine.resume(co)--co 1
-- coroutine.resume(co) --co 1
-- coroutine.resume(co) --co 1

co = coroutine.create(function(a)
	local c = coroutine.yield(a+1) 
	print("main func a: ",a) 
	return 2*a 
end)
b,v = coroutine.resume(co,20)
print(b,v) -- 21
--从yield后面执行
d,v = coroutine.resume(co,100)
print(d,v) -- 40