<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>选择相关单据</title>
</head>

<body>
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<form name="form1" method="post" action="selectbill.asp?type=<%=request.QueryString("type")%>">
<table align="center">
<tr>
      <td width="50">从日期：</td>
      <td width="150"><input type="text" name="date1" size="16" value=<%If Request("date1") = "" Then
                                                              Response.Write Year(Date()) & "-" & Month(Date()) & "-1"
                                                            Else
                                                              Response.Write Request("date1")
                                                            End If%>><%showdate("date1")%></label></td>
      <td width="50">到日期：</td>
      <td width="150"><input type="text" name="date2" size="16" value=<%If Request("date2") = "" Then
                                                              Response.Write Date()
                                                            Else
                                                              Response.Write Request("date2")
                                                            End If%>><%showdate("date2")%></td>
      <td rowspan="2"><input type="submit" value=" 查 找 "  class="button"></td>
</tr>
<tr>
      <td width="50"><%if request.QueryString("type")="KP" then
	                     Response.Write("供应商：")
					   else
					     Response.Write("客 户：")
					   end if%></td>
      <td colspan="3"><input type="text" name="custname" id="cust" size="45" value=<%=Request.Form("custname")%> ><a href="#SelectDate" onClick="JavaScript:window.open ('../common/selectcust.asp', 'selectcust', 'height=600, width=800,top=100,left=150, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
</tr>
</table>
</form>
<%
if Request.Form("date1") <> "" then
  s_date1 = " and adddate>='" & Request.Form("date1") & "'"
else
  s_date1 = " and adddate>='" & s_date1 & "'"
end if
if Request.Form("date2") <> "" then
  s_date2 = " and adddate<='" & Request.Form("date2") & "'"
else
  s_date2 = " and adddate<='" & s_date2 & "'"
end if
if Request.Form("custname") <> "" then
  s_cust = " and custname like '%" & Request.Form("custname") & "%'"
else
  s_cust = ""
end if
if Request.QueryString("type") = "KP" then
  s_type = "采购入库"
else
  s_type = "销售出库"
end if
sql = "select * from (select s1.billcode,s1.custname,adddate,s1.tmon as [money],isnull(s2.tmon,0) as invoice,case when s2.tmon is null then s1.tmon else s1.tmon-s2.tmon end as w from ((select billcode,custname,sum(money) as tmon,adddate from s_Billdetail where billtype = '" & s_type & "'"& s_date1 & s_date2 & s_cust & " group by billcode,custname,adddate) as s1 left join (select sum(money) as tmon,billcode from t_invoice group by billcode) as s2 on s2.billcode = s1.billcode)) as a2 where w > 0"
'response.write(sql)
call showpage(sql,"selectinvoice",9)

%>
</body>
</html>
