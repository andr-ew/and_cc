-- and 

subscript = include 'subscript/lib/subscript'
cc = subscript 'cheat_codes'
lm = include 'ledmap/lib/ledmap'


function aa.init(n,d)

  local this_bank = bank[arc_control[n]]
  if n ~= 4 then
    if this_bank.focus_hold == false then
      which_pad = this_bank.id
    else
      which_pad = this_bank.focus_pad
    end
    local this_pad = this_bank[which_pad]
    local p_action = aa.actions[arc_param[n]][1]
    local sc_action = aa.actions[arc_param[n]][2]
    if not this_bank.alt_lock and grid.alt == 0 then
      if arc_param[n] ~= 4 then
        p_action(this_pad,d)
      else
        p_action(this_pad,d/1000, n)
      end
    elseif this_bank.alt_lock or grid.alt == 1 then
      if arc_param[n] ~= 4 then
        aa.map(p_action,this_bank,d)
      else
        aa.map(p_action, this_bank, d/1000, n)
      end
    end
    if this_bank.focus_hold == false or this_bank.focus_pad == this_bank.id then
      sc_action(n, this_pad)
    end
    if n < 4 then
      aa.record(n)
    end
  else
    -- local side = (arc.alt == nil or arc.alt == 0) and "L" or "R"
    -- aa.delay_rate(d,side)
    -- aa.record_delay(side)
    aa.change_param_focus(d)
  end
  redraw()
end

function init()
    params:add_separator("and_cc")
    
    local dir = _path.audio .. '/loops/'
    local loops = util.scandir(dir)
    for i=1,3 do
        params:add{
            type="trigger",
            id='rand_' .. tostring(i),
            action = function()
                print(dir .. loops[math.random(1, #loops)])
                params:set('clip '..i..' sample', dir .. loops[math.random(1, #loops)])
            end
        }
    end

    params:add{
        type="trigger",
        id="rand_all",
        action = function()
            for i=1,3 do params:set("rand_" .. tostring(i)) end
        end
    }

    params:add{
        type="trigger",
        id="reset",
        action = function() 
            params:set("collection", 1)
            params:set("load")
        end
    }

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

--    lm:unmap(g)
end
