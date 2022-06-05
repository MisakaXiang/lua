local m = require("module")
-- m.func1()
m.func2()

local printf = function(str, ...)
    return print(string.format(str, ...))
end

-- 声明  classA
local ClassA = m:class("ClassA")
ClassA.static = 'Static A'
function ClassA:ctor(a, b)
    self.a = a or 0
    self.b = b or 0
end

function ClassA:print()
    printf("%s, a = %s, b = %d, static = %s", self.__cname, self.a, self.b, self.static)
end

function ClassA:getSum()
    return self.a + self.b
end

-- 声明  classB， 并且继承 ClassA
local ClassB = m:class("ClassB", ClassA)
function ClassB:ctor(...)
    self.super.ctor(self, ...)
end

-- overwrite
function ClassB:print()
    print('ClassB overwrite super print')
end

-- 声明 classC, 并且继承 ClassB
local ClassC = m:class("ClassC", ClassA)
ClassC.static = 'Static C'

local obja1 = ClassA.new(10, 20)
local obja2 = ClassA.new(100, 200)
local objb1 = ClassB.new(1, 2)
local objc = ClassC.new(3, 4)
obja1:print()
obja2:print()
objb1:print()
objc:print()
printf("3 + 4 = %s", objc:getSum())
--[[
ClassA, a = 10, b = 20, static = Static A
ClassA, a = 100, b = 200, static = Static A
Class B overwrite super print
ClassC, a = 3, b = 4, static = Static C
3 + 4 = 7
]]