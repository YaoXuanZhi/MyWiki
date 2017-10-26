>这里面仅仅是收集一些Windows系统下常用的窗口操作代码片段

##### 设置/取消 控制台窗口置顶
```c++
设置窗口置顶：HWND_TOPMOST
取消窗口置顶：HWND_NOTOPMOST
void SetWinLayout(HWND hWndInsertAfter)
{
    HWND hWnd = NULL;
    char strTitle[256] = { 0 };
    GetConsoleTitleA(strTitle, 256);
    hWnd = FindWindowA("ConsoleWindowClass", strTitle);
    SetWindowPos(hWnd, hWndInsertAfter, 0, 0, 0, 0, SWP_NOACTIVATE | SWP_SHOWWINDOW | SWP_NOMOVE | SWP_NOSIZE);
}
```