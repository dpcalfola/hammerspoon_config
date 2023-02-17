# Fola's Hammerspoon config code

<br>
<br>
<br>

## < Document list >

1. About version
2. Shortcuts list
3. How to use Hammerspoon and Import Fola's config

<br>
<br>
<br>

## < Version: v0.206a>

+ last update
    - Code: 2023-02-17
    - Manual(README): 2023-02-17

<br>
<br>


## < Shortcuts list >

### Hammerspoon control

* ctrl + opt + shift + {key}
    * Reload Hammerspoon config: ctrl + opt + shift + R
    * Open Hammerspoon console: ctrl + opt + shift + C
    * Print message on console for tasting: ctrl + opt + shift + T

<br>

### System control

* ctrl + opt + cmd + shift + {key}
    * Lock screen and Enter sleep mode:
        * Lock screen: ctrl + opt + cmd + shift + L
            * Sleep mode: If there is no input for 5 seconds after the screen is locked, enter sleep mode

<br>

### Useful shortcuts

* Window hint:
    * shortcut:
        * ctrl + opt + cmd + /
    * Note:
        - This feature helps that focusing on the window minimized or hided or not in the front.
        - When you press the shortcut, every window's hints as 'hint key' will be shown.
        - If you press the hint key of the window, the window will be focused and located in the front.


* Input source changer:
    * Toggle input source:
      * ctrl + space
    * Select language directly 1:
      * ctrl + opt + cmd + K (Korean)
      * ctrl + opt + cmd + J (English)
    * Select language directly 2 (comfortable)
      * ctrl + shift + K (Korean)
      * ctrl + shift + J (English)
>* Note - It is so comfortable to use this way:
>   * Left ctrl -> Left pinky finger
>   * Right shift -> Right pinky finger
>   * K or J (Korean or English) -> Right index finger


* Locate mouse cursor to other monitors:
    * shortcuts:
        * Move mouse cursor to left monitor: ctrl + opt + cmd + -
        * Move mouse cursor to right monitor: ctrl + opt + cmd + =
    * Note:
        - This feature helps change Mission Control space in the multiple monitor situation by locating the mouse cursor
          to other monitors without using the mouse.
        - Changing a space to left or right(ctrl + left/right) works at the monitor where the mouse cursor is located.
        - Using this shortcut, locate the cursor to the monitor you want to change the space, and then use ctrl +
          left/right to change the space.

<br>

### Run applications

* System Preferences: ctrl + opt + cmd + S
* Note: ctrl + opt + cmd + N
* Google chrome: ctrl + opt + cmd + C

 <br>

### Window Control

* Half screen control
    * Move to left half: ctrl + opt + cmd + left
    * Move to right half: ctrl + opt + cmd + right
    * Move to top half: ctrl + opt + cmd + up
    * Move to bottom half: ctrl + opt + cmd + down

* Quadrant screen control
    * Move to left top: ctrl + opt + cmd + O
    * Move to right top: ctrl + opt + cmd + P
    * Move to left bottom: ctrl + opt + cmd + L
    * Move to right bottom: ctrl + opt + cmd + ;

* etc
    * Move to Bottom 2/3 screen: ctrl + opt + cmd + home
    * Maximize window (both shortcuts work):
        * ctrl + opt + cmd + pageup
        * ctrl + opt + cmd + 0

* Move the focused window between monitors
    * Move to left monitor: ctrl + opt + cmd + [
    * Move to right monitor: ctrl + opt + cmd + ]

<br>

### Time checker
* Show the current time on the screen: ctrl + opt + cmd + T


<br>




<br>
<br>

## < 해머스푼 사용 방법 >

### Hammerspoon 설치

1. 설치
    - Homebrew 에서 쉽게 설치 가능합니다
        - 링크: [homebrew - hammerspoon](https://formulae.brew.sh/cask/hammerspoon#default)
    - Hammerspoon 공식 페이지에서도 설치 가능합니다
        - 링크: https://www.hammerspoon.org/
    - 공식 페이지보다는 homebrew를 통해 설치하는것을 추천합니다. (homebrew를 사용해보신적이 없다면 이 기회에 사용해 보세요)

2. Hammerspoon 의 MacOS 접근 권한 설정
    1. Hammerspoon menu(화면 우상단 메뉴바의 망치 아이콘 클릭)
    2. Preferences... 클릭
    3. Enable Accessibility 클릭
    4. System setting > Privacy & Security > Accessibility 창이 열립니다 (직접 찾아 들어가셔도 됩니다)
    5. 버튼을 누르고 나타난 Finder 창에서 우상단 Search 입력창에 Hammerspoon 앱을 찾아 열기
    6. 접근 권한이 설정 되었는지 확인 (토글이 우측에 있는지 확인)

### config 적용하기

* 방법1: 설정파일 교체
    1. 레파지토리의 init.lua 파일을 다운로드 합니다
    2. 설정파일 경로: /Users/{Device_Name}/.hammerspoon/init.lua
        - .hammersppoon 폴더는 숨김파일입니다. 파인더에서 숨김 파일을 보려면 "(left)shift + (left)cmd + ." 을 누르세요
    3. 설치된 경로의 init.lua 파일을 다운받은 init.lua로 교체합니다
    4. Hammerspoon menu 에서 Reload Config 를 클릭하여 설정 파일을 읽고 적용합니다
    5. 단축키가 실행 되는지 확인합니다


* 방법2: config code 편집
    1. Hammerspoon menu 에서 Open Config 클릭합니다
        * VSCode 같은 외부 에디터를 통해 설정파일인 init.lua 파일이 열립니다
        * 해머스푼을 처음 설치했다면 설정파일(init.lua)에는 아무 코드도 없이 비어있습니다
    2. 레파지토리의 init.lua 코드 전부 혹은 필요한 일부를 복사하여 에디터를 이용하여 붙여 넣고 변경사항을 저장합니다
    3. Hammerspoon menu 에서 Reload Config 를 클릭하여 설정 파일을 읽고 적용합니다
    4. 단축키가 실행 되는지 확인합니다

<br>

<hr/>
<br>