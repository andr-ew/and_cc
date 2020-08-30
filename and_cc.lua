-- and

-- util.scandir(_path.audio .. '/loops')

subscript = include 'subscript/lib/subscript'
cc = subscript 'cheat_codes'
lm = include 'ledmap/lib/ledmap'

function init()
    params:add_separator("and_cc")
    
    for i=1,3 do
        params:add{
            type="trigger",
            id='randloop_' .. tostring(i),
            action = function()
                
            end
        }
    end    
 
    lm:map(g, { 0, 4, 0, 4, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 })

    cc.init()    
end

function key(n,z)
    cc.key(n,z)
end

function enc(n,d)
    cc.enc(n,d)
end

function redraw()
    cc.redraw()
end

function cleanup()
    cc.cleanup()

    lm:unmap(g)
end
