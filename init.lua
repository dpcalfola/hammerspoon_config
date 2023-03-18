-- << ABOUT HAMMERSPOON >>
-- Be supposed to ctrl + option + shift + {key}

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

-- << ABOUT HAMMERSPOON ENDED >>




-- << CONTROL MacOS >>
-- Lock screen and sleep : ctrl + opt + cmd + shift + L
-- After 5 seconds of lockScreen, the system enters sleep mode
hs.hotkey.bind({ 'ctrl', 'option', 'cmd', 'shift' }, 'L', function()
    hs.caffeinate.lockScreen()
end)
-- << CONTROL MacOS ENDED >>





-- << WORKSPACE CONTROL >>
--[[
🌟 SHOW WINDOW HINTS FOR FOCUSING WINDOW BY KEYBOARD 🌟
    * Shortcut:
        ctrl + option + cmd + /(slash)

    * Usage:
        1. Press the shortcut
        2. Then press the key of the window you want to focus
]]--
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, '/', hs.hints.windowHints)


--[[
🌟 LOCATE MOUSE CURSOR TO OTHER MONITORS 🌟

    * Shortcuts:
        Locate mouse cursor
            to the left monitor: ctrl + opt + cmd + -
            to the right monitor: ctrl + opt + cmd + +


    * Why is this feature useful?
        1.
        This feature helps change Mission Control spaces,
        regardless of which extended monitor
        it is

        If a user Press 'cmd + left(or right)'
        there are changes a space on the monitor
        that MOUSE CURSOR located

        2.
        Before trying to Mission Control,
        using this feature,
        move the mouse cursor to monitor
        which the user wants to change space.

        Then the user can do it
        without moving a hand to the mouse


    * PS. Mission Control shortcut (MacOS Default):
        Enter Mission Control: ctrl + up
        Move left a space: ctrl + left
        Move right a space: ctrl + right
        Application windows: ctrl + down
]]--

-- Start code: Locate mouse cursor to other monitors
do
    -- function: Locate mouse cursor to the left or right monitor
    function locateMouseToMonitor(direction)
        local currentScreen = hs.mouse.getCurrentScreen()
        local nextScreen = nil

        if direction == 'right' then
            nextScreen = currentScreen:toEast()
        elseif direction == 'left' then
            nextScreen = currentScreen:toWest()
        end

        local nextScreenFrame = nextScreen:fullFrame()
        local currentMousePoint = hs.mouse.getAbsolutePosition()

        local nextMousePoint = hs.geometry.point(
                nextScreenFrame.x + currentMousePoint.x - currentScreen:fullFrame().x,
                nextScreenFrame.y + currentMousePoint.y - currentScreen:fullFrame().y
        )
        hs.mouse.setAbsolutePosition(nextMousePoint)
    end

    -- Locate mouse cursor to the left monitor: ctrl + opt + cmd + -
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, '-', function()
        locateMouseToMonitor('left')
    end)
    -- Locate mouse cursor to the right monitor: ctrl + opt + cmd + =
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, '=', function()
        locateMouseToMonitor('right')
    end)
end

-- << WORKSPACE CONTROL ENDED >>



-- << INPUT LANGUAGE SOURCE CHANGER >>

-- 🌟 INPUT SOURCE CHANGER 🌟
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

    -- Select input source directly (1)
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


    --[[
        * More comfortable way to select input source directly
            Left ctrl -> Left pinky finger
            Right shift -> Right pinky finger
            K or J (Korean or English) -> Right index finger
    ]]--
    -- Select input source directly (2)
    -- Korean : ctrl + shift + K
    hs.hotkey.bind({ 'ctrl', 'shift' }, 'K', function()
        hs.keycodes.currentSourceID(inputSource.korean)
        hs.alert.show("한국어", 0.4)
    end)
    -- English : ctrl + shift + J
    hs.hotkey.bind({ 'ctrl', 'shift' }, 'J', function()
        hs.keycodes.currentSourceID(inputSource.english)
        hs.alert.show("English", 0.4)
    end)
end
-- << INPUT LANGUAGE SOURCE CHANGER ENDED >>




-- << RUN APPLICATIONS >>
-- Notes(메모장): ctrl + opt + cmd + N
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'N', function()
    hs.application.launchOrFocus('Notes')
    hs.alert.show("Notes")
end)
-- GoogleChrome(구글 크롬): ctrl + opt + cmd + C
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'C', function()
    hs.application.launchOrFocus('Google Chrome')
    hs.alert.show("Google Chrome")
end)
-- System Setting: ctrl + opt + cmd + S
hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'S', function()
    hs.application.launchOrFocus('System Preferences')
    hs.alert.show("System Preferences")
end)
-- << RUN APPLICATIONS ENDED>>






-- << WINDOW CONTROL (CHANGE SIZE AND MOVE) >>
do
    -- 🌟HALF SCREEN CONTROL🌟

    -- Move window to left: ctrl + option + cmd + left
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
    -- Bind Move_window_to_left function to shortcut
    -- ctrl + opt + cmd + left
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'left', function()
        move_win_to_left()
        hs.alert.show("Move window to left", 0.4)
    end)

    -- Move window to right: ctrl + option + cmd + right
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
    -- Bind
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'right', function()
        move_win_to_right()
        hs.alert.show("Move window to right", 0.4)
    end)


    -- Move window to top: ctrl + option + cmd + up
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
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'up', function()
        move_win_to_top()
        hs.alert.show("Move window to top", 0.4)
    end)

    -- Move window to bottom: ctrl + option + cmd + down
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
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'down', function()
        move_win_to_bottom()
        hs.alert.show("Move window to bottom", 0.4)
    end)





    -- 🌟 QUADRANT SCREEN CONTROL 🌟
    -- Adjust 1/4 height and width
    -- then move to each quadrant

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



    -- 🌟 ETC SCREEN SIZE CONTROL 🌟

    -- Maximize window:
    -- ctrl + option + cmd + 0
    -- or ctrl + option + cmd + pageup
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
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'pageup', function()
        maximize_window()
        hs.alert.show("Maximize window", 0.4)
    end)
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, '0', function()
        maximize_window()
        hs.alert.show("Maximize window", 0.4)
    end)

    -- Adjust 2/3 height size window: ctrl + option + cmd + home
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
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'home', function()
        two_thirds_height_size_window()
        hs.alert.show("Two_third_sized window", 0.4)
    end)


    -- 🌟 MOVE WINDOW BETWEEN MONITORS 🌟
    -- Function: Window move to left or right monitor
    local function move_window_to_left_or_right_monitor(direction)
        local win = hs.window.focusedWindow()
        local screen = win:screen()
        local next_screen = screen:toEast()
        if direction == 'left' then
            next_screen = screen:toWest()
        end
        win:moveToScreen(next_screen)
    end
    -- Move window to left monitor: ctrl + option + cmd + [
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, '[', function()
        move_window_to_left_or_right_monitor('left')
        hs.alert.show("Move to left monitor", 1)
    end)
    -- Move window to right monitor: ctrl + option + cmd + ]
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, ']', function()
        move_window_to_left_or_right_monitor('right')
        hs.alert.show("Move to right monitor", 1)
    end)
end
-- << WINDOW CONTROL (CHANGE SIZE AND MOVE) ENDED >>



-- << TIME CHECKER START >> --
do
    local function showCurrentTime()
        local current_time_message = "Current time - " .. os.date("%X")

        hs.alert.show(current_time_message, 4)
        hs.sound.getByName("Funk"):play()

        -- print message on Hammerspoon console to check up this function
        print(current_time_message)
    end

    -- Shortcut : ctrl + option + cmd + T
    -- Execute time_checker function with shortcut
    hs.hotkey.bind({ 'ctrl', 'option', 'cmd' }, 'T', function()
        showCurrentTime()
    end)
end
-- << TIME CHECKER END >> --





-- << CHROME MEDIA CONTROL START >> --
do
    -- Function to focus Chrome
    function focusChrome()
        --[[
            How to get the bundle ID of chrome app for hs.application.get() parameter?
                In terminal, run the following command:
                    osascript -e 'id of app "Google Chrome"'
                My result is: com.google.Chrome
        ]]--
        local chrome = hs.application.get("com.google.Chrome")
        if chrome == nil then
            return false
        end

        chrome:activate()
        return true
    end

    -- Variable to store the bundle ID of the previously focused application
    local previousAppID = nil

    -- Function to focus the previously focused application
    function focusPrevious()
        if previousAppID == nil then
            -- No previous app to focus
            return
        end
        -- Launch or focus the previous app by its bundle ID
        hs.application.launchOrFocusByBundleID(previousAppID)
    end

    -- Function to update the previous application variable
    function updatePrevious()
        local lastApp = hs.application.frontmostApplication()
        if lastApp ~= nil then
            previousAppID = lastApp:bundleID()
        end
    end

    -- Bind updatePrevious to Hammerspoon's application watcher
    hs.application.watcher.new(updatePrevious):start()


    -- Function to simulate key press
    function simulateKeyPress(keys)
        hs.eventtap.keyStroke({}, table.unpack({keys}))
    end

    -- Function to control Chrome by simulating key press
    function controlChrome(keys)
        -- Focus Chrome
        focusChrome()
        -- Simulate key press to control
        simulateKeyPress(keys)
        -- Focus the previously focused application
        focusPrevious()
    end


    -- Keybindings for functions
    -- Play/Pause
    hs.hotkey.bind({ 'ctrl', 'option' }, 'J', function()
        controlChrome("space")
    end)
    hs.hotkey.bind({ 'ctrl', 'option' }, 'K', function()
        controlChrome("space")
    end)
    -- Backward
    hs.hotkey.bind({ 'ctrl', 'option' }, 'H', function()
        controlChrome("left")
    end)
    -- Forward
    hs.hotkey.bind({ 'ctrl', 'option' }, 'L', function()
        controlChrome("right")
    end)
end
-- << CHROME MEDIA CONTROL END >> --