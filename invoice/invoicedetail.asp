<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>报表</title>
</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<br>
<%
if Request.QueryString("type") = "KP" then
Response.Write "<div align=""left""><span class=""style1"">采购收票</span></div>"
else
Response.Write "<div align=""left""><span class=""style1"">销售开票</span></div>"
end if
%>
<table align="left"><tr><td>
<form name="form1" method="post" action="invoicedetail.asp?type=<%=request.QueryString("type")%>">
<table id="tbl_tittle">
<tr>
<td height="26" align="left">从&nbsp;日&nbsp;期：</td>
      <td><label>
      <input type="text" name="date1" size="16" value=<%
If Request("date1") = "" Then
    Response.Write Year(Date()) & "-" & Month(Date()) & "-1"
Else
    Response.Write Request("date1")
End If

%>><%showdate("date1")%></label></td>
      <td align="right">到&nbsp;日&nbsp;期：</td>
      <td><input type="text" name="date2" size="16" value=<%
If Request("date2") = "" Then
    Response.Write Date()
Else
    Response.Write Request("date2")
End If

%>><%showdate("date2")%></td>
<td rowspan="2"><input type="submit" value=" 查 询 " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button"></td>
</tr>
<tr>
<td align="right">相关单号：</td>
<td><input type="text" name="billcode" value="<%=request("billcode")%>" size="16"></td>
<td align="right">往来单位：</td>
<td><input type="text" name="goodsname" value="<%=request("goodsname")%>" size="16"></td>
</tr>
</table>
<hr>
</form>
<%

if Request.Form("date1") <> "" then
  s_date1 = " and adddate >= '" & Request.Form("date1") & "'"
else
  s_date1 = " and adddate >= '" & s_date1 & "'"
end if
if Request.Form("date2") <> "" then
  s_date2 = " and adddate <= '" & Request.Form("date2") & "'"
else
  s_date2 = " and adddate <= '" & s_date2 & "'"
end if
if Request.Form("billcode") <> "" then
  s_billcode = "and billcode = '" & Request.Form("billcode") & "'"
else
  s_billcode = ""
end if
if Request.Form("custname") <> "" then
	sCustname = " and custname like '%" & Request.Form("custname") & "%'"
else
	sCustname = ""
end if
if Request.QueryString("type") = "KP" then
  s_type = "采购入库"
else
  s_type = "销售出库"
end if
sql = "select * from (select s1.billcode,s1.custname,adddate,s1.tmon as [money],isnull(s2.tmon,0) as invoice,case when s2.tmon is null then s1.tmon else s1.tmon-s2.tmon end as w from ((select billcode,custname,sum(money) as tmon,adddate from s_Billdetail where billtype = '" & s_type & "'"& s_date1 & s_date2 & sCustname & s_billcode & " group by billcode,custname,adddate) as s1 left join (select sum(money) as tmon,billcode from t_invoice group by billcode) as s2 on s2.billcode = s1.billcode)) as a2"

call showpage(sql,"selectinvoice",1)
endconnection
%>
</td></tr></table>
</div>
</body>
</html>
