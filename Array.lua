local Array = {}
Array.__index = Array

local function array()
    local newArray = {}
    setmetatable(newArray, Array)
    newArray.data = {}
    newArray.size = 0
    return newArray
end

function Array:insert(pos, value)
    local num = self.size
    if pos > num or pos < 1 then
        print("插入位置不合法")
        print("*********************")
        return
    end
    for i = num + 1, pos + 1, -1 do
        self.data[i] = self.data[i - 1]
    end
    self.data[pos] = value
    self.size = self.size + 1
end

function Array:remove(pos)
    local num = self.size
    if pos > num or pos < 1 then
        print("移除位置不合法")
        print("*********************")
        return
    end
    for i = pos, num - 1, 1 do
        self.data[i] = self.data[i + 1]
    end
    self.data[num] = nil
    self.size = self.size - 1
end

function Array:clear()
    self.data = {}
    self.size = 0
end

function Array:push(value)
    local pos = self.size
    self.data[pos + 1] = value
    self.size = self.size + 1
end

function Array:pop()
    local pos = self.size
    if pos == 0 then
        print("当前数组为空，无法pop！")
        print("*********************")
        return
    end
    local value = self.data[pos]
    self.data[pos] = nil
    self.size = self.size - 1
    return value
end

function Array:output()
    if self.size == 0 then
        print("当前数组为空！")
    end
    for i = 1, self.size, 1 do
        print(self.data[i])
    end
    print("*********************")
end

return array