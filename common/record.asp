<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>登陆日志</title>
</head>

<body>
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = Date()
%>
<form name="form1" method="post" action="record.asp">
<table align="center" border="0">
<tr>
  <td height="26" align="right">从&nbsp;日&nbsp;期：</td>
  <td><input type="text" name="date1" size="16" value=<%
														If Request("date1") = "" Then
														Response.Write Year(Date()) & "-" & Month(Date()) & "-1"
														Else
														Response.Write Request("date1")
														End If
														%>><%showdate("date1")%></td>
  <td align="right">到&nbsp;日&nbsp;期：</td>
  <td><input type="text" name="date2" size="16" value=<%
														If Request("date2") = "" Then
														Response.Write Date()
														Else
														Response.Write Request("date2")
														End If%>><%showdate("date2")%></td>
  <td><input type="submit" class="button" value="查询"></td>
</tr>
</table>
</form>
<%
If Request.Form("date1")<>"" Then
    s_date1 = Request.Form("date1")
End If
If Request.Form("date2")<>"" Then
    s_date2 = Request.Form("date2")
End If
sql = "select * from t_record where (date)<='"&s_date2&"' and (date)>='"&s_date1&"' order by date desc"
call showpage(sql,"record",1)
endconnection
%>
</body>
</html>
