<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>收入与支出单据</title>
</head>

<body>
<%if Request.QueryString("add") = "true" then%>
<%
if Request.QueryString("type") = "SR" then
  call CheckAuthority("strAddSR")
else
  call CheckAuthority("strAddZC")
end if
%>
<form name="form1" action="../action/add_cashbank.asp?add=true&type=<%=request.QueryString("type")%>" method="post">
<%
today = Now()
tdate = Year(today) & "-" & Right("0" & Month(today), 2) & "-" & Right("0" & Day(today), 2)
sql = "select * from t_cashbank where billcode like '"&request.QueryString("type")&"-"&tdate&"%' order by billcode desc"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
If rs.recordcount = 0 Then
    s_billcode = request.QueryString("type")&"-"&tdate&"-0001"
Else
    s_temp = rs("billcode")
    s_temp = Right(s_temp, 4) + 1
    s_billcode = request.QueryString("type")&"-"&tdate&"-"&Right("000"&s_temp, 4)
End If
Response.Write "<div align=""center"" class=""STYLE1"">"
if Request.QueryString("type") = "SR" then
  Response.Write "其他收入"
else
  Response.Write "其他支出"
end if
Response.Write "<br>"
Response.Write s_billcode
Response.Write "</div>"
Response.Write "<INPUT type=hidden name=""billcode"" value="&s_billcode&">"
%>
<br>
<table id="tbl" width="600" align="center">
<tr>
  <td align="right" width="15%">制单日期:</td>
  <td align="left" width="35%"><input type="text" name="date" id="date" size="16" value="<%=formatdate(date)%>"><%showdate("date")%></td>
  <td align="right" width="15%">帐&nbsp;&nbsp;&nbsp;&nbsp;户:</td>
  <td align="left" width="35%"><select name="account">
      <%
	  sql_account = "select * from t_account"
	  Set rs_account = server.CreateObject("adodb.recordset")
	  rs_account.open sql_account,conn,1,1
	  Do While rs_account.EOF = False
	    Response.Write "<option value="&rs_account("account")&">"&rs_account("account")&"</option>"
	  rs_account.movenext
	  loop
	  %></select>
  </td>
</tr>
<tr>
  <td align="right" width="15%">金&nbsp;&nbsp;&nbsp;&nbsp;额:</td>
  <td align="left" width="35%"><input type="text" name="money" size="16" value="0"></td>
  <td align="right" width="15%">项&nbsp;&nbsp;&nbsp;&nbsp;目:</td>
  <td align="left" width="35%"><input type="text" name="projectname" size="20"></td>
</tr>
<tr>
  <td align="right" width="15%">经&nbsp;办&nbsp;人:</td>
  <td><select name="user"><% sql = "select * from t_Employee"
                             Set a = conn.Execute(sql)
                             Do While a.EOF = False
                              s_name = a("name")
							  Response.Write "<option value="&s_name&">"&s_name&"</option>"
                              a.movenext
                             Loop%></select></td>
  <td align="right" width="15%">原始单号:</td>
  <td><input type="text" name="oldbill" size="20"></td>
</tr>
<tr>
  <td align="right" width="15%">备&nbsp;&nbsp;&nbsp;&nbsp;注:</td>
  <td colspan="3"><input type="text" name="remark" size="62"></td>
</tr>
</table>
<div align="center">
<input type="submit" value=" 保 存 " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" class="button">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="reset" value=" 重 置 " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button">
</div>
</form>
<%end if%>


<%if Request.QueryString("add") = "false" then%>
<%
if Request.QueryString("type") = "SR" then
  power = Authority("strEditSR")
else
  power = Authority("strEditZC")
end if
%>
<form name="form1" action="../action/add_cashbank.asp?add=false&type=<%=request.QueryString("type")%>" method="post">
<%
    sql = "select * from t_cashbank where billcode = '"& Request.QueryString("billcode") &"'"
	Set rs = server.CreateObject("adodb.recordset")
	rs.open sql,conn,1,1%>
    <div align="center" class="STYLE1">
    <%if Request.QueryString("type") = "SR" then
	     Response.Write "其他收入<br>"&rs("billcode")
	  else
	     Response.Write "其他支出<br>"&rs("billcode")
	  end if
	  Response.Write "<INPUT type=hidden name=""billcode"" value="&rs("billcode")&">"
	  %>
    </div>
<br>
<table id="tbl" width="600" align="center">
<tr>
  <td align="right" width="15%">制单日期:</td>
  <td align="left" width="35%"><input type="text" name="date" id="date" size="16" value="<%=rs("adddate")%>"><%showdate("date")%></td>
  <td align="right" width="15%">帐&nbsp;&nbsp;&nbsp;&nbsp;户:</td>
  <td align="left" width="35%"><select name="account">
      <%
	  sql_account = "select * from t_account"
	  Set rs_account = server.CreateObject("adodb.recordset")
	  rs_account.open sql_account,conn,1,1
	  Do While rs_account.EOF = False
	    if rs("account") = rs_account("account") then
	    Response.Write "<option value="&rs_account("account")&" selected>"&rs_account("account")&"</option>"
		else
		Response.Write "<option value="&rs_account("account")&">"&rs_account("account")&"</option>"
		end if
	  rs_account.movenext
	  loop
	  close_rs(rs_account)
	  %></select>
  </td>
</tr>
<tr>
  <td align="right" width="15%">金&nbsp;&nbsp;&nbsp;&nbsp;额:</td>
  <td align="left" width="35%"><input type="text" name="money" size="16" value="<%=rs("money")%>"></td>
  <td align="right" width="15%">项&nbsp;&nbsp;&nbsp;&nbsp;目:</td>
  <td align="left" width="35%"><input type="text" name="projectname" size="20" value="<%=rs("projectname")%>"></td>
</tr>
<tr>
  <td align="right" width="15%">经&nbsp;办&nbsp;人:</td>
  <td><select name="user"><% sql = "select * from t_Employee"
                             Set a = conn.Execute(sql)
                             Do While a.EOF = False
                              s_name = a("name")
							  if rs("user") = s_name then
                              Response.Write "<option value="&s_name&" selected>"&s_name&"</option>"
							  else
							  Response.Write "<option value="&s_name&">"&s_name&"</option>"
							  end if
                              a.movenext
                             Loop
							 close_rs(a)%></select></td>
  <td align="right" width="15%">原始单号:</td>
  <td><input type="text" name="oldbill" size="20" value="<%=rs("oldbill")%>"></td>
</tr>
<tr>
  <td align="right" width="15%">备&nbsp;&nbsp;&nbsp;&nbsp;注:</td>
  <td colspan="3"><input type="text" name="remark" size="62" value="<%=rs("remark")%>"></td>
</tr>
</table>
<%if power = "True" then%>
<div align="center">
<input type="submit" value=" 保 存 " class="button">
<input type="reset" value=" 重 置 " class="button">
</div>
<%end if%>
</form>
<%
close_rs(rs)
endconnection
end if%>
</body>
</html>
