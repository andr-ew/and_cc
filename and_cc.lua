subscript = include 'subscript/lib/subscript'
cc = subscript 'cheat_codes'
lm = include 'ledmap/lib/ledmap'

function init()
    params:add_separator("and_cc")
        

    lm:map(g, '2011')

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
