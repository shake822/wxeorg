<!--#include file="../inc/upload.inc.asp"-->
<%
dim upload,file,formName,formPath,filename,fileExt
dim ranNum
call UpFile()
'===========无组件上传(upload_0)====================
sub UpFile()
set upload=new UpFile_Class '建立上传对象
upload.GetData (500*1024) '取得上传数据,此处即为500 K
if upload.err > 0 then
select case upload.err
case 1
Response.Write "请先选择你要上传的文件　[ <a href=# onclick=history.go(-1)>重新上传</a> ]"
case 2
Response.Write "图片大小超过了限制 500 K　[ <a href=# onclick=history.go(-1)>重新上传</a> ]"
end select
exit sub
else
formPath=upload.form("filepath") '文件保存目录,此目录必须为程序可读写
formPath="../photo"
if formPath="" then
formPath="rwdata/"
end if
'在目录后加(/)
if right(formPath,1)<>"/" then 
formPath=formPath&"/"
end if 
for each formName in upload.file '列出所有上传了的文件
set file=upload.file(formName) '生成一个文件对象
if file.filesize<100 then
response.write "请先选择你要上传的图片　[ <a href=# onclick=history.go(-1)>重新上传</a> ]"
response.end
end if

fileExt=lcase(file.FileExt)
if CheckFileExt(fileEXT)=false then
response.write "文件格式不正确　[ <a href=# onclick=history.go(-1)>重新上传</a> ]"
response.end
end if

'randomize
ranNum=int(90000*rnd)+10000
filename=formPath&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&ranNum&"."&fileExt
if file.FileSize>0 then '如果 FileSize > 0 说明有文件数据
result=file.SaveToFile(Server.mappath(filename)) '保存文件
if result="ok" then
response.write formName&" upload OK, had saved to "&filename&"<br>"
else
response.write formName&" upload Fail,"&result&"<br>"
end if
end if
set file=nothing
next
set upload=nothing
end if
end sub

'判断文件类型是否合格
Private Function CheckFileExt (fileEXT)
dim Forumupload
Forumupload="gif,jpg,bmp,jpeg"
Forumupload=split(Forumupload,",")
for i=0 to ubound(Forumupload)
if lcase(fileEXT)=lcase(trim(Forumupload(i))) then
CheckFileExt=true
exit Function
else
CheckFileExt=false
end if
next
End Function
if Request.QueryString("goodsid") = "" then
response.Redirect "../common/addgoods.asp?add=true&filename=" & filename
else
response.Redirect "../common/addgoods.asp?temp=" & Request.QueryString("goodsid") & "&filename=" & filename
end if
%>


