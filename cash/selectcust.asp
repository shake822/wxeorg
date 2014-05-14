<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>选择往来单位</title>
</head>

<body topmargin="0">
<div align="center">
<table><form name="form1" method="post" action="selectcust.asp?type=<%=request.QueryString("type")%>">
<tr>
  <td align="right">往来单位名称</td>
  <td><input type="text" name="custname" size="16" value="<%=request.Form("custname")%>"></td>
  <td align="right">往来单位分类</td>
  <td><input type="text" name="nodename" size="16" value="<%=request.Form("nodename")%>"><input type="hidden" name="typecode" value="<%=request.Form("typecode")%>"><a href="#" onClick="window.open ('../common/tree.asp?type=cust', 'newwindow1', 'height=400, width=200,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
  <td><input type="submit" name="select" value=" 查 询 " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button"></td>
</tr></form>
</table>
<%
sql_cust = "select custname from t_user where username='"&request.cookies("username")&"'"
Set rs_cust = conn.Execute(sql_cust)
arr = split(rs_cust("custname"),",")
temp_cust = ""
if ubound(arr) <> -1 then
  for i = lbound(arr) to ubound(arr)-1
    temp_cust = temp_cust & "'" & arr(i) & "',"
  next
end if

if Request.Form("custname") = "" then
	sCustname = " "
else
	sCustname = " and custname like '%" & Request.Form("custname") & "%'"
end if

if Request.Form("typecode") = "" then
	sTypecode = ""
else
	sTypecode = " and code like '" & Request.Form("typecode") & "%'"
end if

if Request.QueryString("type") = "FK" then
	sql = "select * from t_custom where 1=1 "&sCustname&" "&sTypecode&" order by CustID desc"
else
	sql = "select * from t_custom where 1=1 "&sCustname&" "&sTypecode&"  order by CustID desc"
end if

call showpage(sql,"cashselectcust",8)
%>

</div>
</body>
</html>