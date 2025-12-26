#Requires AutoHotkey v2
#warn all, off
#singleinstance force
#include %A_scriptdir%\libraries\Gdip_All.ahk
setkeydelay -1
setmousedelay -1
SetTitleMatchMode 2
CoordMode("Tooltip", "Screen")
CoordMode("Pixel", "Screen")
CoordMode("Mouse", "Screen")
SendMode("Event")
OnMessage("0x201", WM_LBUTTONDOWN)
WM_LBUTTONDOWN(wParam, lParam, msg, hwnd)
{
PostMessage "0xA1", 2
}
ttp(text := "", XPos := "", YPos := "", ToolPos := "1") {
	if !(XPos and YPos) {
		mousegetpos &XPos, &YPos
	}
	tooltip text, XPos, YPos, ToolPos
	hwndList := WinGetList("ahk_class tooltips_class32")
	for hwnd in hwndList {
		DllCall("SetWindowLongPtr", "Ptr", hwnd, "Int", -20, "Ptr", DllCall("GetWindowLongPtr", "Ptr", hwnd, "Int", -20, "Ptr") | 0x80000 | 0x20) ; <-- To make it not touchable
	}
}

if !DirExist(A_ScriptDir "\requiredfileformacro\") {
	DirCreate A_ScriptDir "\requiredfileformacro\"
}
if !DirExist(A_ScriptDir "\requiredfileformacro\orething") {
	DirCreate A_ScriptDir "\requiredfileformacro\orething"
}

runtime := A_TickCount
PreviousMS := A_TickCount
launchedat := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")

global discordwebhook, tesseractocrlocation, selectedorekeep
if !fileexist(A_ScriptDir "\requiredfileformacro\SettingsForAutoMineForge.txt") {
fileappend
(
"discordwebhook=
tesseractocrlocation=C:\Program Files\Tesseract-OCR\tesseract.exe
selectedorekeep=30"
), A_ScriptDir "\requiredfileformacro\SettingsForAutoMineForge.txt"
}
readsettings(A_ScriptDir "\requiredfileformacro\SettingsForAutoMineForge.txt")
; msgbox tesseractocrlocation "`n" selectedorekeep "`n" discordwebhook

	credit2 := Gui("+E0x00080020 +alwaysontop -maximizebox +border -caption +ToolWindow")
	credit2.backcolor := 0xffffff
	credit2.setfont("c0x000000 s15 q2 w800", "tahoma")
	credit2.add("text", "y0 x22", "Macro by Lolzzn")
	credit2.show("NA y4 h25")
	WinSetTransColor "0xffffff 255", "ahk_id " credit2.hwnd
	credit := Gui("+E0x00080020 +alwaysontop -maximizebox +border -caption +ToolWindow")
	credit.backcolor := 0x000000
	credit.setfont("cwhite s15 q2 w800", "tahoma")
	credit.add("text", "y0", "Macro by Lolzzn")
	credit.show("NA y5 h25")
	WinSetTransColor "0x000000 255", "ahk_id " credit.hwnd
	

if !(fileexist(tesseractocrlocation)) {
	what := msgbox("No Tesseract OCR detected, download it?`n`nor you maybe didn't input the right folder on the settings`n`nif you press No, the macro will exit`nif Yes then your going to go to the official github download link", "error", "0x40004")
	if (what == "Yes") {
		run "https://github.com/UB-Mannheim/tesseract/wiki"
	}else{
		exitapp
	}
}
try {
readsettings(A_ScriptDir "\requiredfileformacro\coordsave.txt")
}catch{
makecordsettings()
readsettings(A_ScriptDir "\requiredfileformacro\coordsave.txt")
}

; makegui()

return

makegui() {
global
thegui := Gui("+AlwaysOnTop +SysMenu")
thegui.backcolor := "0x3b3b3b"
thegui.setfont("s25 cwhite norm w800", "Tahoma")
title := thegui.add("text", "y5", "The Forge Macro")
; fuck it no gui - lolzzn 13/12/2025 -12:20 GMT + 7
makeitallalign(title, 500)
thegui.show("w500 h300")
}

makeitallalign(GUINAME?, thewidthofgui?, start := 0) {
global
	try {
		GUINAME.getpos( ,, &tempyheay)
		GUINAME.move(floor(thewidthofgui/2-tempyheay/2)+start)
	}
}

readsettings(whatfile) {
global
	yeah := fileread(whatfile)
	for i, v in strsplit(yeah, "`n") {
		if (trim(v) != "") {
			try {
				IHATEARRAYS := strsplit(v, "=")
				arr1 := trim(IHATEARRAYS[1])
				arr2 := trim(IHATEARRAYS[2])
				%arr1% := arr2
			}
		}
	}
}

/*
$q::
{
global
MouseGetPos &xxxxxxxxxx, &yyyyyyyyyyyyyyyyyyy
ttp PixelGetColor(xxxxxxxxxx, yyyyyyyyyyyyyyyyyyy), 400, 400, 19
ttp "Coordinate: x: " xxxxxxxxxx " y: " yyyyyyyyyyyyyyyyyyy, 400, 425, 20
clickedhowmuch := 0
loop {
TheOreAmount := trim(strreplace(tesseractOCR(921, 479, 1001, 525, "--psm 7 --oem 1 -l eng --dpi 300", 0xC7BFAE, 60), "`n", ""))
	if !(isnumber(TheOreAmount)) {
		click 905 " " 505
		sleep 50
		clickedhowmuch++
	}else{
		break
	}
}
sleep 20
if (clickedhowmuch) {
click 1128 " " 500
}
sleep 50
ttp theoreamount+clickedhowmuch, 400, 450, 18
}
*/

/*
f3::{
global
w := 100*(A_ScreenWidth/1920)
h := 200*(A_ScreenHeight/1080)
resizeablebar( ,,, (abs(w)), (abs(h)))
orename := inputbox("ore name", "stop reading this go focus on the box")
mousegetpos &tempx, &tempy
loop 20 {
mousemove 0, 0
sleep 50
}
mousemove tempx, tempy
snap(left, top, right, bottom, A_ScriptDir "\requiredfileformacro\orething\" orename.value ".png")
msgbox "saved to " A_ScriptDir "\requiredfileformacro\orething\" orename.value ".png!", "notif", "0x40000 T1"
}
*/

]::{
global
Highlight(theredtextx1, theredtexty1, theredtextx2-theredtextx1, theredtexty2-theredtexty1, 1, "0xff0000") ; red text detection
Highlight(quantityocrx1, quantityocry1, quantityocrx2-quantityocrx1, quantityocry2-quantityocry1, 2, "0xffffff") ; quantity v
highlight(cashgainocrx1, cashgainocry1, cashgainocrx2-cashgainocrx1, cashgainocry2-cashgainocry1, 3, 0xffe5a4) ; cash gain v
highlight(yesnoocrx1, yesnoocry1, yesnoocrx2-yesnoocrx1, yesnoocry2-yesnoocry1, 4, 0x88ff00) ; yes/no v
highlight(theselectforocrx1, theselectforocry1, theselectforocrx2-theselectforocrx1, theselectforocry2-theselectforocry1, 5, 0xffb700) ; select/unselect all v
highlight(xpbarforocrx1, xpbarforocry1, xpbarforocrx2-xpbarforocrx1, xpbarforocry2-xpbarforocry1, 6, 0xffffff) ; xp progress v
highlight(totalcashx1, totalcashy1, totalcashx2-totalcashx1, totalcashy2-totalcashy1, 7, 0xffe5a4) ; total cash v
highlight(totallvlx1, totallvly1, totallvlx2-totallvlx1, totallvly2-totallvly1, 8, 0xffffff) ; total level v
highlight(sellitemocrx1, sellitemocry1, sellitemocrx2-sellitemocrx1, sellitemocry2-sellitemocry1, 9, 0x00ff00)
highlight(personalstashareax1, personalstashareay1, personalstashareax2-personalstashareax1, personalstashareay2-personalstashareay1, 10, 0x8f5d31)
ttp "xp progress", xpprogressx, xpprogressy, 1
ttp "stash", mousestashx, mousestashy, 2
ttp "sell", mousesellx, mouseselly, 3
ttp "select", mouseselectx, mouseselecty, 4
ttp "accept", mouseacceptx, mouseaccepty, 5
ttp "close1", mouseclosxx, mouseclosxy, 6
ttp "-1", minus1x, minus1y, 7
ttp "-5", minus5x, minus5y, 8
ttp "select", slctx, slcty, 9
ttp "max", maxtx, maxty, 10
ttp "close2", closexx, closexy, 11
}

\::{
global
sellallitem
}

CheckSelectedOre() {
global

x1 := personalstashareax1, y1 := personalstashareay1, x2 := personalstashareax2, y2 := personalstashareay2
tolerance := 1

howmuchtokeep := selectedorekeep, click5 := howmuchtokeep//5, click1 := (howmuchtokeep >= 5) ? mod(howmuchtokeep, 5) : howmuchtokeep
	
colormap := map()
colormap["uranium"] := [0x425F4B, 0x7DFF4C, 0x3D5746]
colormap["eye ore"] := [0xffd493, 0xa23f2c, 0x8c3e2c]
colormap["Lightite"] := [0xcef2fc, 0xF0FCEA, 0x7f9dc4]
colormap["Mythril"] := [0xb674ff, 0x22183e]

for key, color in colormap
{
range := 50
	loop 3 {
		if scanmultiplecolor(&x, &y, x1, y1, x2, y2, color, 5, range) {
			click x " " y
			sleep 50
			click maxtx " " maxty
			sleep 50
			clickedhowmuch := 0
			loop {
			TheOreAmount := trim(strreplace(tesseractOCR(quantityocrx1, quantityocry1, quantityocrx2, quantityocry2, "--psm 7 --oem 1 -l eng --dpi 300", 0xC7BFAE, 60), "`n", ""))
				if !(isnumber(TheOreAmount)) {
					click minus1x " " minus1y
					sleep 50
					clickedhowmuch++
				}else{
					break
				}
			}
			sleep 20
			if (clickedhowmuch) {
			click maxtx " " maxty
			}
			sleep 50
			if (TheOreAmount <= howmuchtokeep) {
				click closexx " " closexy
				sleep 50
				break
			}else{
			sleep 50
			loop click5 {
				click minus5x " " minus5y
				sleep 50
			}
			loop click1 {
				click minus1x " " minus1y
				sleep 50
			}
			sleep 50
			click slctx " " slcty
			sleep 50
			break
			}
		}
	}
}

}

f12::{
msgbox "f1 = exit`nf2 = reload`nf3 = retake settings (can be cancelled by reloading)`nf12 = help/info`n[ = start macro (cancel by reloading)`n] = toggle highlight`n\ = test the function","help/info","0x40000"
}

f3::{
makecordsettings()
}

makecordsettings() {
global
thedirectory := A_scriptdir "\IMAGEFORTUTORIAL\"

; ===============================|red error text|===============================
custommsgbox("Put it on the red error or something, the goal is to capture the text!!`nto get the right one, go mine an ore til your inventory is full`nor mine the ore somebody else is mining",, thedirectory "REDTEXTTHINGFORSTASHNSHI.png")
theredtextthing:
resizeablebar("Put this on the red error text or something",, 0xff0000, 610, 863, 1393-610, 926-863, 2.5)

highlight(x1, y1, x2-x1, y2-y1, 9)
theredtextx1 := x1, theredtexty1 := y1, theredtextx2 := x2, theredtexty2 := y2

custommsgbox("Is the box covering the red text?`nif it doesnt you can retake",,, 1, 1)
if (cmsgbox == 0) {
highlight(,,,,9)
goto theredtextthing
}
highlight(,,,,9)
; ===============================|total cash|===============================
custommsgbox("Put it on the cash like this, the goal is to capture the text!!",, thedirectory "TOTALCASH.png")
cashrestart:
resizeablebar("Put this on the total cash",, 0xff0000, 11, 974, (345-11), (1020-974), 2.5)

message := tesseractOCR(x1, y1, x2, y2, "--psm 7 --oem 1 -l eng --dpi 300", 0xFFE5A4, 10)
totalcashx1 := x1, totalcashy1 := y1, totalcashx2 := x2, totalcashy2 := y2

custommsgbox("Is it displaying the right text?? if yes, continue, if not reload the macro`nText: " message,, A_Scriptdir "\requiredfileformacro\balls.png", 1, 1)
if (cmsgbox == 0) {
goto cashrestart
}

; ===============================|total level|===============================
custommsgbox("Put it on the levels like this, the goal is to capture the text!!",, thedirectory "LEVEL.png")
levelrestart:
resizeablebar("Put this on the levels",, 0xff0000, 15, 943, (171-7), (975-943), 2.5)

message := tesseractOCR(x1, y1, x2, y2, "--psm 7 --oem 1 -l eng --dpi 300", 0xFFFFFF, 10)
totallvlx1 := x1, totallvly1 := y1, totallvlx2 := x2, totallvly2 := y2

custommsgbox("Is it displaying the right text?? if yes, continue, if not reload the macro`nText: " message,, A_Scriptdir "\requiredfileformacro\balls.png", 1, 1)
if (cmsgbox == 0) {
goto levelrestart
}

; ===============================|xp progress mouse tab|===============================
custommsgbox("Hover your mouse to the bottom middle of your screen and follow the next instruction",, thedirectory "XPMOUSEPROGRESS.png")
bleehhh:
GrabPositionByKey(&xpprogressx, &xpprogressy, "XP Progress")

highlight(xpprogressx-5, xpprogressy-5, 10, 10, 9)

custommsgbox("is it highlighting your mouse to the right place?",,, 1, 1)
if (cmsgbox == 0) {
highlight(,,,, 9)
goto bleehhh
}
highlight(,,,, 9)

; ===============================|xp progress ocr|===============================
custommsgbox("Put it on the XP message like this, the goal is to capture the text!!`nto get the message, you need to hover to your XP bar",, thedirectory "XPBAR.png")
xprestart:
resizeablebar("Put this on the XP MESSAGE",, 0xff0000, 748, 995, 1168-748, 1030-995, 2.5)

loop 6 {
mousemove xpprogressx, xpprogressy
sleep 50
}

message := tesseractOCR(x1, y1, x2, y2, "--psm 7 --oem 1 -l eng --dpi 300", 0xFFFFFF, 30)
xpbarforocrx1 := x1, xpbarforocry1 := y1, xpbarforocrx2 := x2, xpbarforocry2 := y2

custommsgbox("Is it displaying the right text?? if yes, continue, if not reload the macro`nText: " message,, A_Scriptdir "\requiredfileformacro\balls.png", 1, 1)
if (cmsgbox == 0) {
goto xprestart
}

; ===============================|mouse to stash tab|===============================
custommsgbox("Open your inventory and hover to stash",, thedirectory "MOUSESTASH.png")
themousetosatch:
GrabPositionByKey(&mousestashx, &mousestashy, "Hover to stash")

highlight(mousestashx-5, mousestashy-5, 10, 10, 9)

custommsgbox("is it highlighting your mouse to the right place?",,, 1, 1)
if (cmsgbox == 0) {
highlight(,,,, 9)
goto themousetosatch
}
highlight(,,,, 9)

; ===============================|sell item mouse|===============================
custommsgbox("Hover to sell item now",, thedirectory "MOUSESELL.png")
themousetosell:
GrabPositionByKey(&mousesellx, &mouseselly, "hover to sell item")

highlight(mousesellx-5, mouseselly-5, 10, 10, 9)

custommsgbox("is it highlighting your mouse to the right place?",,, 1, 1)
if (cmsgbox == 0) {
goto themousetosell
highlight(,,,, 9)
}
highlight(,,,, 9)

; ===============================|sell item ocr|===============================
custommsgbox("Put it on the sell item like this, the goal is to capture the text!!",, thedirectory "SELLITEM.png")
sellrestart:
resizeablebar("Put this on the Sell Items",, 0xff0000, 1242, 330, (1419-1242), (364-330), 2.5)


message := tesseractOCR(x1, y1, x2, y2)
sellitemocrx1 := x1, sellitemocry1 := y1, sellitemocrx2 := x2, sellitemocry2 := y2

custommsgbox("Is it displaying the right text?? if yes, continue, if not reload the macro`nText: " message,, A_Scriptdir "\requiredfileformacro\balls.png", 1, 1)
if (cmsgbox == 0) {
goto sellrestart
}

; ===============================|personal stash|===============================
custommsgbox("Put it on the personal stash like this, the goal is to capture the whole area!!",, thedirectory "PERSONALSTASH.png")
sellstasharea1:
cleartooltip()
resizeablebar("Put this on the personal stash area",, 0xff0000, 538, 279, 952-538, 679-279, 2.5)

colormap := map()
colormap["uranium"] := [0x425F4B, 0x7DFF4C, 0x3D5746]
colormap["eye ore"] := [0xffd493, 0xa23f2c, 0x8c3e2c]
colormap["Lightite"] := [0xcef2fc, 0xF0FCEA, 0x7f9dc4]
colormap["Mythril"] := [0xb674ff, 0x22183e]
x11 := x22 := x33 := x44 := y11 := y22 := y33 := y44 := 0

for key, color in colormap
{
thething2 := a_index a_index
range := 50
	loop 3 {
		if scanmultiplecolor(&x, &y, x1, y1, x2, y2, color, 5, range) {
			x%thething2% := x
			y%thething2% := y
		}
	}
}
personalstashareax1 := x1, personalstashareay1 := y1, personalstashareax2 := x2, personalstashareay2 := y2

ttp("lightite", x11, y11, 1) ttp("mythril", x22, y22, 2) ttp("eye ore", x33, y33, 3) ttp("uranium", x44, y44, 4)
sleep 500
custommsgbox("Is it showing the right coords?`nthe uranium, eye ore, lightite, mythril",,, 1, 1)
if (cmsgbox == 0) {
goto sellstasharea1
}
cleartooltip()

; ===============================|sell item|===============================
custommsgbox("Follow the instruction PERFECTLY!!!!!!!`nto get to this tab you need to press sell item",, thedirectory "SELLITEMSELECTALL.png")
mouseselect1:
GrabPositionByKey(&mouseselectx, &mouseselecty, "Hover to select all")
GrabPositionByKey(&mouseacceptx, &mouseaccepty, "Hover to Accept")
GrabPositionByKey(&mouseclosxx, &mouseclosxy, "Hover to close/x")

highlight(mouseselectx-5, mouseselecty-5, 10, 10, 9)
highlight(mouseacceptx-5, mouseaccepty-5, 10, 10, 10, 0x0000ff)
highlight(mouseclosxx-5, mouseclosxy-5, 10, 10, 11, 0x00ff00)

custommsgbox("is it highlighting your mouse to the right place?",,, 1, 1)
if (cmsgbox == 0) {
highlight(,,,, 9) highlight(,,,, 10) highlight(,,,, 11)
goto mouseselect1
}
highlight(,,,, 9) highlight(,,,, 10) highlight(,,,, 11)

; ===============================|select/unselect ocr|===============================
custommsgbox("Put it on the Select/Unselect All like this, the goal is to capture the text!!`nto get the message, you need to click sell items",, thedirectory "SELECTALL.png")
selectstart:
resizeablebar("Put this on the Select/Unselect All",, 0xff0000, 846, 643, 1074-846, 689-643, 2.5)

message := tesseractOCR(x1, y1, x2, y2)
theselectforocrx1 := x1, theselectforocry1 := y1, theselectforocrx2 := x2, theselectforocry2 := y2

custommsgbox("Is it displaying the right text?? if yes, continue, if not reload the macro`nText: " message,, A_Scriptdir "\requiredfileformacro\balls.png", 1, 1)
if (cmsgbox == 0) {
goto selectstart
}

; ===============================|confirmation tab|===============================
custommsgbox("Open the confirmation tab and follow the next instruction PERFECTLY`nto open this tab you need to click on an ore",, thedirectory "QUANTITYMOUSE.png")
quantitymouse1:
GrabPositionByKey(&minus1x, &minus1y, "hover to -1")
GrabPositionByKey(&minus5x, &minus5y, "hover to -5")
GrabPositionByKey(&slctx, &slcty, "hover to select")
GrabPositionByKey(&maxtx, &maxty, "hover to max")
GrabPositionByKey(&closexx, &closexy, "hover to close/x")

highlight(minus1x-5, minus1y-5, 10, 10, 9, 0xff0000)
highlight(minus5x-5, minus5y-5, 10, 10, 10, 0x0000ff)
highlight(slctx-5, slcty-5, 10, 10, 11, 0x00ff00)
highlight(maxtx-5, maxty-5, 10, 10, 12, 0xff00ff)
highlight(closexx-5, closexy-5, 10, 10, 13, 0xffff00)

custommsgbox("is it highlighting your mouse to the right place?`nred = -1`nblue = -5`ngreen = select`npink = max`nyellow = close/x",,, 1, 1)
if (cmsgbox == 0) {
highlight(,,,, 9) highlight(,,,, 10) highlight(,,,, 11) highlight(,,,, 12) highlight(,,,, 13)
goto quantitymouse1
}
highlight(,,,, 9) highlight(,,,, 10) highlight(,,,, 11) highlight(,,,, 12) highlight(,,,, 13)

; ===============================|quantity|===============================
custommsgbox("Put it on the number like this, the goal is to capture the text!!`nto get the message, you need to go to the confirmation messages after pressing an ore",, thedirectory "QUANTITY.png")
quantitypart:
resizeablebar("Put this on the number",, 0xff0000, 921, 479, 1001-921, 525-479, 2.5)

message := tesseractOCR(x1, y1, x2, y2, "--psm 7 --oem 1 -l eng --dpi 300", 0xC7BFAE, 60)
quantityocrx1 := x1, quantityocry1 := y1, quantityocrx2 := x2, quantityocry2 := y2

custommsgbox("Is it displaying the right text?? if yes, continue, if not reload the macro might not work on certain number (11, 17, 35)`ndont worry though, the code account for that so just keep going`nText: " message,, A_Scriptdir "\requiredfileformacro\balls.png", 1, 1)
if (cmsgbox == 0) {
goto quantitypart
}

; ===============================|yes sell confirm|===============================
custommsgbox("Open the sell confirmation by pressing Accept then hover to YES",, thedirectory "MOUSEYES.png")
mouseselect2:
GrabPositionByKey(&mouseyesx, &mouseyesy, "hover to YES")

highlight(mouseyesx-5, mouseyesy-5, 10, 10, 9)

custommsgbox("is it highlighting your mouse to the right place?",,, 1, 1)
if (cmsgbox == 0) {
highlight(,,,, 9)
goto mouseselect2
}
highlight(,,,, 9)

; ===============================|yes/no ocr|===============================
custommsgbox("Put it on the YES/NO like this, the goal is to capture the text!!`nto get the message, you need to confirm sell an item",, thedirectory "YES.png")
yesnostart:
resizeablebar("Put this on the YES/NO",, 0xff0000, 763, 538, 1154-763, 592-538, 2.5)

message := tesseractOCR(x1, y1, x2, y2)
yesnoocrx1 := x1, yesnoocry1 := y1, yesnoocrx2 := x2, yesnoocry2 := y2

custommsgbox("Is it displaying the right text?? if yes, continue, if not reload the macro`nText: " message,, A_Scriptdir "\requiredfileformacro\balls.png", 1, 1)
if (cmsgbox == 0) {
goto yesnostart
}

; ===============================|cash gain|===============================
custommsgbox("Put it on the cash gain like this, the goal is to capture the text!!`nto get the message, you need to confirm sell an item",, thedirectory "DABLOONS.png")
cashgainstart:
resizeablebar("Put this on the cash gain",, 0xff0000, 819, 488, 1086-819, 523-488, 2.5)

message := tesseractOCR(x1, y1, x2, y2, "--psm 7 --oem 1 -l eng --dpi 300", 0xFFE5A4, 100)
cashgainocrx1 := x1, cashgainocry1 := y1, cashgainocrx2 := x2, cashgainocry2 := y2

custommsgbox("Is it displaying the right text?? if yes, continue, if not reload the macro`nText: " message,, A_Scriptdir "\requiredfileformacro\balls.png", 1, 1)
if (cmsgbox == 0) {
goto cashgainstart
}

; ===============================|end|===============================
try filedelete(A_ScriptDir "\requiredfileformacro\coordsave.txt")
fileappend
(
"theredtextx1 = " theredtextx1
"`ntheredtexty1 = " theredtexty1
"`ntheredtextx2 = " theredtextx2
"`ntheredtexty2 = " theredtexty2
"`ntotalcashx1 = " totalcashx1
"`ntotalcashy1 = " totalcashy1
"`ntotalcashx2 = " totalcashx2
"`ntotalcashy2 = " totalcashy2
"`ntotallvlx1 = " totallvlx1
"`ntotallvly1 = " totallvly1
"`ntotallvlx2 = " totallvlx2
"`ntotallvly2 = " totallvly2
"`nxpprogressx = " xpprogressx
"`nxpprogressy = " xpprogressy
"`nxpbarforocrx1 = " xpbarforocrx1
"`nxpbarforocry1 = " xpbarforocry1
"`nxpbarforocrx2 = " xpbarforocrx2
"`nxpbarforocry2 = " xpbarforocry2
"`nmousestashx = " mousestashx
"`nmousestashy = " mousestashy
"`nmousesellx = " mousesellx
"`nmouseselly = " mouseselly
"`nsellitemocrx1 = " sellitemocrx1
"`nsellitemocry1 = " sellitemocry1
"`nsellitemocrx2 = " sellitemocrx2
"`nsellitemocry2 = " sellitemocry2
"`npersonalstashareax1 = " personalstashareax1
"`npersonalstashareay1 = " personalstashareay1
"`npersonalstashareax2 = " personalstashareax2
"`npersonalstashareay2 = " personalstashareay2
"`nmouseselectx = " mouseselectx
"`nmouseselecty = " mouseselecty
"`nmouseacceptx = " mouseacceptx
"`nmouseaccepty = " mouseaccepty
"`nmouseclosxx = " mouseclosxx
"`nmouseclosxy = " mouseclosxy
"`ntheselectforocrx1 = " theselectforocrx1
"`ntheselectforocry1 = " theselectforocry1
"`ntheselectforocrx2 = " theselectforocrx2
"`ntheselectforocry2 = " theselectforocry2
"`nminus1x = " minus1x
"`nminus1y = " minus1y
"`nminus5x = " minus5x
"`nminus5y = " minus5y
"`nslctx = " slctx
"`nslcty = " slcty
"`nmaxtx = " maxtx
"`nmaxty = " maxty
"`nclosexx = " closexx
"`nclosexy = " closexy
"`nquantityocrx1 = " quantityocrx1
"`nquantityocry1 = " quantityocry1
"`nquantityocrx2 = " quantityocrx2
"`nquantityocry2 = " quantityocry2
"`nmouseyesx = " mouseyesx
"`nmouseyesy = " mouseyesy
"`nyesnoocrx1 = " yesnoocrx1
"`nyesnoocry1 = " yesnoocry1
"`nyesnoocrx2 = " yesnoocrx2
"`nyesnoocry2 = " yesnoocry2
"`ncashgainocrx1 = " cashgainocrx1
"`ncashgainocry1 = " cashgainocry1
"`ncashgainocrx2 = " cashgainocrx2
"`ncashgainocry2 = " cashgainocry2
), A_ScriptDir "\requiredfileformacro\coordsave.txt"
readsettings(A_ScriptDir "\requiredfileformacro\coordsave.txt")
msgbox "Setup is done!`nSettings is saved at `"" A_ScriptDir "\requiredfileformacro\coordsave.txt`"`n`nSmall Guide:`nf1 = exit`nf2 = reload`nf3 = retake settings (can be cancelled by reloading)`nf12 = help/info`n[ = start macro (cancel by reloading)`n] = toggle highlight`n\ = test the function","info","0x40000"
}

GrabPositionByKey(&x, &y, messages := "", keystowait := "r") {
global
anotherthing := (*) => mousegetpos(&xx, &yy) ttp(messages "`n`nPress `"" keystowait "`" to continue", xx+30, yy+10,20)
settimer anotherthing, 25
keywait keystowait, "D"
mousegetpos &x, &y
keywait keystowait
settimer anotherthing, 0
ttp ,,, 20
}

custommsgbox(msg?, winnamething?, fileloc := "", multi := 0.5, options := 0) {
global
msgboxGUI := Gui("-MinimizeBox -Resize +AlwaysOnTop +Border")
msgboxGUI.setfont("s9 q2 w400", "Segoe UI")
text := msgboxGUI.add("text", "Backgroundffffff x10 y23" ,msg)
if (fileloc != "") {
imagesomething := ComObject("WIA.ImageFile")
imagesomething.LoadFile(fileloc)
loop {
	if (imagesomething.width*multi >= a_screenwidth*0.8 or imagesomething.height*multi >= a_screenheight*0.8) {
		multi -= 0.01
	}else{
		break
	}
}
text.getpos(, &yt,, &ht)
theimage := msgboxGUI.add("Picture", "x" 30 " y" yt+ht+25 " w" imagesomething.width*multi " h" imagesomething.height*multi, fileloc)
}
try msgboxGUI.title := winnamething
msgboxGUI.show()
msgboxGUI.getpos(&x, &y, &w, &h)
if (w <= 247) {
w2 := w+200
w3 := 247+165
}else{
w2 := w+25
}
msgboxGUI.Add("Text", "Backgroundffffff y-8 x-8 w" 10000 " h" h-20)
if (options == 0) {
theok := msgboxGUI.add("Button", "h22 w" w " x" 5 " y" h-20, "CONTINUE")
}else if (options == 1) {
if (w <= 247) {
theok := msgboxGUI.add("Button", "h22 w" w3/2.05 " x" 5+w3/2.05+5 " y" h-20, "CONTINUE")
therestart := msgboxGUI.add("Button", "h22 w" w3/2.05 " x" 5 " y" h-20, "RESTART")
}else{
theok := msgboxGUI.add("Button", "h22 w" w/2.05 " x" 10+w/2.05+5 " y" h-20, "CONTINUE")
therestart := msgboxGUI.add("Button", "h22 w" w/2.05 " x" 5 " y" h-20, "RESTART")
}
therestart.onevent("click", (*) => msgboxGUI.destroy() cmsgbox := 0)
}

theok.onevent("click", (*) => msgboxGUI.destroy() cmsgbox := 1)
msgboxGUI.onevent("close", (*) => msgboxGUI.destroy() cmsgbox := 1)

msgboxGUI.move(a_screenwidth/2-(w2/2), A_Screenheight/2-((h+50)/2), w2, h+50)
loop {
	try {
		winexist("ahk_id " msgboxGUI.hwnd)
	}catch{
		break
	}
}
}

resizeablebar(messages := "", keystowait := "r", color := "0x00ff00", whereitwouldbe := "0", whereitactuallyis := "0", TemporaryWidth := "100", TemporaryHeight := "70", boldness := "2", autoresizetores := "1") {
global
	ScaleGUI := Gui("+ToolWindow +Resize -Caption +AlwaysOnTop -Border")
	ScaleGUI.backcolor := color
	ScaleGUI.Show()
	MouseGetPos(&xxxxx1, &yyyyy1)
	sw := A_ScreenWidth/1920
	sh := A_ScreenHeight/1080
	if (autoresizetores == 1) {
		TemporaryWidth := round(TemporaryWidth*sw), TemporaryHeight := round(TemporaryHeight*sh), whereitwouldbe := round(whereitwouldbe*sw), whereitactuallyis := round(whereitactuallyis*sh)
	}else{
		TemporaryWidth := round(TemporaryWidth), TemporaryHeight := round(TemporaryHeight), whereitwouldbe := round(whereitwouldbe), whereitactuallyis := round(whereitactuallyis)
	}
	if !(whereitwouldbe and whereitactuallyis) {
	whereitwouldbe := round(xxxxx1-TemporaryWidth//2)
	whereitactuallyis := round(yyyyy1-TemporaryHeight//2)
	}
	ScaleGUI.Opt("+LastFound")
	WinMove(whereitwouldbe, whereitactuallyis, TemporaryWidth, TemporaryHeight, ScaleGUI)
	WinSetTransparent(1)
	makeitgone := 0
	thething := (*) => tracingwithttp(ScaleGUI, color, messages, keystowait, boldness)
	settimer thething, 10
	keywait keystowait, "D"
	keywait keystowait
	makeitgone := 1
	settimer thething, 0
	thething()
	
	ttp ,,, 20
	WinGetPos( &Xx, &Yy, &Width, &Height, ScaleGUI)
	x1 := Xx
	x2 := Xx + Width
	y1 := Yy
	y2 := Yy + Height
	ScaleGUI.destroy()
}

tracingwithttp(thegui?, color?, messages := "", keystowait := "r", d := "2") {
global
thegui.getpos(&x, &y, &w, &h)
mousegetpos(&xx, &yy)
ttp(messages "`n`nPress `"" keystowait "`" to continue", xx+30, yy+10,20)
static gui100 := []
firsttime := 0
	if (makeitgone == 1) {
        for _, r in gui100
            r.Destroy()
        gui100 := []
		global HighlightStatus := 0
		return
    }
	global HighlightStatus := 1
    if !gui100.Length {
        Loop 4
            gui100.Push(Gui("+AlwaysOnTop -Caption +ToolWindow -DPIScale +E0x08080020"))
		firsttime := 1
		}
	Loop 4 {
		i:=A_Index
		, x1:=(i=2 ? x+w : x-d)
		, y1:=(i=3 ? y+h : y-d)
		, w1:=(i=1 or i=3 ? w+2*d : d)
		, h1:=(i=2 or i=4 ? h+2*d : d)
		gui100[i].BackColor := color
		if (firsttime == 1) {
		gui100[i].Show("NA x" . x1 . " y" . y1 . " w" . w1 . " h" . h1)
		}else{
		gui100[i].move(x1, y1, w1, h1)
		}
		WinSetTransparent 255, "ahk_id " gui100[i].hwnd
	}
}

sellallitem() {
global
send "T"
sleep 500
loop {
	click mousestashx " " mousestashy
	if (instr(tesseractOCR(sellitemocrx1, sellitemocry1, sellitemocrx2, sellitemocry2), "Sell Items")) {
	break
	}
}
breakaction := 0
mousemove xpprogressx, xpprogressy
timeout := 0
loop {
	texp := tesseractOCR(xpbarforocrx1, xpbarforocry1, xpbarforocrx2, xpbarforocry2, "--psm 7 --oem 1 -l eng --dpi 300", 0xFFFFFF, 30)
	if !instr(texp, "XP") {
		texp := tesseractOCR(xpbarforocrx1, xpbarforocry1, xpbarforocrx2, xpbarforocry2, "--psm 7 --oem 1 -l eng --dpi 300", 0x727272, 30)
	}
	
	if instr(texp, "XP") {
		trimexp := trim(RegExReplace(strreplace(texp, "`n", ""), "[.,]", ""))
		break
	}
	timeout++
	if (timeout >= 50) {
	break
	}
}
try {
furtherexp := trim(strreplace(trimexp, "XP:", ""))
moresteps := strsplit(furtherexp, "/")
exppercentage := Format("{:.2f}", rtrim(rtrim((moresteps[1]/moresteps[2])*100, "0"), "."))
}catch{
furtherexp := "broken"
exppercentage := "broken"
}

click mousesellx " " mouseselly
loop {
	if (instr(tesseractOCR(theselectforocrx1, theselectforocry1, theselectforocrx2, theselectforocry2), "Select All")) {
	break
	}else if (instr(tesseractOCR(theselectforocrx1, theselectforocry1, theselectforocrx2, theselectforocry2), "Unselect All")) {
		click mouseclosxx " " mouseclosxy
		breakaction := 1
		break
	}
}
if (breakaction == 1) {
return
}
click mouseselectx " " mouseselecty
mousemove A_Screenwidth/2, A_ScreenHeight/2
loop {
	click mouseselectx " " mouseselecty
	mousemove A_Screenwidth/2, A_ScreenHeight/2
	if (instr(tesseractOCR(theselectforocrx1, theselectforocry1, theselectforocrx2, theselectforocry2), "Unselect All")) {
	break
	}
}
sleep 100
CheckSelectedOre()
sleep 100
click mouseacceptx " " mouseaccepty
timeout := 0
tlimit := 22
loop {
	if (instr(tesseractOCR(yesnoocrx1, yesnoocry1, yesnoocrx2, yesnoocry2), "YES")) {
	money := trim(strreplace(tesseractOCR(cashgainocrx1, cashgainocry1, cashgainocrx2, cashgainocry2, "--psm 7 --oem 1 -l eng --dpi 300", 0xFFE5A4, 100), "`n", ""))
	break
	}
	timeout++
	if (timeout >= tlimit) {
		click mouseclosxx " " mouseclosxy
		breakaction := 1
		break
	}
}
if (breakaction == 1) {
return
}
click mouseyesx " " mouseyesy
loop {
	if !(instr(tesseractOCR(yesnoocrx1, yesnoocry1, yesnoocrx2, yesnoocry2), "YES")) {
;	sleep 500
	break
	}
}
sleep 2700
CurrentLevel := rtrim(trim(strreplace(strreplace(tesseractOCR(totallvlx1, totallvly1, totallvlx2, totallvly2, "--psm 7 --oem 1 -l eng --dpi 300", 0xFFFFFF, 10), "Level", ""), "`n", "")), ".")
click mouseclosxx " " mouseclosxy
formattedmoney := rtrim(strreplace(strreplace(trim(strreplace(strreplace(trim(money), " 2", ""), "?", "")), " ", "."), "`n", ""), ".")
TotalCash := strreplace(strreplace(strreplace(trim(ltrim(tesseractOCR(totalcashx1, totalcashy1, totalcashx2, totalcashy2, "--psm 7 --oem 1 -l eng --dpi 300", 0xFFE5A4, 10), "S")), " ", ","), "`n", ""), "$", "")
ttp "Sold For: " formattedmoney, 1, 1, 1
totalSeconds := Floor((A_TickCount-PreviousMS) / 1000), ms := mod(A_TickCount-PreviousMS, 1000), seconds := Mod(totalSeconds, 60), minutes := Mod(Floor(totalSeconds / 60), 60), hours   := Floor(totalSeconds / 3600)
formatted2 := Format("{:02}:{:02}:{:02}.{}", hours, minutes, seconds, ms)
if (instr(discordwebhook, "https://discord.com/api/webhooks/")) {
	try SendDiscordWebhook(discordwebhook, "Sold all your item for **$" formattedmoney "!**\nCurrent Level: **" CurrentLevel " | " furtherexp " (" exppercentage "%)**\nTotal Cash: **$" TotalCash "**\n-# Run Time: " ConvertTickToDate() " (" formatted2 " from previous messages)\n-# Launch Time: " launchedat)
}
}

SendDiscordWebhook(webhookURL := 0, message := "Test from Auto Mine") {
global
	if (webhookURL == 0 or trim(webhookURL) == "") {
	return
	}
    http := ComObject("WinHttp.WinHttpRequest.5.1")
    json := '{"content":"' message '"}'
    http.Open("POST", webhookURL, false)
    http.SetRequestHeader("Content-Type", "application/json")
    http.Send(json)
}

ConvertTickToDate() {
global
totalSeconds := Floor((A_TickCount-runtime) / 1000)
PreviousMS := A_TickCount
ms := mod(A_TickCount-runtime, 1000)
seconds := Mod(totalSeconds, 60)
minutes := Mod(Floor(totalSeconds / 60), 60)
hours   := Floor(totalSeconds / 3600)
formatted := Format("{:02}:{:02}:{:02}.{}", hours, minutes, seconds, ms)
return formatted
}

[::{
global
launchedat := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
runtime := A_TickCount
PreviousMS := A_TickCount
sw := 1
sh := 1
loop {
if winactive("Roblox") {
click A_Screenwidth/2 " " A_ScreenHeight/2
}
	if (pixelsearch(&t, &t, theredtextx1, theredtexty1, theredtextx2, theredtexty2, 0xFF0004, 2)) {
		snap(theredtextx1, theredtexty1, theredtextx2, theredtexty2, A_ScriptDir "\requiredfileformacro\balls.png") 
		;sleep 150
		runwait tesseractocrlocation " `"" A_ScriptDir "\requiredfileformacro\balls.png" "`" `"" A_ScriptDir "\requiredfileformacro\outputthing" "`" --psm 4 --oem 1 -l eng --dpi 300",, "Hide"
		thetext := fileread(A_ScriptDir "\requiredfileformacro\outputthing.txt")
		ttp "Got Text: " thetext, 1, 1, 1
;		settimer cleartooltip, -2000
		if (instr(thetext, "You have filled all the available slots for Stash!") or instr(thetext, "Stash") or instr(thetext, "available") or instr(thetext, "slots") or instr(thetext, "filled all")) {
	;		msgbox "FULL INVENTORY", "full", 0x40000
			sellallitem()
		}
	}
}
}

f1::exitapp
f2::reload

tesseractOCR(x := "1", y := "1", x2 := "2", y2 := "2", options := "--psm 4 --oem 1 -l eng --dpi 300", targethex := 0, tol := 0) {
if (targethex == 0 and tol == 0) {
snap(x, y, x2, y2, A_ScriptDir "\requiredfileformacro\balls.png")
}else{
snapColorOCR(x, y, x2, y2, A_ScriptDir "\requiredfileformacro\balls.png", targethex, tol)
}
runwait tesseractocrlocation " `"" A_ScriptDir "\requiredfileformacro\balls.png" "`" `"" A_ScriptDir "\requiredfileformacro\outputthing" "`" " options,, "Hide"
thetext := fileread(A_ScriptDir "\requiredfileformacro\outputthing.txt")
return thetext
}

snap(x, y, w, h, storeloc) {
w := w-x
h := h-y
pToken := Gdip_Startup()
if (!pToken) {
    ttp "Failed to start GDI+", 1, 1, 1
    ExitApp
}
region := x "|" y "|" w "|" h

pBitmap := Gdip_BitmapFromScreen(region)
if (pBitmap < 0) {
    ttp "Invalid capture region", 1, 1, 1
    Gdip_Shutdown(pToken)
    ExitApp
}

output := storeloc
result := Gdip_SaveBitmapToFile(pBitmap, output)

if (result != 0) {
    ttp "Failed to save image. Error: " result, 1, 1, 1
} else {
    ttp "Saved: " output, 1, 1, 1
}
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
}

snapColorOCR(x, y, w, h, storeloc, targetHex := 0xC7BFAE, tol := 50) {
	w := w - x
	h := h - y
		
	pToken := Gdip_Startup()
	if (!pToken) {
		ttp "Failed to start GDI+", 1, 1, 1
		return
	}

	region := x "|" y "|" w "|" h
	pBitmap := Gdip_BitmapFromScreen(region)

	if (pBitmap < 0) {
		ttp "Invalid capture region", 1, 1, 1
		Gdip_Shutdown(pToken)
		return
	}

	; --- Extract RGB from target color (#C7BFAE) ---
	tr := (targetHex >> 16) & 0xFF  ; 199
	tg := (targetHex >> 8)  & 0xFF  ; 191
	tb :=  targetHex        & 0xFF  ; 174

	width  := Gdip_GetImageWidth(pBitmap)
	height := Gdip_GetImageHeight(pBitmap)

	; --- COLOR FILTER LOOP ---
	Loop height {
		py := A_Index - 1
		Loop width {
			px := A_Index - 1
			c := Gdip_GetPixel(pBitmap, px, py)

			r := (c >> 16) & 0xFF
			g := (c >> 8)  & 0xFF
			b :=  c        & 0xFF

			if (Abs(r - tr) <= tol && Abs(g - tg) <= tol && Abs(b - tb) <= tol) {
				; Keep matching color as WHITE for OCR
				Gdip_SetPixel(pBitmap, px, py, 0xFFFFFFFF)
			} else {
				; Remove everything else (BLACK)
				Gdip_SetPixel(pBitmap, px, py, 0xFF000000)
			}
		}
	}

	; --- Save filtered image ---
	result := Gdip_SaveBitmapToFile(pBitmap, storeloc)
	if (result != 0) {
	ttp "Failed to save image. Error: " result, 1, 1, 1
	} else {
	ttp "Filtered OCR image saved: " storeloc, 1, 1, 1
	}

	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown(pToken)
}

cleartooltip() {
tooltiprn2 := 1
loop 20 {
	ttp ,,,tooltiprn2
	tooltiprn2++
	}
}

scanmultiplecolor(&xout, &yout, x1, y1, x2, y2, colorarray, tolerance, range) {
	found := 0

	loop {
		triedfinding := 0
	;	ttp y1, 1, y1, 1
		if (pixelsearch(&x, &y, x1, y1, x2, y2, colorarray[1], tolerance)) {
			xf := x
			yf := y
			triedfinding := 1
		;	msgbox "hi"
			for i, v in colorarray
			{
			;	msgbox v " " x " " y  " " range " " tolerance " " found
				if (trim(v) != "") {
					if (pixelsearch(&x, &y, x-range, y-range, x+range, y+range, v, tolerance)) {
						found += 1
					}else{
						found := 0
						break
					}
				}
			}
		}

		if (found == colorarray.length) {
			xout := x, yout := y
			return true
			break
		}else if (found < colorarray.length) {
			if (triedfinding == 1) {
				try y1 := yf+range
			}else{
				try y1 := y1+range+1
			}
			if (triedfinding == 0 or y2 < y1) {
			;	ttp ,,, 1
				return false
				break
			}
		}
	}
}


Highlight(x?, y?, w?, h?, guiindex := "1", color:="Red", d:=2, showTime:=0) {
static gui1 := [], gui2 := [], gui3 := [], gui4 := [], gui5 := [], gui6 := [], gui7 := [], gui8 := [], gui9 := [], gui10 := []
static gui11 := [], gui12 := [], gui13 := [], gui14 := [], gui15 := [], gui16 := [], gui17 := [], gui18 := [], gui19 := [], gui20 := []

	if !IsSet(x) {
        for _, r in gui%guiindex%
            r.Destroy()
        gui%guiindex% := []
		global HighlightStatus := 0
		return
    }
	
	global HighlightStatus := 1
    if !gui%guiindex%.Length {
        Loop 4
            gui%guiindex%.Push(Gui("+AlwaysOnTop -Caption +ToolWindow -DPIScale +E0x08080020"))
    }
	Loop 4 {
		i:=A_Index
		, x1:=(i=2 ? x+w : x-d)
		, y1:=(i=3 ? y+h : y-d)
		, w1:=(i=1 or i=3 ? w+2*d : d)
		, h1:=(i=2 or i=4 ? h+2*d : d)
		gui%guiindex%[i].BackColor := color
		gui%guiindex%[i].Show("NA x" . x1 . " y" . y1 . " w" . w1 . " h" . h1)
		WinSetTransparent 255, "ahk_id " gui%guiindex%[i].hwnd
	}
	if showTime > 0 {
		Sleep(showTime)
		Highlight()
	} else if showTime < 0
		SetTimer(Highlight, -Abs(showTime))
}