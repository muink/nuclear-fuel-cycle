mathbit = {}

local math_floor = math.floor
local math_modf = math.modf

function mathbit.__andBit(left,right)
    return (left == 1 and right == 1) and 1 or 0
end
 
function mathbit.__orBit(left, right)
    return (left == 1 or right == 1) and 1 or 0
end
 
function mathbit.__xorBit(left, right)
    return (left + right) == 1 and 1 or 0
end
 
function mathbit.__base(left, right, op)
    if left < right then
        left, right = right, left
    end
    local res = 0
    local shift = 1
    while left ~= 0 do
        local ra = left % 2
        local rb = right % 2   
        res = shift * op(ra,rb) + res
        shift = shift * 2
        left = math_modf( left / 2)
        right = math_modf( right / 2)
    end
    return res
end
 
function mathbit.andOp(left, right)
    return mathbit.__base(left, right, mathbit.__andBit)
end
 
function mathbit.xorOp(left, right)
    return mathbit.__base(left, right, mathbit.__xorBit)
end
 
function mathbit.orOp(left, right)
    return mathbit.__base(left, right, mathbit.__orBit)
end
 
function mathbit.notOp(left)
    return left > 0 and -(left + 1) or -left - 1
end
 
function mathbit.lShiftOp(left, num)
    return left * (2 ^ num)
end
 
function mathbit.rShiftOp(left,num)
    return math_floor(left / (2 ^ num))
end
