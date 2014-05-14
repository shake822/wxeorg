<!-- #include file="../inc/conn.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script language=javascript>
function doPrint(billcode) { 
window.open ('../action/print.asp?billcode='+billcode, 'newwindow', 'height=600, width=800,toolbar=no,menubar=yes, scrollbars=yes, resizable=no,location=no, status=yes,top=80,left=200')
}
</script>
<title>单据详情</title>
</head>

<body>
<%
if request("billcode") <> "" then
sql = "select * from t_bill where billcode='"&request("billcode")&"'"
else
sql = "select * from t_bill where billcode='"&request.QueryString("billcode")&"'"
end if
Set rs_bill = server.CreateObject("adodb.recordset")
rs_bill.Open sql, conn, 1, 1
%>
<!--采购订货-->
<%if rs_bill("billtype")="采购订货" then%>
<br><div align="center"><span class="style1">采购订单</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="0" align="center">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">供&nbsp;应&nbsp;商：</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right" width="70">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
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
<table id="tbl" align="center" width="780">
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
<tr align="center">
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
<%end if%>
<!--销售订货-->
<%if rs_bill("billtype")="销售订货" then%>
<br><div align="center"><span class="style1">销售订单</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
  <td align="right" width="70">制单日期：</td>
  <td width="320">&nbsp;<%=rs_bill("adddate")%></td>
  <td align="right" width="70">客&nbsp;&nbsp;&nbsp;&nbsp;户：</td>
  <td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right" width="70">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
	<td width="320">&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">备&nbsp;&nbsp;注：</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">经&nbsp;办&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>商品编码</td>
	<td id="td" width=15%>商品名称</td>
	<td id="td" width=10%>商品规格</td>
	<td id="td" width=7%>单位</td>
	<td id="td" width=10%>单价</td>
	<td id="td" width=10%>数量</td>
	<td id="td" width=10%>金额</td>
	<td id="td" width=20%>备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
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
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--采购入库-->
<%if rs_bill("billtype")="采购入库" then%>
<br><div align="center"><span class="style1">采购入库单</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="0" align="center">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">供&nbsp;应&nbsp;商：</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">经&nbsp;办&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>商品编码</td>
	<td id="td" width=15%>商品名称</td>
	<td id="td" width=10%>商品规格</td>
	<td id="td" width=7%>单位</td>
	<td id="td" width=10%>单价</td>
	<td id="td" width=10%>数量</td>
	<td id="td" width=10%>金额</td>
	<td id="td" width=20%>备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
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
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--销售出库-->
<%if rs_bill("billtype")="销售出库" then%>
<br><div align="center"><span class="style1">销售出库单</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">客&nbsp;&nbsp;&nbsp;&nbsp;户：</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">经&nbsp;办&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>商品编码</td>
	<td id="td" width=15%>商品名称</td>
	<td id="td" width=10%>商品规格</td>
	<td id="td" width=7%>单位</td>
	<td id="td" width=10%>单价</td>
	<td id="td" width=10%>数量</td>
	<td id="td" width=10%>金额</td>
	<td id="td" width=20%>备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
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
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--其他入库-->
<%if rs_bill("billtype")="其他入库" then%>
<br><div align="center"><span class="style1">入库单</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">供&nbsp;应&nbsp;商：</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">经&nbsp;办&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>商品编码</td>
	<td id="td" width=15%>商品名称</td>
	<td id="td" width=10%>商品规格</td>
	<td id="td" width=7%>单位</td>
	<td id="td" width=10%>单价</td>
	<td id="td" width=10%>数量</td>
	<td id="td" width=10%>金额</td>
	<td id="td" width=20%>备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
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
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--其他出库-->
<%if rs_bill("billtype")="其他出库" then%>
<br><div align="center"><span class="style1">出库单</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">客&nbsp;&nbsp;&nbsp;&nbsp;户：</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right" width="70">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
	<td width="320">&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">经&nbsp;办&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>商品编码</td>
	<td id="td" width=15%>商品名称</td>
	<td id="td" width=10%>商品规格</td>
	<td id="td" width=7%>单位</td>
	<td id="td" width=10%>单价</td>
	<td id="td" width=10%>数量</td>
	<td id="td" width=10%>金额</td>
	<td id="td" width=20%>备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
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
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--调拨单-->
<%if rs_bill("billtype")="仓库调拨" then%>
<br><div align="center"><span class="style1">调拨单</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">调&nbsp;出&nbsp;仓：</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">经&nbsp;办&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>商品编码</td>
	<td id="td" width=15%>商品名称</td>
	<td id="td" width=10%>商品规格</td>
	<td id="td" width=7%>单位</td>
	<td id="td" width=10%>单价</td>
	<td id="td" width=10%>数量</td>
	<td id="td" width=10%>金额</td>
	<td id="td" width=20%>备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
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
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--盘点单-->
<%if rs_bill("billtype")="库存盘点" then%>
<br><div align="center"><span class="style1">盘点单</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">&nbsp;</td>
	<td width="320">&nbsp;</td>
</tr>
<tr>
	<td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">经&nbsp;办&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>商品编码</td>
	<td id="td" width=15%>商品名称</td>
	<td id="td" width=10%>商品规格</td>
	<td id="td" width=7%>单位</td>
	<td id="td" width=10%>单价</td>
	<td id="td" width=10%>数量</td>
	<td id="td" width=10%>金额</td>
	<td id="td" width=20%>备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
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
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--采购退货-->
<%if rs_bill("billtype")="采购退货" then%>
<br><div align="center"><span class="style1">采购退货单</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">供&nbsp;应&nbsp;商：</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">经&nbsp;办&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>商品编码</td>
	<td id="td" width=15%>商品名称</td>
	<td id="td" width=10%>商品规格</td>
	<td id="td" width=7%>单位</td>
	<td id="td" width=10%>单价</td>
	<td id="td" width=10%>数量</td>
	<td id="td" width=10%>金额</td>
	<td id="td" width=20%>备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
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
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<!--销售退货-->
<%if rs_bill("billtype")="销售退货" then%>
<br><div align="center"><span class="style1">销售退货单</span></div>
<div align="center"><span class="style1"><%=request("billcode")%></span></div><br>
<table style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320">&nbsp;<%=rs_bill("adddate")%></td>
	<td align="right" width="70">客&nbsp;&nbsp;&nbsp;&nbsp;户：</td>
	<td width="320">&nbsp;<%=rs_bill("custname")%></td>
</tr>
<tr>
	<td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
	<td>&nbsp;<%=rs_bill("depotname")%></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("maker")%></td>
</tr>
<tr>
	<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
	<td>&nbsp;<%=rs_bill("memo")%></td>
	<td align="right">经&nbsp;办&nbsp;人：</td>
	<td>&nbsp;<%=rs_bill("username")%></td>
</tr>
</tbody>
</table>
<table id="tbl" align="center" width="780">
<tr align="center">
	<td id="td" width=3%>&nbsp;</td>
	<td id="td" width=10%>商品编码</td>
	<td id="td" width=15%>商品名称</td>
	<td id="td" width=10%>商品规格</td>
	<td id="td" width=7%>单位</td>
	<td id="td" width=10%>单价</td>
	<td id="td" width=10%>数量</td>
	<td id="td" width=10%>金额</td>
	<td id="td" width=20%>备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
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
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4"></td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td></td>
</tr>
</table>
<%end if%>
<div align="center">
  <input name="button" type="button" class="button but_mar" onClick="doPrint('<%=rs_bill("billcode")%>')" value=" 打 印 ">
</div>
<%
close_rs(rs_bill)
close_rs(rs_detail)
close_rs(rs_count)
endconnection
%>
</body>
</html>
