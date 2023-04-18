return function(modules, callback)
	if modules ~= nil then
		local result = nil
		if type(modules) == 'table' then
			result = {}
			for k = 1, #modules do
				local ok, m = pcall(require, modules[k])
				if not ok then
					modules[k] = nil
				else
					result[modules[k]] = m
				end
			end
		elseif type(modules) == 'string' then
			local ok, m = pcall(require, modules)
			if ok then
				result = m
			end
		end
		if callback ~= nil and result ~= nil then
			callback(result)
		end
	end
end
