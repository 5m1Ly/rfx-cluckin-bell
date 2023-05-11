-- holds the methods for the collection
local Methods = {}

function Methods.has(self, key)
	for _, value in next, self.store do
		if value[1] == key then
			return true
		end
	end
	return false
end

-- adds a new item to the collection
function Methods.set(self, key, value, overwrite)
	-- ensure we have a valid key
	if type(key) ~= "string" then
		print "Invalid Key Type"
		return false
	end
	-- ensure we have a valid value
	if value == nil then
		print "Invalid Value Type"
		return false
	end
	-- ensure we don't already have the key
	local exist = self.has(key)
	if not overwrite and exist then
		print "Key Already Exists"
		return false
	elseif overwrite and exist then
		for i, entry in next, self.store do
			if entry[1] == key then
				self.store[i][2] = value
			end
		end
	else
		table.insert(self.store, { key, value })
	end
	-- return true
	return self
end

-- ensure we have a valid collection
local function ValidateCollection(store)
	for key, value in next, store do
		if type(key) ~= "number" then
			print "Invalid Collection Sub Table Definition"
			return false
		end
		if type(value[1]) ~= "string" then
			print "Invalid Collection Key Definition"
			return false
		end
		if value[2] == nil then
			print "Invalid Collection Value Definition"
			return false
		end
	end
	return true
end

-- adds the methods to the collection
local function SupplyMethods(tbl)
	local self = tbl or { store = {} }
	for name, method in next, Methods do
		self[name] = setmetatable({}, {
			__index = self,
			__call = function(self, ...) return method(self, ...) end
		})
	end
	return self
end

-- removes the methods from the collection
local function StripMethods(tbl)
	if tbl.store == nil then return tbl end
	for key in next, Methods do
		if tbl[key] then
			tbl[key] = nil
		end
	end
	return tbl.store
end

-- creates a new collection
local function Collection(collection)
	local self = { store = {} }
	-- ensure we have a table
	if collection ~= nil then
		collection = StripMethods(collection)
		if not ValidateCollection(collection) then
			print "Defaulting To Empty Collection"
			print "Please Check Your Collection Definition"
			print "Which Should Be Like The Following:"
			print "Collection({ { 'key', value }, { 'key', value } })"
			return self
		end
		self.store = collection
	end
	return SupplyMethods(self)
end

local map = Collection({
	{ "Jan", 30 },
	{ "John", 20 },
	{ "Jane", 25 },
	{ "Bob", 35 }
})

map.set("Pieter", 40)

local map2 = Collection(map)

map2.set("Jack", 40)
map2.set("Jack", 38, true)

QBCore.Debug(map2)
