#Requires AutoHotkey v2.0
#SingleInstance Force

; 允许同一个热键同时运行多达 2 个线程，实现按 F3 随时中断循环
#MaxThreadsPerHotkey 2

; 1. 强行以管理员权限运行
if not A_IsAdmin {
    Run '*RunAs "' A_ScriptFullPath '"'
    ExitApp
}

; 2. 设置鼠标坐标基于整个屏幕
CoordMode "Mouse", "Screen"

; 3. 全局开关：0 代表停止，1 代表运行
global isRunning := 0

F3:: {
    global isRunning
    
    ; 如果当前正在运行，按 F3 将其设为 0 以中止循环
    if (isRunning == 1) {
        isRunning := 0
        ToolTip "循环点击：已关闭"
        SetTimer () => ToolTip(), -1000
        return 
    }
    
    ; 如果当前没运行，按 F3 开启循环
    isRunning := 1
    ToolTip "循环点击：已开启 (1080P/1K分辨率)"
    SetTimer () => ToolTip(), -1000
    
    ; 开始死循环
    while (isRunning == 1) {
        ; 检查点 1
        if (isRunning == 0)
            break
            
        ; [1K] 原 330, 1700
        MouseClick "left", 165, 850
        
        ; 拆分小等待
        Loop 50 { 
            if (isRunning == 0)
                break
            Sleep 1
        }
        
        ; 检查点 2
        if (isRunning == 0)
            break
            
        ; [1K] 原 3450, 2000
        MouseClick "left", 1725, 1000
        
        ; 拆分 43.5 秒的等待
        Loop 435 {
            if (isRunning == 0)
                break
            Sleep 100
        }
        
        ; 检查点 3
        if (isRunning == 0)
            break
            
        ; [1K] 原 85, 85
        MouseClick "left", 43, 43
        Sleep 1000 
        
        ; 检查点 4
        if (isRunning == 0)
            break
            
        ; [1K] 原 2300, 1700
        MouseClick "left", 1150, 850
        
        Sleep 1000
    }
}