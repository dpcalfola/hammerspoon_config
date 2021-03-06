-- Alert message (HelloWorld)
function HelloHammerspoon()
    hs.alert.show('Hello Mammerspoon!!')
end

hs.hotkey.bind({ 'shift', 'cmd' }, 'H', HelloHammerspoon)




-- RELOAD HAMMERSPOON CONFIG : ctrl + opt + cmd + R
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'r', hs.reload)
hs.alert.show("Config loaded")




-- WINDOW HINTS : shift + F1
hs.hotkey.bind({ 'shift' }, 'F1', hs.hints.windowHints)





-- RUN APPLICATIONS

-- 메모장 : ctrl + opt + cmd + N
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'N', function()
    hs.application.launchOrFocus('Notes')
    hs.alert.show("Notes")
end)


-- 크롬 : ctrl + opt + cmd + C
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'C', function()
    hs.application.launchOrFocus('Google Chrome')
    hs.alert.show("Google Chrome")
end)





-- WINDOW CONTROL

-- function : Move window to left
local function move_win_to_left()

    local win = hs.window.focusedWindow() -- 현재 활성화된 앱의 윈도우
    local frame = win:frame() -- 설정할 프레임
    local max_size = win:screen():frame() -- 모니터의 스크린 사이즈

    -- .x .y -> x좌표, y좌표
    -- .w .h -> width, height

    -- 스크린 사이즈(screen)를 읽어와서 새 프레임(frame)에 할당한다
    -- 전체 사이즈에서 width 만 1/2 로 설정
    frame.x = max_size.x
    frame.y = max_size.y
    frame.w = max_size.w / 2
    frame.h = max_size.h

    -- 설정한 값이 저장된 frame 변수를 윈도우에 반영
    win:setFrame(frame)
end

-- function : Move window to right
local function move_win_to_right()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local max_size = win:screen():frame()

    -- 왼쪽 이동 상태에서 스크린 사이즈.width의 절반 만큼 x좌표를 오른쪽으로 이동
    frame.x = max_size.x + (max_size.w / 2)
    frame.y = max_size.y
    frame.w = max_size.w / 2
    frame.h = max_size.h

    win:setFrame(frame)
end

-- function : Move window to top
local function move_win_to_top()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local max_size = win:screen():frame()

    -- 최대 화면 크기에서 height 를 1/2 로 설정
    frame.x = max_size.x
    frame.y = max_size.y
    frame.w = max_size.w
    frame.h = max_size.h / 2

    win:setFrame(frame)
end

-- function : Move window to bottom
local function move_win_to_bottom()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local max_size = win:screen():frame()

    -- top 위치에서 max_size.y 의 1/2 만큼 y좌표를 증가
    frame.x = max_size.x
    frame.y = max_size.y + (max_size.h / 2)
    frame.w = max_size.w
    frame.h = max_size.h / 2

    win:setFrame(frame)
end

-- function : Maximize window
local function maximize_window()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local max_size = win:screen():frame()

    frame.x = max_size.x
    frame.y = max_size.y
    frame.w = max_size.w
    frame.h = max_size.h

    win:setFrame(frame)
end


-- function : Adjust 2/3 height size window
local function two_thirds_height_size_window()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local max_size = win:screen():frame()

    frame.x = max_size.x
    frame.y = max_size.y + (max_size.h / 3)
    frame.w = max_size.w
    frame.h = max_size.h * 2 / 3

    win:setFrame(frame)

end


-- Key bind window control
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'left', function()
    move_win_to_left()
    hs.alert.show("Move window to left", 0.4)
end)
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'right', function()
    move_win_to_right()
    hs.alert.show("Move window to right", 0.4)
end)
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'up', function()
    move_win_to_top()
    hs.alert.show("Move window to top", 0.4)
end)
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'down', function()
    move_win_to_bottom()
    hs.alert.show("Move window to bottom", 0.4)
end)
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'pageup', function()
    maximize_window()
    hs.alert.show("Maximize window", 0.4)
end)
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'home', function()
    two_thirds_height_size_window()
    hs.alert.show("Two_third_sized window", 0.4)
end)
