local List = {}
List.__index = List
local Node = {}
Node.__index = Node

function initNode(value)
    local node = {}
    setmetatable(node, Node)
    node.prev = node
    node.next = {}
    node.value = value
    return node
end

local function list()
    local newList = {}
    setmetatable(newList, List)
    newList.head = {}
    newList.tail = {}
    newList.size = 0
    return newList
end

function List:push(value)
    if type(value) ~= "number" then
        print("压入列表数值不合法\n********************")
        return
    end
    local node = initNode(value)
    if self.size == 0 then
        self.head = node
        self.tail = node
        node.prev = node
        node.next = {}
        self.size = 1
        return node
    end
    node.next = {}
    node.prev = self.tail
    self.tail.next = node
    self.tail = node
    self.size = self.size + 1
    return node
end

function List:insert(node, value)
    if type(value) ~= "number" then
        print("插入列表数值不合法\n********************")
        return
    end
    if node == nil then
        print("列表中没有参数node\n********************")
        return
    end
    local test = initNode(value)
    test.next = node.next
    test.prev = node
    node.next.prev = test
    node.next = test
    if node == self.tail then
        self.tail = test
    end
    self.size = self.size + 1
end

function List:remove(node)
    if node == nil then
        print("列表中没有参数node\n********************")
        return
    end
    if node.next.value == nil then
        self.tail = node.prev
        node.prev.next = {}
        node.prev = nil
        node.next = nil
    else
        node.next.prev = node.prev
        node.prev.next = node.next
        node.prev = nil
        node.next = nil
    end
    self.size = self.size - 1
    if self.size == 0 then
        self.head = {}
        self.tail = {}
    end
end

function List:getHead()
    return self.head
end

function List:getTail()
    return self.tail
end

function Node:getPre()
    return self.prev
end

function Node:getNext()
    return self.next
end

function List:popAll()
    while self.size ~= 0 do
        local node = self.tail
        self:remove(node)
    end
    print("全部pop完成")
end

function iter(_Head)
    return function()
        if _Head.value ~= nil then
            _Value = _Head.value
            _Head = _Head.next
            return _Value
        end
        local _Value = nil
    end
end

function List:output()
    local _Head = self.head
    for v in iter(_Head) do
        if(v) then
            print(v)
        else
            break
        end
    end
    print("*********************")
end

return list