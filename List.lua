local List = {}
local Node = {}

function initNode(value)
    local node = {}
    setmetatable(node, Node)
    Node.__index = Node
    node.prev = node
    node.next = node
    node.value = value
    return node
end

function list()
    local test = {}
    setmetatable(test, List)
    List.__index = List
    local node = initNode()
    test.head = node
    test.tail = node
    test.size = 0
    return test
end

function List:push(value)
    local node = initNode(value)
    node.next = self.tail
    node.prev = self.tail.prev
    self.tail.prev.next = node
    self.tail.prev = node
    self.size = self.size + 1
    return node
end

function List:insert(node, value)
    local test = initNode(value)
    test.next = node.next
    test.prev = node
    node.next.prev = test
    node.next = test
    self.size = self.size + 1
end

function List:remove(node)
    if node.next == nil then
        node.next = node
        node.prev = node
    else
        node.next.prev = node.prev
        node.prev.next = node.next
        node.prev = nil
        node.next = nil
    end
    self.size = self.size - 1
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
        local node = self.head
        self:remove(node)
    end
    print("全部pop完成")
end

function iter(_Head)
    return function()
        local _Value = nil
        _Value = _Head.value
        _Head = _Head.next
        return _Value
    end
end

function List:output()
    local _Head = self.head.next
    for v in iter(_Head) do
        if(v) then
            print(v)
        else
            break
        end
    end
    print("*********************")
end

local demo = list()
local node1 = demo:push(1)
demo:output()
local node2 = demo:push(2)
demo:output()
local node3 = demo:insert(node1, 3)
demo:output()
demo:remove(node2)
demo:output()
local nodeHead = demo:getHead()
print(nodeHead.next.value)
local nodeTail = demo:getTail()
print(nodeTail.prev.value)
local _pre = nodeTail:getPre()
print(_pre.value)
local _next = nodeHead:getNext()
print(_next.value,"\n********************")
demo:popAll()
demo:output()