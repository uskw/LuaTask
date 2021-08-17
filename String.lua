local Str = {}

function String(strTable)
    local test = {}
    setmetatable(test, Str)
    Str.__index = Str
    test.data = strTable or {}
    test.length = #strTable
    return test
end

function Str:len()
    return self.length
end

function Str:insert(pos, value)
    local num = self.length
    if pos > num+1 then
        print("插入位置不合法\n*********************")
        return
    end
    if type(value) ~= "string" then
        print("插入对象不合法\n*********************")
        return
    end
    for i=num+1,pos+1,-1 do
        self.data[i] = self.data[i-1]
    end
    self.data[pos] = value
    self.length = self.length + 1
end

function Str:reset(test)
    if type(test) ~= "table" then
        print("参数类型错误\n*********************")
        return
    end
    local num = #test
    self.length = 0
    if num == 0 then
        print("需要重置为空\n*********************")
        self.data = {}
        return
    end
    for i=1,num,1 do
        self.data[i] = test[i]
    end
    self.length = num
end

function Str:equal(test)
    local num1 = self.length
    local num2 = test.length
    if(num1 ~= num2) then
        return false
    end
    for i=1,num1,1 do
        if(self.data[i] ~= test.data[i]) then
            return false
        end
    end
    return true
end

function Str:append(test)
    if type(test) ~= "table" then
        print("参数类型错误\n*********************")
        return
    end
    local num1 = self.length
    local num2 = #test
    for i=num1+1,num1+num2,1 do
        self.data[i] = test[i-num1]
        self.length = self.length + 1
    end
end

function Str:sub(start, over)
    if start<0 and over>self.length then
        print("参数不合法\n*********************")
        return
    end
    local test = {}
    for i=start,over,1 do
        test[i-start+1] = self.data[i]
    end
    return test
end

function Str:output()
    for i=1,self.length,1 do
        print(self.data[i])
    end
    if self.length == 0 then
        print("当前数组为空！")
    end
    print("*********************")
end

local demo1 = String({"t","e","s","t","1"})
demo1:output()
local demo2 = String({"t","e","s","t","2"})
demo2:output()
demo1:reset({"t","e","s","t","3"})
demo1:output()
local int_Len = demo1:len()
print(int_Len,"\n*********************")
local table_Sub = demo1:sub(1, 2)
print(table_Sub[1],table_Sub[2],"\n*********************")
demo1:append({"a","p","p","e","n","d"})
demo1:output()
local bool_Equal = demo1:equal(demo2)
print(bool_Equal,"\n*********************")