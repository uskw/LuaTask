local Map = {}
local Node = {}

local NodeEnum = {
    Black = 1,
    Red = 2
}

function initNode(_key, _value, _color)
    local node = {}
    setmetatable(node, Node)
    Node.__index = Node
    node.key = _key or nil
    node.value = _value or nil
    node.color = _color or NodeEnum.Black
    node.left = {}
    node.right = {}
    node.parent = {}
    return node
end

function map()
    local test = {}
    setmetatable(test, Map)
    Map.__index = Map
    local node = initNode(1,2)
    test.root = node
    return test
end

function isRed(node)
    if node.color == NodeEnum.Red then
        return true
    else
        return false
    end
end

function isBlack(node)
    if node.color == NodeEnum.Black then
        return true
    else
        return false
    end
end

function setRed(node)
    node.color = NodeEnum.Red
end

function setBlack(node)
    if node == nil then
        print("不存在此节点！")
        return
    end
    node.color = NodeEnum.Black
end

function rotateLeft(node)
    local test = node.right
    node.right = test.left
    if test.left ~= nil then
        test.left.parent = node
    end
    test.parent = node.parent
    if node.parent == nil then
        self.root = test
    elseif node.parent.left == node then
        node.parent.left = test
    else
        node.parent.right = test
    end
    test.left = node
    node.parent = test
end

function rotateRight(node)
    local test = node.left
    node.left = test.right
    if test.right ~= nil then
        test.right.parent = node
    end
    test.parent = node.parent
    if node.parent == nil then
        self.root = test
    elseif node == node.parent.right then
        node.parent.right = test
    else
        node.parent.left = test
    end
    test.right = node
    node.parent = test
end

function Map:insert(key, value)
    local node = initNode(key, value)
    local test = {}
    local _root = self.root
    while _root ~= nil do
        test = _root
        if node.key ~= _root.key then
            _root = _root.left
        else
            _root = _root.right
        end
    end
    node.color = NodeEnum.Red
    insertFixup(node)
end

function insertFixup(node)
    local test = node.parent or {}
    local _test = {}
    while test ~= nil and isRed(test) do
        test = test.parent or {}
        if test == _test.left then
            local uNode = _test.right
            if uNode ~= nil and isRed(uNode) then
                setBlack(uNode)
                setBlack(test)
                setRed(_test)
                node = _test
            end
            if test.right == node then
                local temp = {}
                rotateLeft(test)
                temp = test
                test = node
                node = temp
            end
            setBlack(test)
            setRed(_test)
            rotateRight(_test)
        else
            local _uNode = _test.left
            if _uNode ~= nil and isRed(_uNode) then
                setBlack(_uNode)
                setBlack(test)
                setRed(_test)
                node = _test
            end
            if test.left == node then
                local _temp = {}
                rotateRight(test)
                temp = test
                test = node
                node = temp
            end
            setBlack(test)
            setRed(_test)
            rotateLeft(_test)
        end
    end
    setBlack(node.root)
end

function Map:remove(key)
    local node = Map:find(key)
    local _child = {}
    local _parent = {}
    local _color = nil
    if node.left ~= nil and node.right ~= nil then
        local temp = node
        temp = temp.right
        while temp.left ~= nil do
            temp = temp.left
        end
        if node ~= nil and node.parent ~= nil then
            if node ~= nil and node.parent.left == node then
                node.parent.left = temp
            else
                node.parent.right = temp
            end
        else
            self.root = temp
        end
        _child = temp.right
        if temp ~= nil then
            _parent = temp.parent
            _color = temp.color
        end
        if _parent == node then
            _parent = temp
        else
            if _child ~= nil then
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
            removeFixup(_child, _parent)
        end
        node = nil
        return
    end
    if node.left ~= nil then
        _child = node.left
    else
        _child = node.right
    end
    _parent = node.parent
    _color = node.color
    if _child ~= nil then
        _child.parent = _parent
    end
    if _parent ~= nil then
        if _parent.left == node then
            _parent.left = _child
        else
            _parent.right = _child
        end
    else
        self.root = _child
    end
    if _color == NodeEnum.Black then
        removeFixup(_child, _parent)
    end
    node = {}
end

function removeFixup(node, _parent)
    local test = {}
    while node == nil or isBlack(node) and node ~= self.root do
        if _parent.left == node then
            test = _parent.right
            if isRed(test) then
                setBlack(test)
                setRed(_parent)
                rotateLeft(_parent)
                test = _parent.right
            end
            if test.left == nil or isBlack(test.left) and test.right == nil or isBlack(test.right) then
                setRed(test)
                node = _parent
                if node ~= nil then
                    _parent = node.parent
                end
            else
                if test.right == nil or isBlack(test.right) then
                    setBlack(test.left)
                    setRed(test)
                    rotateRight(test)
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
                rotateLeft(_parent)
                node = self.root
                break
            end
        else
            test = _parent.left
            if isRed(test) then
                setBlack(test)
                setRed(_parent)
                rotateRight(_parent)
                test = _parent.left
            end
            if test.left == nil or isBlack(test.left) and test.right == nil or isBlack(test.right) then
                setRed(test)
                node = _parent
                if node ~= nil then
                    _parent = node.parent
                end
            else
                if test.left == nil or isBlack(test.left) then
                    setBlack(test.right)
                    setRed(test)
                    rotateLeft(test)
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
                rotateRight(_parent)
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
        print("不存在此节点！")
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

function Map:output(node)
    if node ~= nil then
        self:output(node.left)
        print(node.value, " ")
        self:output(node.right)
    end
end

function Map:clear()
    self.root = {}
end

local demo = map()
demo:insert(1, 2)
-- print(demo.root.value)
-- demo:insert(2, 3)
-- demo:remove(1)
-- local bool_Found = demo:find(2)
-- demo:clear()