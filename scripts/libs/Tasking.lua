local coroutine = require 'coroutine'

local sparse = {}
local compact = {}

local count = 0

Tasking = {
	wait = function(time) coroutine.yield(time / 1000) end
}

local function halt(self)
	self.halted = true
end

local function resume(self)
	self.halted = false
end

local function isAlive(self)
	return self.id
end

function Tasking.new(f, halted)
	count = count + 1
	local task = { 
		f = coroutine.create(f), 
		wake_time = os.clock(), 
		halted = halted, 
		halt = halt,
		isAlive = isAlive, 
		resume = resume,
		id = #compact + 1,
	}
	sparse[count] = task
	table.insert(compact, count)
	return sparse[count]
end

function Tasking.tick()
	for k, v in ipairs(compact) do
		local task = sparse[v]
		if task.wake_time < os.clock() and not task.halted then
			if coroutine.status(task.f) == 'dead' then
				Tasking.remove(task)
			else
				local resumed, result = coroutine.resume(task.f)
				if not resumed then
					error(result, 2)
				elseif result ~= nil then
					task.wake_time = os.clock() + result
				end
			end
		end
	end
end

function Tasking.remove(task)
	if task:isAlive() then
		local id = task.id
		sparse[compact[id]] = nil
		task.id = nil
		table.remove(compact, id)
		for i = id, #compact do
			sparse[compact[i]].id = i
		end
	end
end

function Tasking.defer(f, time, ...)
	local tab = {...}
	return Tasking.new(function()
		Tasking.wait(time)
		f(unpack(tab))
	end)
end

return Tasking