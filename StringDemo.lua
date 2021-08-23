local String = require("String")

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