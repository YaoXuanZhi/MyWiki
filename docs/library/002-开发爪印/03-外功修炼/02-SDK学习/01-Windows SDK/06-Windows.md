>这里面仅仅是收集一些Windows系统下常用的窗口操作代码片段

##### 设置/取消 控制台窗口置顶
```c++
//设置窗口置顶：HWND_TOPMOST
//取消窗口置顶：HWND_NOTOPMOST
void SetWinLayout(HWND hWndInsertAfter)
{
    HWND hWnd = NULL;
    char strTitle[256] = { 0 };
    GetConsoleTitleA(strTitle, 256);
    hWnd = FindWindowA("ConsoleWindowClass", strTitle);
    SetWindowPos(hWnd, hWndInsertAfter, 0, 0, 0, 0, SWP_NOACTIVATE | SWP_SHOWWINDOW | SWP_NOMOVE | SWP_NOSIZE);
}
```

##### 设置窗口的透明度
```c++
#define MIN_ALPHA_VALUE 40
#define MIN_INACTIVE_ALPHA_VALUE 0
#define MAX_ALPHA_VALUE 255
#define LODWORD(ull) ((DWORD)((ULONGLONG)(ull) & 0x00000000ffffffff))

//默认采用uAlpha值来控制透明度0是全透明 255 是完全不透明
//bColorKey如果为true之后，就会让由clrMaskKey指定的颜色值透明，此时uAlpha失效
void SetTransparent(HWND hAlphaWnd
    , UINT uAlpha/*0..255*/
    , bool bColorKey = false
    , COLORREF clrMaskKey = 0
    , bool bForceLayered = false)
{
    UINT nTransparent = max(MIN_INACTIVE_ALPHA_VALUE,min(uAlpha,255));
	DWORD dwExStyle = GetWindowLongPtr(hAlphaWnd, GWL_EXSTYLE);

    {
        // 设置窗口风格为WS_EX_LAYERED
        if ((dwExStyle & WS_EX_LAYERED) == 0)
        {
            dwExStyle |= WS_EX_LAYERED;
	        SetWindowLong(hAlphaWnd, GWL_EXSTYLE, dwExStyle);
        }

        DWORD nNewFlags = (((nTransparent < 255) || bForceLayered) ? LWA_ALPHA : 0) | (bColorKey ? LWA_COLORKEY : 0);

        BYTE nCurAlpha = 0;
        DWORD nCurFlags = 0;
        COLORREF nCurColorKey = 0;
        BOOL bGet = FALSE;
            bGet = GetLayeredWindowAttributes(hAlphaWnd, &nCurColorKey, &nCurAlpha, &nCurFlags);

        if ((!bGet)
            || (nCurAlpha != nTransparent) || (nCurFlags != nNewFlags)
            || (bColorKey && (nCurColorKey != clrMaskKey)))
        {
            BOOL bSet = SetLayeredWindowAttributes(hAlphaWnd, clrMaskKey, nTransparent, nNewFlags);
        }
        // 让子窗口全部重绘
        //RedrawWindow(hAlphaWnd, NULL, NULL, RDW_ERASE | RDW_INVALIDATE | RDW_FRAME | RDW_ALLCHILDREN);
    }
}
```