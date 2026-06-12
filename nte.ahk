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
    ToolTip "循环点击：已开启"
    SetTimer () => ToolTip(), -1000
    
    ; 开始死循环
    while (isRunning == 1) {
        ; 检查点 1
        if (isRunning == 0)
            break
            
        MouseClick "left", 330, 1700
        
        ; 拆分小等待
        Loop 50 { 
            if (isRunning == 0)
                break
            Sleep 1
        }
        
        ; 检查点 2
        if (isRunning == 0)
            break
            
        MouseClick "left", 3450, 2000
        
        ; 拆分 43.5 秒的等待（45000ms = 450次 * 100ms）
        Loop 435 {
            if (isRunning == 0)
                break
            Sleep 100
        }
        
        ; 检查点 3
        if (isRunning == 0)
            break
            
        MouseClick "left", 85, 85
        Sleep 1000 ; 稍微缓冲一下
        
        ; 检查点 4（新加：在最后一步点击前做检查）
        if (isRunning == 0)
            break
            
        ; 执行最后一步点击
        MouseClick "left", 2300, 1700
        
        ; 一轮循环结束，缓冲 500 毫秒（0.5秒）后进入下一轮
        Sleep 1000
    }
}