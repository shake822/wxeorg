<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<% call CheckAuthority("strReg") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>软件认证</title>
</head>

<body>
<%
if Request.QueryString("regedit") <> "" then
  sql = "update t_softinfo set regedit = " & Request.QueryString("regedit")
  
  conn.execute(sql)
end if
sql = "select * from t_softinfo"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
if rs("regedit") = True then
  Response.Write "<a href=""regedit.asp?regedit=0""> 将软件降为试用版</a>"
else
  Response.Write "<a href=""regedit.asp?regedit=1"">将软件升为正式版</a>"
end if
close_rs(rs)
endconnection
%>
</body>
</html>
