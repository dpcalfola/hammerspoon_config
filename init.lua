-- ABOUT HAMMERSPOON
-- ctrl + option + shift + {key}

-- Reload Hammerspoon Config : ctrl + opt + shift + R
hs.hotkey.bind({ 'ctrl', 'option', 'shift' }, 'R', hs.reload)
hs.alert.show("Config loaded")

-- Open Hammerspoon console : ctrl + opt + shift + C
hs.hotkey.bind({ 'ctrl', 'option', 'shift' }, 'c', function()
    hs.toggleConsole()
    hs.alert.show("Hammerspoon console")
end)
-- Print message on console for tasting : ctrl + opt + shift + T
hs.hotkey.bind({ 'ctrl', 'option', 'shift' }, 't', function()
    print("Test message")
end)




-- Lock screen and sleep : ctrl + opt + cmd + shift + L
-- After 5 seconds of lockScreen, the system enters sleep mode
hs.hotkey.bind({ 'ctrl', 'option', 'cmd', 'shift' }, 'L', function()
    hs.caffeinate.lockScreen()
end)




-- WINDOW HINTS : 'ctrl', 'option', 'cmd' + / (slash)
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, '/', hs.hints.windowHints)



-- INPUT LANGUAGE SOURCE CHANGER

-- INPUT SOURCE CHANGER
do
    local inputSource = {
        english = "com.apple.keylayout.ABC",
        korean = "com.apple.inputmethod.Korean.2SetKorean"
    }

    -- Toggle input source
    local changeInput = function()
        local current = hs.keycodes.currentSourceID()
        local nextInput = nil

        if current == inputSource.english then
            nextInput = inputSource.korean
            hs.alert.show("한국어")
        else
            nextInput = inputSource.english
            hs.alert.show("English")
        end
        hs.keycodes.currentSourceID(nextInput)
    end
    hs.hotkey.bind({ 'ctrl' }, 'space', changeInput)

    -- Select input source directly
    -- Korean : ctrl + option + cmd + K
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'K', function()
        hs.keycodes.currentSourceID(inputSource.korean)
        hs.alert.show("한국어", 0.4)
    end)
    -- English : ctrl + option + cmd + J
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'J', function()
        hs.keycodes.currentSourceID(inputSource.english)
        hs.alert.show("English", 0.4)
    end)
end
-- INPUT SOURCE CHANGER ENDED




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


-- WINDOW CONTROL STARTS FROM HERE

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
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, '0', function()
    maximize_window()
    hs.alert.show("Maximize window", 0.4)
end)
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'home', function()
    two_thirds_height_size_window()
    hs.alert.show("Two_third_sized window", 0.4)
end)


-- Adjust 1/4 height and width and move to each quadrant

-- Move to left top: ctrl + option + cmd + O
local function move_to_left_top()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local max_size = win:screen():frame()

    frame.x = max_size.x
    frame.y = max_size.y
    frame.w = max_size.w / 2
    frame.h = max_size.h / 2
    win:setFrame(frame)
end
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'O', function()
    move_to_left_top()
    hs.alert.show("Move to left top", 0.4)
end)

-- Move to right top: ctrl + option + cmd + P
local function move_to_right_top()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local max_size = win:screen():frame()

    frame.x = max_size.x + (max_size.w / 2)
    frame.y = max_size.y
    frame.w = max_size.w / 2
    frame.h = max_size.h / 2
    win:setFrame(frame)
end
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'P', function()
    move_to_right_top()
    hs.alert.show("Move to right top", 0.4)
end)

-- Move to left bottom: ctrl + option + cmd + L
local function move_to_left_bottom()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local max_size = win:screen():frame()

    frame.x = max_size.x
    frame.y = max_size.y + (max_size.h / 2)
    frame.w = max_size.w / 2
    frame.h = max_size.h / 2
    win:setFrame(frame)
end
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'L', function()
    move_to_left_bottom()
    hs.alert.show("Move to left bottom", 0.4)
end)

-- Move to right bottom: ctrl + option + cmd + ;
local function move_to_right_bottom()
    local win = hs.window.focusedWindow()
    local frame = win:frame()
    local max_size = win:screen():frame()

    frame.x = max_size.x + (max_size.w / 2)
    frame.y = max_size.y + (max_size.h / 2)
    frame.w = max_size.w / 2
    frame.h = max_size.h / 2
    win:setFrame(frame)
end
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, ';', function()
    move_to_right_bottom()
    hs.alert.show("Move to right bottom", 0.4)
end)


-- WINDOW CONTROL ENDED