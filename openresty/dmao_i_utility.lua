
local M = {}
setmetatable(M, {__index = _G})
_ENV = M


--[[
Apologies, this is here to swallow Pycharm warnings about 'unused
assigment' in the cases where I'm convinced that the code inspector has
got it wrong. It enables me to see a green tick, which, sadly, I like to
see before I deploy. Hopefully, it's mostly optimised away. It's an
open case for the lua plugin, maybe it will get fixed.
--]]
function M.swallow(v, ...)
    if v then end
end


-- return table sorted by the index
function M.spairs(t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0
    local iter = function()
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end


-- iterate through a lua table to print via print function pf
function M.tprint(tbl, pf, indent)
    if not indent then indent = 0 end
    for k, v in M.spairs(tbl) do
        local formatting = string.rep('  ', indent) .. k .. ': '
        if type(v) == 'table' then
            pf(formatting)
            M.tprint(v, pf, indent + 1)
        elseif type(v) == 'boolean' then
            pf(formatting .. tostring(v))
        else
            pf(formatting .. v)
        end
    end
end

return M