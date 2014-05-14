<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script>
function checkAll(e, itemName){
var aa = document.getElementsByName(itemName);
for (var j=0; j<aa.length; j++)
aa[j].checked = e.checked;
}

function checkadd(){
  if (document.adduser.username.value == ""){
    alert("请输入操作员账号！");
	document.adduser.username.focus();
	return false;
  }
}
function setHiddenRow(oTable,k)
{
   oTable.style.display = oTable.style.display == "none"?"block":"none";
}
</script>
<title>新增操作员</title>
</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<br>
<%if Request.QueryString("add") = "true" then%>
<div align="center"><span class="style1">新增操作员</span></div>
<form name="adduser" method="post" onSubmit="return checkadd();" action="../action/saveuser.asp?add=true">
<div align="center"><input type="submit" value=" 保存 "  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" class="button" /></div>
<table border="0" align="center">
  <tr>
    <td>操作员名称</td>
	<td><input name="username" type="text" size="16"/></td>
  </tr>
  <tr>
    <td>  密  码  </td>
	<td><input name="password" type="password" size="16" /></td>
  </tr>
</table>
<table border="0" align="center">
<tr>
<td><input type="checkbox" name="Rdepot"  <%=checkdepot%>  onClick="setHiddenRow(document.getElementById('tbl'),1)"/>
 开启仓库权限管理</td>

</tr>
<tr valign="top"><td>
<table align="center" id="tbl" border="0" style="display:none">
<tr>
	<th>仓库名称</th>
	<th><input type="checkbox" onClick="checkAll(this,'depot')">选择</th>
</tr>            
<%sql = "select * from t_depot"
  set rs = server.CreateObject("adodb.recordset")
  rs.Open sql, conn, 1, 1
  For i = 1 To rs.recordcount
  Response.Write "<tr><td align=""center"">"&rs("depotname")&"</td><td align=""center""><input type=""checkbox"" name=""depot"" value="""&rs("depotname")&"""></td></tr>"
  rs.movenext
  next
  close_rs(rs)
%>
</table>
</td>
<td>

</td>
<td>

</td>
</tr></table>
<div align="center"><input type="submit" value=" 保存 "  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" class="button" /></div></form>
<%else%>
<div align="center"><span class="style1">编辑操作员</span></div>
<form name="adduser" method="post" action="../action/saveuser.asp?add=false&user=<%=Request.QueryString("username")%>">
<div align="center"><input type="submit" value=" 保存 " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" /></div>
<%
set rs=server.CreateObject("adodb.recordset")
sql="select * from t_user where username='"&request.QueryString("username")&"'"
rs.open sql,conn,1,3
if not rs.eof then
pass=rs("password")
end if

%>
<table border="0" align="center">
  <tr>
    <td>操作员名称</td>
	
	<td><input name="username" type="text" size="16" readonly value="<%=Request.QueryString("username")%>"/></td>
    <td>密码</td>
	<td><input name="pass" type="text" size="16" value="<%=pass%>"/></td>
	
  </tr>
</table>
<% sqltext = "select * from t_user where username='"&request.QueryString("username")&"'"
	set rs_sql = Server.CreateObject("adodb.recordset")
	rs_sql.open sqltext,conn,1,1
 	if rs_sql("RDepot")=true then
	checkdepot = "checked"
	tb1="block"
	else
	checkdepot = " "
	tb1="none"
	end if
	if rs_sql("RCust")=true then
	checkcust = "checked"
	tb2="block"
	else
	checkcust = " "
	tb2="none"
	end if
	if rs_sql("RGoodstype")=true then
	checktype = "checked"
	tb3="block"
	else
	checktype = " "
	tb3="none"
	end if
	close_rs(rs_sql)  
 %>
<table border="0" align="center">
<tr>
<td><input type="checkbox" name="Rdepot"  <%=checkdepot%>  onClick="setHiddenRow(document.getElementById('tbl'),1)"/>
 开启仓库权限管理</td>

</tr>
<tr valign="top"><td>
<table align="center" id="tbl" border="0" style="display:<%=tb1%>">
<tr>
	<th>仓库名称</th>
	<th><input type="checkbox" onClick="checkAll(this,'depot')">选择</th>
</tr>
<%str = "select * from t_user where username='"&request.QueryString("username")&"'"
  set rs_str = server.CreateObject("adodb.recordset")
  rs_str.open str,conn,1,1
  sql = "select * from t_depot"
  set rs = server.CreateObject("adodb.recordset")
  rs.Open sql, conn, 1, 1
  For i = 1 To rs.recordcount
    if (instr(rs_str("depotname"),rs("depotname")) <> 0) then
	  Response.Write "<tr><td align=""center"">"&rs("depotname")&"</td><td align=""center""><input type=""checkbox"" name=""depot"" value="""&rs("depotname")&""" checked></td></tr>"
	else
      Response.Write "<tr><td align=""center"">"&rs("depotname")&"</td><td align=""center""><input type=""checkbox"" name=""depot"" value="""&rs("depotname")&"""></td></tr>"
	end if
  rs.movenext
  next
  close_rs(rs)
%>
</table>
</td><td>

</td>
<td>

</td>
</tr></table>
<div align="center"><input type="submit" value=" 保存 "   onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" class="button" /></div></form>
<%
close_rs(rs_str)
endconnection
end if%>
<div>
</body>
</html>
