<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>备份下载</title>
</head>

<body>
<% 
function bl(path) 
set fso=server.createobject("scripting.filesystemobject") 
set fl=fso.getfolder(path) 
on error resume next 
response.write "当前路径"&path&fl.files.count&"<br />此文件夹有如下文件：" 
for each fn in fl.files 
response.write "<br />|--"&fn.name 
next 
set fso=nothing
end function 

bl(server.mappath("../backup"))
%>
</body>
</html>
