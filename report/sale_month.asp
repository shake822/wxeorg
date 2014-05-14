<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strMonthSale") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>月销售统计</title>
<link rel="stylesheet" href="../style.css" type="text/css">
<script language="JavaScript" src="../js/jquery.js"></script>
<script language="javascript" type="text/javascript">
$(document).ready(function() {
	$("#nodename").change(function() {
		if ($("#nodename").val()==""){
		$("#typecode").attr("value","");
		}
	});
});
</script>
</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<br>
<div align="left" class="STYLE1">月销售统计</div>
<%
if Request.Form("year") = "" then
  s_year = year(date())
else
  s_year = Request.Form("year")
end if
%>
<table align="left"><tr><td>
<form name="form1" method="post" action="sale_month.asp">
<table border="0" >
<tr>
  <td>年&nbsp;&nbsp;&nbsp;&nbsp;份:</td>
  <td><input type="text" name="year" size="16" value="<%=s_year%>" /></td>
  <td>货品分类:</td>
  <td><input type="text" name="nodename" id="nodename" size="16" value=<%=Request.Form("nodename")%>><a href="#SelectDate" onClick="window.open ('../common/tree.asp?type=goods', 'newwindow', 'left=600,top=200,height=400, width=200,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a><input type="hidden" name="typecode" id="typecode" value="<%=request.Form("typecode")%>" /></td>
  <td rowspan="2"><input type="submit" name="Submit" value=" 查 询 " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" /></td>
</tr>
<tr>
  <td>货品编码:</td>
  <td><input type="text" name="goodscode" size="16" value="<%=request.Form("goodscode")%>" /></td>
  <td>货品名称:</td>
  <td><input type="text" name="goodsname" size="16" value="<%=request.Form("goodsname")%>" /></td>
</tr>
</table>
<hr>
</form>

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
sCustname = " and custname in ("& temp_cust &"'a')"

sql_depot = "select depotname from t_user where username='"&request.cookies("username")&"'"
Set rs_depot = conn.Execute(sql_depot)
arr = split(rs_depot("depotname"),",")
if ubound(arr) <> -1 then
  for i = lbound(arr) to ubound(arr)-1
	s_depotpower = s_depotpower & "'" & arr(i) & "',"
  next
end if
sDepotname = " and depotname in ("& s_depotpower &"'a')"

if Request.Form("typecode") = "" then
  s_type = ""
else
  s_type = " and code like '" & request.Form("typecode")  & "'"
end if

if request.Form("goodscode") = "" then
  s_goodscode = ""
else
  s_goodscode = " and goodscode like '" & request.Form("goodscode") & "'"
end if

if Request.Form("goodsname") = "" then
  s_goodsname = ""
else
  s_goodsname = " and goodsname like '" & request.Form("goodsname") & "'"
end if

sql ="select goodscode,goodsname,sum(case month(adddate) when 1 then flag*number*-1 else 0 end ) as t1,sum(case month(adddate) when 2 then flag*number*-1 else 0 end) as t2,sum(case month(adddate) when 3 then flag*number*-1 else 0 end) as t3,sum(case month(adddate) when 4 then flag*number*-1 else 0 end) as t4,sum(case month(adddate) when 5 then flag*number*-1 else 0 end) as t5,sum(case month(adddate) when 6 then flag*number*-1 else 0 end) as t6,sum(case month(adddate) when 7 then flag*number*-1 else 0 end) as t7,sum(case month(adddate) when 8 then flag*number*-1 else 0 end) as t8,sum(case month(adddate) when 9 then flag*number*-1 else 0 end) as t9,sum(case month(adddate) when 10 then flag*number*-1 else 0 end) as t10,sum(case month(adddate) when 11 then flag*number*-1 else 0 end) as t11,sum(case month(adddate) when 12 then flag*number*-1 else 0 end) as t12 from s_billdetail where billtype like '销售%' and year(adddate)="& s_year & sDepotname &s_goodstype&s_type&s_goodscode&s_goodsname&" group by goodscode,goodsname"
call showpage(sql,"sale_month",5)
endconnection
%>
</td></tr></table>
</div>
</body>
</html>
