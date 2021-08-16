local Array = {}

function Array:array()
    local test = {}
    setmetatable(test, self)
    self.__index = self
    test.size = 0
    return test
end

function Array:insert(pos, value)
    local num = self.size
    if num == 0 then
        self[pos] = value
    end
    for i=1,num,1 do
        print(i, pos)
        if(i == pos) then
            for j=num+1,i,-1 do
                self[j] = self[j-1]
            end
            self[i] = value
        end
    end
    self.size = self.size + 1
end

function Array:remove(pos)
    local num = self.size
    for i=1,num,1 do
        if i == pos then
            for j = i,num-1,1 do
                self[j] = self[j+1]
            end
        end
    end
    self[num] = nil
    self.size = self.size - 1
end

function Array:clear()
    self = {}
    
    self.size = 0
end

-- 从后压
function Array:push(value)
    local pos = self.size
    self[pos+1] = value
    self.size = self.size + 1
end

-- 从后出
function Array:pop()
    local pos = self.size
    local value = self[pos]
    self[pos] = nil
    self.size = self.size - 1
    return value
end

function Array:output()
    for _,v in ipairs(self) do
        print(v)
    end
    print("\n")
end

local demo = Array:array()
print(demo.size)
demo:insert(1, 5)
print(demo:output())
demo:push(4)
print(demo:output())
demo:remove(1)
print(demo:output())
demo:pop()
print(demo:output())