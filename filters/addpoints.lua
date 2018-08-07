-- Author: Carsten Gips <carsten.gips@fh-bielefeld.de>
-- Copyright: (c) 2018 Carsten Gips
-- License: MIT


-- count of all points
points = 0


-- add points of headers with attributes `{punkte=42}`
function addPoints(el)
    points = points + (tonumber(el.attributes["punkte"]) or 0)
end


-- check `points` field in global metadata
function checkPoints(meta)
    if meta.points or points > 0 then
        -- meta.points is either nil, MetaString or MetaInlines
        local mpts = (type(meta.points) == "table" and pandoc.utils.stringify(meta.points)) or meta.points or "NO"
        if tonumber(mpts) ~= points then
            -- check expectation and real value
            io.stderr:write("\n\n" .. "Expected " .. mpts .. " points.\n")
            io.stderr:write("Found " .. points .. " points!" .. '\n\n\n')
        end
    end
end


return { { Header = addPoints }, { Meta = checkPoints } }

