local array = {1,2,3,4,5}

function array:size()
    local int_num = 0
    for _,v in ipairs(array) do
        int_num = int_num + 1
    end
    return int_num
end

function array:insert(pos, value)
    local num = array.size()
    for i=1,num,1 do
        if(i == pos) then
            for j=num+1,i,-1 do
                array[j] = array[j-1]
            end
        array[i] = value
        end
    end
end

function array:remove(pos)
    local num = array.size()
    for i=1,num,1 do
        if i == pos then
            for j = i,num-1,1 do
                array[j] = array[j+1]
            end
        end
    end
    array[num] = nil
end

function array:clear()
    array = {}
end

-- 从后压
function array:push(value)
    local pos = array.size()
    array[pos+1] = value
end

-- 从后出
function array:pop()
    local pos = array.size()
    local value = array[pos]
    array[pos] = nil
    return value
end

function array:output()
    for _,v in ipairs(array) do
        print(v)
    end
    print("\n")
end

local demo = array
print(demo.size())
demo.insert(self, 1, 6)
demo.output()
demo.remove(5)
demo.output()
demo.push(self, 9)
demo.output()
demo.pop()
demo.output()
demo.clear()