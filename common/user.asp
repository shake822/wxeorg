<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strOperator") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>操作员管理</title>
</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<br>
<div align="center"><span class="style1">操作员管理</span></div>
<br>
<div align="center">
<table id="tbl" border="0" cellpadding="3" cellspacing="0" align="center" empty-cells:show style="word-break : break-all;">
<tr bgcolor="#FFFFFF"  style="background-color:#999999;   border-bottom:2px   solid   black;   height:25px"   align="center"><th>操作员</th><th>操作</th></tr>
<%
sql = "select * from t_user"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
Do While Not rs.EOF
%>
<script>
function del(str){
if(!confirm('确定要删除该操作员的资料吗?')){
return false
}else{
window.location.href='../action/deluser.asp?username='+str
}
}
</script>
<tr id="tr" bgcolor="#FFFFFF" align="center">
  <td bgcolor="#FFFFFF"><%=rs("username")%></td>
  <td>&nbsp;&nbsp;&nbsp;&nbsp;<a href="adduser.asp?add=false&username=<%=rs("username")%>">编辑操作员</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="power.asp?username=<%=rs("username")%>">修改权限</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onClick="del('<%=rs("username")%>')">删除</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
</tr>
<%
rs.movenext
loop
close_rs(rs)
endconnection
%>
</table>
<input type="button" class="button" value=" 新 增 "  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  onClick="window.location.href='adduser.asp?add=true'"></div>
</div >
</body>

</html>
