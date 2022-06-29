-- Alert message (HelloWorld)
-- function HelloHammerspoon() 
--     hs.alert.show('Hello Mammerspoon!!') 
-- end
-- hs.hotkey.bind(
--     {'shift', 'cmd'}, 'H', HelloHammerspoon)

-- Reload Hammerspoon Config
hs.hotkey.bind({'option', 'cmd'}, 'r', hs.reload)
hs.alert.show("Config loaded")


-- WindowHints
hs.hotkey.bind({'shift'}, 'F1', hs.hints.windowHints)
