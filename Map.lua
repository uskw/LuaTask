local Map = {}
Map.__index = Map
local Node = {}
Node.__index = Node

local NodeEnum = {
    Black = 1,
    Red = 2
}

function initNode(_key, _value, _color)
    local node = {}
    setmetatable(node, Node)
    node.key = _key or nil
    node.value = _value or nil
    node.color = _color or NodeEnum.Black
    node.left = {}
    node.right = {}
    node.parent = {}
    return node
end

function map()
    local newMap = {}
    setmetatable(newMap, Map)
    local node = initNode()
    newMap.root = node
    return newMap
end

function isRed(node)
    if node == nil then
        print("1不存在此节点！")
        return
    end
    if node.color == NodeEnum.Red then
        return true
    else
        return false
    end
end

function isBlack(node)
    if node == nil then
        print("2不存在此节点！")
        return
    end
    if node.color == NodeEnum.Black then
        return true
    else
        return false
    end
end

function setRed(node)
    if node == nil then
        print("3不存在此节点！")
        return
    end
    node.color = NodeEnum.Red
end

function setBlack(node)
    if node == nil then
        print("4不存在此节点！")
        return
    end
    node.color = NodeEnum.Black
end

function Map:rotateLeft(node)
    if node == nil then
        print("5不存在此节点！")
        return
    end
    local test = node.right
    node.right = test.left
    if test.left.key ~= nil then
        test.left.parent = node
    end
    test.parent = node.parent
    if node.parent.key == nil then
        self.root = test
    else
        if node.parent.left.key == node.key then
            node.parent.left = test
        else
            node.parent.right = test
        end
    end
    test.left = node
    node.parent = test
end

function Map:rotateRight(node)
    if node == nil then
        print("6不存在此节点！")
        return
    end
    local test = node.left
    node.left = test.right
    if test.right.key ~= nil then
        test.right.parent = node
    end
    test.parent = node.parent
    if node.parent.key == nil then
        self.root = test
    else
        if node.key == node.parent.right.key then
            node.parent.right = test
        else
            node.parent.left = test
        end
    end
    test.right = node
    node.parent = test
end

function Map:insert(key, value)
    if type(key) ~= "number" then
        print("插入节点索引值不正确")
        return
    end
    local node = initNode(key, value)
    local _root = self.root
    local test = {}
    if _root.key == nil then
        self.root = node
        setBlack(self.root)
        return
    end
    while _root.right ~= nil do
        test = _root
        if node.key < _root.key then
            _root = _root.left
        else
            _root = _root.right
        end
    end
    node.parent = test
    if test.key ~= nil then
        if node.key < test.key then
            test.left = node
        else
            test.right = node
        end
    else
        self.root = node
    end
    node.color = NodeEnum.Red
    self:insertFixup(node)
end

function Map:insertFixup(node)
    local test = node.parent or {}
    local _test = {}
    while test.key ~= nil and isRed(test) do
        for i = 1, 1, 1 do
            _test = test.parent or {}
            if test.key == _test.left.key then
                local uNode = _test.right
                if uNode.key ~= nil and isRed(uNode) then
                    setBlack(uNode)
                    setBlack(test)
                    setRed(_test)
                    node = _test
                    -- test = test.parent
                    break
                end
                if test.right.key == node.key then
                    local temp = {}
                    self:rotateLeft(test)
                    temp = test
                    test = node
                    node = temp
                end
                setBlack(test)
                setRed(_test)
                self:rotateRight(_test)
            else
                local _uNode = _test.left
                if _uNode.key ~= nil and isRed(_uNode) then
                    setBlack(_uNode)
                    setBlack(test)
                    setRed(_test)
                    node = _test
                    -- test = test.parent
                    break
                end
                if test.left.key == node.key then
                    local _temp = {}
                    self:rotateRight(test)
                    _temp = test
                    test = node
                    node = _temp
                end
                setBlack(test)
                setRed(_test)
                self:rotateLeft(_test)
            end
        end
        test = node.parent
    end
    setBlack(self.root)
end

function Map:remove(key)
    local node = findNode(self.root, key)
    if node == nil then
        print("7不存在此节点！")
        return
    end
    local _child = {}
    local _parent = {}
    local _color = nil
    if node.left.key ~= nil and node.right.key ~= nil then
        local temp = node
        temp = temp.right
        while temp.left.key ~= nil do
            temp = temp.left
        end
        if node.key ~= nil and node.parent.key ~= nil then
            if node.parent.left.key == node.key then
                node.parent.left = temp
            else
                node.parent.right = temp
            end
        else
            self.root = temp
        end
        _child = temp.right
        if temp.key ~= nil then
            _parent = temp.parent
            _color = temp.color
        end
        if _parent.key == node.key then
            _parent = temp
        else
            if _child.key ~= nil then
                _child.parent = _parent
            end
            _parent.left = _child
            temp.right = node.right
            node.right.parent = temp
        end
        temp.parent = node.parent
        temp.color = node.color
        temp.left = node.left
        node.left.parent = temp
        if _color == NodeEnum.Black then
            self:removeFixup(_child, _parent)
        end
        node = {}
        return
    end
    if node.left.key ~= nil then
        _child = node.left
    else
        _child = node.right
    end
    _parent = node.parent
    _color = node.color
    if _child.key ~= nil then
        _child.parent = _parent
    end
    if _parent.key ~= nil then
        if _parent.left.key == node.key then
            _parent.left = _child
        else
            _parent.right = _child
        end
    else
        self.root = _child
    end
    if _color == NodeEnum.Black then
        self:removeFixup(_child, _parent)
    end
    node = {}
end

function Map:removeFixup(node, _parent)
    local test = {}
    while node.key == nil or isBlack(node) and node.key ~= self.root.key do
        if _parent.left.key == node.key then
            test = _parent.right
            if isRed(test) then
                setBlack(test)
                setRed(_parent)
                self:rotateLeft(_parent)
                test = _parent.right
            end
            if test.left.key == nil or isBlack(test.left) and test.right.key == nil or isBlack(test.right) then
                setRed(test)
                node = _parent
                if node ~= nil then
                    _parent = node.parent
                end
            else
                if test.right.key == nil or isBlack(test.right) then
                    setBlack(test.left)
                    setRed(test)
                    self:rotateRight(test)
                    test = _parent.right
                end
                if test ~= nil then
                    if _parent ~= nil then
                        test.color = _parent.color
                    else
                        test.color = NodeEnum.Black
                    end
                end
                setBlack(_parent)
                setBlack(test.right)
                self:rotateLeft(_parent)
                node = self.root
                break
            end
        else
            test = _parent.left
            if isRed(test) then
                setBlack(test)
                setRed(_parent)
                self:rotateRight(_parent)
                test = _parent.left
            end
            if test.left.key == nil or isBlack(test.left) and test.right.key == nil or isBlack(test.right) then
                setRed(test)
                node = _parent
                if node ~= nil then
                    _parent = node.parent
                end
            else
                if test.left == nil or isBlack(test.left) then
                    setBlack(test.right)
                    setRed(test)
                    self:rotateLeft(test)
                    test = _parent.left
                end
                if test ~= nil then
                    if _parent ~= nil then
                        test.color = parent.color
                    else
                        test.color = NodeEnum.Black
                    end
                end
                setBlack(_parent)
                setBlack(test.left)
                self:rotateRight(_parent)
                node = self.root
                break
            end
        end
    end
    if node ~= nil then
        setBlack(node)
    end
end

function findNode(node, key)
    if key == nil or type(key) ~= "number" then
        print("查找索引值不正确！")
        return
    end
    if node.key == nil then
        print("8不存在此节点！")
        return
    end
    if node.key > key then
        return findNode(node.left, key)
    elseif node.key < key then
        return findNode(node.right, key)
    else
        return node
    end
end

function Map:find(key)
    local node = findNode(self.root, key)
    if node == nil then
        return false
    else
        return true
    end
end

function printNode(node)
    if node == nil then
        print("9不存在此节点！")
        return
    end
    if node.left ~= nil then
        printNode(node.left)
    end
    if node.value ~= nil then
        print("node.key =", node.key, " node.value =", node.value, " node.color =", node.color == 1 and "Black" or "Red")
    end
    if node.right ~= nil then
        printNode(node.right)
    end
end

function Map:output()
    if self.root.key == nil then
        print("当前红黑树为空\n***************")
        return
    end
    printNode(self.root)
    print("***************")
end

function Map:clear()
    self.root = {}
end

return map