local Str = {}

function Str:str()
    local test = {}
    setmetatable(test, self)
    self.__index = self
    test.len = 0
    return test
end

function Str:insert(pos, value)
    local num = self.len
    if pos > num then
        self[pos] = value
    end
    for i=1,num,1 do
        if(i == pos) then
            for j=num+1,i,-1 do
                self[j] = self[j-1]
            end
            self[i] = value
        end
    end
    self.len = self.len + 1
end

function Str:reset(test)
    local num = test.len()
    for i=1,num,1 do
        self[i] = test[i]
    end
end

function Str:equal(test)
    local num1 = self.len
    local num2 = test.len
    if(num1 ~= num2) then
        return false
    end
    for k,v in ipairs(self) do
        if(self[k] ~= test[k]) then
            return false
        end
    end
    return true
end

function Str:append(test)
    local num1 = self.len
    local num2 = test.len
    for i=num1+1,num1+num2,1 do
        self[i] = test[i-num1]
        self.len = self.len + 1
    end
end

function Str:sub(start, over)
    local test = Str:str()
    for k,v in pairs(self) do
        if(k == start) then
            for i=1,over,1 do
                test[i] = self[k+i-1]
                test.len = test.len + 1
            end
        end
    end
    return test
end

function Str:output()
    for i=1,self.len,1 do
        print(self[i])
    end
    print("\n")
end

local demo = Str:str()
demo:insert(1, "v")
local test = Str:str()
test:insert(1, "a")
test:insert(2, "p")
test:insert(3, "p")
test:insert(4, "l")
test:insert(5, "e")
print(test:output())
demo:append(test)
demo:output(demo)
print(demo:equal(test))
print(demo:sub(1, 3).len)