
-- LaTeX commands to be handled (matching definitions needed!)
local latexCmds = pandoc.List:new {'alert', 'bsp', 'hinweis', 'origin', 'thema'}

-- LaTeX environments to be handled (matching definitions needed!)
local latexEnvs = pandoc.List:new {'cbox', 'center'}


-- handle selected Spans: embed content into a RawInline with matching LaTeX command
function Span(el)
    local cmd = el.classes[1]

    -- should we handle this command?
    if latexCmds:includes(cmd) then
        return {pandoc.RawInline("latex", "\\" .. cmd .. "{")} .. el.content .. {pandoc.RawInline("latex", "}")}
    end
end


-- handle selected Divs: embed content into a RawBlock with matching LaTeX environment
function Div(el)
    local env = el.classes[1]

    -- should we handle this environment?
    if latexEnvs:includes(env) then
        return {pandoc.RawBlock("latex", "\\begin{" .. env .. "}")} .. el.content .. {pandoc.RawBlock("latex", "\\end{" .. env .. "}")}
    end
end


-- center images without captions too (like "real" images w/ caption)
function Image(el)
    if el.caption and #el.caption == 0 then
        return { pandoc.RawInline('latex', '\\begin{center}'), el, pandoc.RawInline('latex', '\\end{center}') }
    end
end
