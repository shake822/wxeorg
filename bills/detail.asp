<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<%
if instr(Request.QueryString("billcode"),"CD") <> 0 then
	CheckAuthority("BrowseCD")
end if
if instr(Request.QueryString("billcode"),"CG") <> 0 then
	CheckAuthority("BrowseCG")
end if
if instr(Request.QueryString("billcode"),"CT") <> 0 then
	CheckAuthority("BrowseCT")
end if
if instr(Request.QueryString("billcode"),"XD") <> 0 then
	CheckAuthority("BrowseXD")
end if
if instr(Request.QueryString("billcode"),"XS") <> 0 then
	CheckAuthority("BrowseXS")
end if
if instr(Request.QueryString("billcode"),"XT") <> 0 then
	CheckAuthority("BrowseXT")
end if
if instr(Request.QueryString("billcode"),"RK") <> 0 then
	CheckAuthority("BrowseIn")
end if
if instr(Request.QueryString("billcode"),"CK") <> 0 then
	CheckAuthority("BrowseOut")
end if
if instr(Request.QueryString("billcode"),"DB") <> 0 then
	CheckAuthority("BrowseDB")
end if
if instr(Request.QueryString("billcode"),"PD") <> 0 then
	CheckAuthority("BrowsePD")
end if
if instr(Request.QueryString("billcode"),"LL") <> 0 then
	CheckAuthority("BrowseLL")
end if
if instr(Request.QueryString("billcode"),"TL") <> 0 then
	CheckAuthority("BrowseTL")
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script language=javascript>
function openwin(URL,x,y){
var URL;
var x1=window.screen.width;
var y1=window.screen.height;
x2=(x1-x)/2;
y2=(y1-y)/2;
window.open(URL,'','top='+y2+',left='+x2+',width='+x+',height='+y+',status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes')
}

</script>
<title>单据详情</title>
</head>

<body style="background:#FFFFFF">
<%
if request("billcode") <> "" then
sql = "select * from t_bill where billcode='"&request("billcode")&"'"
else
sql = "select * from t_bill where billcode='"&request.QueryString("billcode")&"'"
end if
Set rs_bill = server.CreateObject("adodb.recordset")
rs_bill.Open sql, conn, 1, 1
sql = "select * from dict_bill where name = '"& rs_bill("billtype") &"' "
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
%>
<br><div align="center" style=" margin-left:250px"><span class="style1"><%=rs("caption")%></span></div>
<div align="center" style=" margin-left:250px"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px; margin-left:170px" width="780" border="0" align="center">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70"><%=rs("f_dw")%>：</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right" width="70"><%=rs("f_ck")%>：</td>
	<td width="320">&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right" width="70">制&nbsp;单&nbsp;人：</td>
	<td width="320">&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right" width="70">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
	<td width="320">&nbsp;<%=rs_bill("memo")%></td>
	<td align="right" width="70">经&nbsp;办&nbsp;人：</td>
	<td width="320">&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center"  style=" margin-left:170px" width="780">
<tr align="center">
	<th width=3%>&nbsp;</th>
	<th width=10%>商品编码</th>
	<th width=15%>商品名称</th>
	<th width=10%>商品规格</th>
	<th width=7%>单位</th>
	<th width=10%>单价</th>
	<th width=10%>数量</th>
	<th width=10%>金额</th>
	<th width=20%>备注</th>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr   >
	<td id="td" width=3%><%=i%></td>
	<td id="td" width=10%><%=rs_detail("goodscode")%></td>
	<td id="td" width=15%><%=rs_detail("goodsname")%></td>
	<td id="td" width=10%><%=rs_detail("goodsunit")%></td>
	<td id="td" width=7%><%=rs_detail("units")%></td>
	<td id="td" width=10%><%=rs_detail("price")%></td>
	<td id="td" width=10%><%=rs_detail("number")%></td>
	<td id="td" width=10%><%=rs_detail("money")%></td>
	<td id="td" width=20%><%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center">
	<th colspan="2" id="id">合计</th>
	<th id="td" colspan="4"></th>
	<th id="td"><%=rs_count("num")%></th>
	<th id="td"><%=rs_count("mon")%></th>
	<th></th>
</tr>
</table>
<br>
<div align="center" style="margin-left:170px">
  <input name="button" type="button" class="button but_mar"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  onClick="doPrint('<%=rs_bill("billcode")%>')" value=" 打 印 ">
</div>
<%
close_rs(rs_bill)
close_rs(rs_detail)
close_rs(rs_count)
endconnection
%>
</body>
</html>
