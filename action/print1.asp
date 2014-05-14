<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<META http-equiv=Pragma content=no-cache>
<style type="text/css">
<!--
.STYLE1 {
	font-size: large;
	font-weight: bold;
}
#tblprint{
border-collapse:collapse;
table-layout:fixed;
border:solid 1px #000000;
}
#tblprint td{
border-collapse:collapse;
table-layout:fixed;
border:solid 1px #000000;
}
-->
</style>
<title>单据打印</title>
</head>

<body>
<!--startprint-->
<%
Function SetSmallInt(DataValue)
	if (DataValue<1) and (DataValue>0) then
	  if left(DataValue,1)<>"0" then
	    DataValue="0"&DataValue   
	  end if
	end if
	SetSmallInt = DataValue
End Function

sql_company = "select * from t_company"
Set rs_company = server.CreateObject("adodb.recordset")
rs_company.Open sql_company, conn, 1, 1
if request("billcode") <> "" then
sql = "select * from t_bill where billcode='"&request("billcode")&"'"
else
sql = "select * from t_bill where billcode='"&request.QueryString("billcode")&"'"
end if
Set rs_bill = server.CreateObject("adodb.recordset")
rs_bill.Open sql, conn, 1, 1
%>
<div align="center"><span class="style1"><%=rs_company("company")%></span></div>
<!--采购订货-->
<%if rs_bill("billtype")="采购订货" then%>
<br><div align="center"><span class="style1">采购订单</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">制单日期：&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">单据号码：&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">供&nbsp;应&nbsp;商：&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">仓&nbsp;&nbsp;&nbsp;&nbsp;库：&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">制&nbsp;单&nbsp;人：&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">经&nbsp;办&nbsp;人：&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品编码</td>
<td width=15% bgcolor="#FFFFFF" id="td">商品名称</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品规格</td>
<td width=7% bgcolor="#FFFFFF" id="td">单位</td>
<td width=10% bgcolor="#FFFFFF" id="td">单价</td>
<td width=10% bgcolor="#FFFFFF" id="td">数量</td>
<td width=10% bgcolor="#FFFFFF" id="td">金额</td>
<td width=20% bgcolor="#FFFFFF" id="td">备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" bgcolor="#FFFFFF" id="id">合计</td>
	<td colspan="4" bgcolor="#FFFFFF" id="td">&nbsp;</td>
	<td bgcolor="#FFFFFF" id="td"><%=rs_count("num")%></td>
	<td bgcolor="#FFFFFF" id="td"><%=rs_count("mon")%></td>
	<td bgcolor="#FFFFFF">&nbsp;</td>
</tr>
</table>
<%end if%>
<!--销售订货-->
<%if rs_bill("billtype")="销售订货" then%>
<br><div align="center"><span class="style1">销售订单</span></div><br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">制单日期：&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">单据号码：&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">客&nbsp;&nbsp;&nbsp;&nbsp;户：&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">仓&nbsp;&nbsp;&nbsp;&nbsp;库：&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">制&nbsp;单&nbsp;人：&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">经&nbsp;办&nbsp;人：&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" >商品编码</td>
<td width=15% bgcolor="#FFFFFF" >商品名称</td>
<td width=10% bgcolor="#FFFFFF" >商品规格</td>
<td width=7% bgcolor="#FFFFFF" >单位</td>
<td width=10% bgcolor="#FFFFFF" >单价</td>
<td width=10% bgcolor="#FFFFFF" >数量</td>
<td width=10% bgcolor="#FFFFFF" >金额</td>
<td width=20% bgcolor="#FFFFFF" >备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" ><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" >&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" >&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" >&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" >&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" >&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF"><td colspan="2" id="id">合计</td><td id="td" colspan="4">&nbsp;</td><td id="td"><%=rs_count("num")%></td><td id="td"><%=rs_count("mon")%></td><td>&nbsp;</td></tr>
</table>
<%end if%>
<!--采购入库-->
<%if rs_bill("billtype")="采购入库" then%>
<br><div align="center"><span class="style1">采购入库单</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">制单日期：&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">单据号码：&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">供&nbsp;应&nbsp;商：&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">仓&nbsp;&nbsp;&nbsp;&nbsp;库：&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">制&nbsp;单&nbsp;人：&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">经&nbsp;办&nbsp;人：&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品编码</td>
<td width=15% bgcolor="#FFFFFF" id="td">商品名称</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品规格</td>
<td width=7% bgcolor="#FFFFFF" id="td">单位</td>
<td width=10% bgcolor="#FFFFFF" id="td">单价</td>
<td width=10% bgcolor="#FFFFFF" id="td">数量</td>
<td width=10% bgcolor="#FFFFFF" id="td">金额</td>
<td width=20% bgcolor="#FFFFFF" id="td">备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" bgcolor="#FFFFFF" id="id">合计</td>
	<td colspan="4" bgcolor="#FFFFFF" id="td">&nbsp;</td>
	<td bgcolor="#FFFFFF" id="td"><%=rs_count("num")%></td>
	<td bgcolor="#FFFFFF" id="td"><%=rs_count("mon")%></td>
	<td bgcolor="#FFFFFF">&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>审核：</td>
  <td>收货人：</td>
</tr>
</table>
<%end if%>
<!--销售出库-->
<%if rs_bill("billtype")="销售出库" then%>
<br><div align="center"><span class="style1">销售出库单</span></div><br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">制单日期：>&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">单据号码：&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">客&nbsp;&nbsp;&nbsp;&nbsp;户：&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">仓&nbsp;&nbsp;&nbsp;&nbsp;库：&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">制&nbsp;单&nbsp;人：&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">经&nbsp;办&nbsp;人：&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品编码</td>
<td width=15% bgcolor="#FFFFFF" id="td">商品名称</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品规格</td>
<td width=7% bgcolor="#FFFFFF" id="td">单位</td>
<td width=10% bgcolor="#FFFFFF" id="td">单价</td>
<td width=10% bgcolor="#FFFFFF" id="td">数量</td>
<td width=10% bgcolor="#FFFFFF" id="td">金额</td>
<td width=20% bgcolor="#FFFFFF" id="td">备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>审核：</td>
  <td>送货人：</td>
  <td>收货人：</td>
</tr>
</table>
<%end if%>
<!--其他入库-->
<%if rs_bill("billtype")="其他入库" then%>
<br><div align="center"><span class="style1">入库单</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">制单日期：&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">单据号码：&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">供&nbsp;应&nbsp;商：&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">仓&nbsp;&nbsp;&nbsp;&nbsp;库：&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">制&nbsp;单&nbsp;人：&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">经&nbsp;办&nbsp;人：&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品编码</td>
<td width=15% bgcolor="#FFFFFF" id="td">商品名称</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品规格</td>
<td width=7% bgcolor="#FFFFFF" id="td">单位</td>
<td width=10% bgcolor="#FFFFFF" id="td">单价</td>
<td width=10% bgcolor="#FFFFFF" id="td">数量</td>
<td width=10% bgcolor="#FFFFFF" id="td">金额</td>
<td width=20% bgcolor="#FFFFFF" id="td">备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>审核：</td>
  <td>收货人：</td>
</tr>
</table>
<%end if%>
<!--其他出库-->
<%if rs_bill("billtype")="其他出库" then%>
<br><div align="center"><span class="style1">出库单</span></div>
<br>
<table style="font-size:12px" width="80%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">制单日期：&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">单据号码：&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">客&nbsp;&nbsp;&nbsp;&nbsp;户：&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">仓&nbsp;&nbsp;&nbsp;&nbsp;库：&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">制&nbsp;单&nbsp;人：&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">经&nbsp;办&nbsp;人：&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品编码</td>
<td width=15% bgcolor="#FFFFFF" id="td">商品名称</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品规格</td>
<td width=7% bgcolor="#FFFFFF" id="td">单位</td>
<td width=10% bgcolor="#FFFFFF" id="td">单价</td>
<td width=10% bgcolor="#FFFFFF" id="td">数量</td>
<td width=10% bgcolor="#FFFFFF" id="td">金额</td>
<td width=20% bgcolor="#FFFFFF" id="td">备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>审核：</td>
  <td>收货人：</td>
</tr>
</table>
<%end if%>
<!--调拨单-->
<%if rs_bill("billtype")="仓库调拨" then%>
<br><div align="center"><span class="style1">调拨单</span></div>
<br>
<table style="font-size:12px" width="80%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">制单日期：&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">单据号码：&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">调&nbsp;入&nbsp;仓：&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">调&nbsp;出&nbsp;仓：&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">制&nbsp;单&nbsp;人：&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">经&nbsp;办&nbsp;人：&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品编码</td>
<td width=15% bgcolor="#FFFFFF" id="td">商品名称</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品规格</td>
<td width=7% bgcolor="#FFFFFF" id="td">单位</td>
<td width=10% bgcolor="#FFFFFF" id="td">单价</td>
<td width=10% bgcolor="#FFFFFF" id="td">数量</td>
<td width=10% bgcolor="#FFFFFF" id="td">金额</td>
<td width=20% bgcolor="#FFFFFF" id="td">备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<%end if%>
<!--盘点单-->
<%if rs_bill("billtype")="库存盘点" then%>
<br><div align="center"><span class="style1">盘点单</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">制单日期：&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">单据号码：&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">&nbsp;&nbsp;</td>
 </tr>
 <tr>
   <td align="left">仓&nbsp;&nbsp;&nbsp;&nbsp;库：&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">制&nbsp;单&nbsp;人：&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">经&nbsp;办&nbsp;人：&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品编码</td>
<td width=15% bgcolor="#FFFFFF" id="td">商品名称</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品规格</td>
<td width=7% bgcolor="#FFFFFF" id="td">单位</td>
<td width=10% bgcolor="#FFFFFF" id="td">单价</td>
<td width=10% bgcolor="#FFFFFF" id="td">数量</td>
<td width=10% bgcolor="#FFFFFF" id="td">金额</td>
<td width=20% bgcolor="#FFFFFF" id="td">备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<%end if%>
<!--采购退货-->
<%if rs_bill("billtype")="采购退货" then%>
<br><div align="center"><span class="style1">采购退货单</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">制单日期：&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">单据号码：&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">供&nbsp;应&nbsp;商：&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">仓&nbsp;&nbsp;&nbsp;&nbsp;库：&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">制&nbsp;单&nbsp;人：&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">经&nbsp;办&nbsp;人：&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品编码</td>
<td width=15% bgcolor="#FFFFFF" id="td">商品名称</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品规格</td>
<td width=7% bgcolor="#FFFFFF" id="td">单位</td>
<td width=10% bgcolor="#FFFFFF" id="td">单价</td>
<td width=10% bgcolor="#FFFFFF" id="td">数量</td>
<td width=10% bgcolor="#FFFFFF" id="td">金额</td>
<td width=20% bgcolor="#FFFFFF" id="td">备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>审核：</td>
  <td>收货人：</td>
</tr>
</table>
<%end if%>
<!--销售退货-->
<%if rs_bill("billtype")="销售退货" then%>
<br><div align="center"><span class="style1">销售退货单</span></div>
<br>
<table style="font-size:12px" width="100%" border="0" align="center">
<tbody>
 <tr>
   <td align="left">制单日期：&nbsp;<%=rs_bill("adddate")%></td>
   <td align="left">单据号码：>&nbsp;<%=rs_bill("billcode")%></td>
   <td align="left">客&nbsp;&nbsp;&nbsp;&nbsp;户：&nbsp;<%=rs_bill("custname")%></td>
 </tr>
 <tr>
   <td align="left">仓&nbsp;&nbsp;&nbsp;&nbsp;库：&nbsp;<%=rs_bill("depotname")%></td>
   <td align="left">制&nbsp;单&nbsp;人：&nbsp;<%=rs_bill("maker")%></td>
   <td align="left">经&nbsp;办&nbsp;人：&nbsp;<%=rs_bill("username")%></td>
 </tr>
</tbody></table>
<table id="tblprint" width=100% align="center" cellspacing="0" border="1" border-collapse:collapse;>
<tr align="center"><td width=3% bgcolor="#FFFFFF" id="td">&nbsp;</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品编码</td>
<td width=15% bgcolor="#FFFFFF" id="td">商品名称</td>
<td width=10% bgcolor="#FFFFFF" id="td">商品规格</td>
<td width=7% bgcolor="#FFFFFF" id="td">单位</td>
<td width=10% bgcolor="#FFFFFF" id="td">单价</td>
<td width=10% bgcolor="#FFFFFF" id="td">数量</td>
<td width=10% bgcolor="#FFFFFF" id="td">金额</td>
<td width=20% bgcolor="#FFFFFF" id="td">备注</td>
</tr>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<tr align="center">
	<td width=3% bgcolor="#FFFFFF" id="td"><%=i%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodscode")%></td>
	<td width=15% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsname")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("goodsunit")%></td>
	<td width=7% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("units")%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("price"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("number"))%></td>
	<td width=10% bgcolor="#FFFFFF" id="td">&nbsp;<%=SetSmallInt(rs_detail("money"))%></td>
	<td width=20% bgcolor="#FFFFFF" id="td">&nbsp;<%=rs_detail("detailnote")%></td>
</tr>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
<tr align="center" bgcolor="#FFFFFF">
	<td colspan="2" id="id">合计</td>
	<td id="td" colspan="4">&nbsp;</td>
	<td id="td"><%=rs_count("num")%></td>
	<td id="td"><%=rs_count("mon")%></td>
	<td>&nbsp;</td>
</tr>
</table>
<table width=100%>
<tr>
  <td>审核：</td>
  <td>送货人：</td>
  <td>收货人：</td>
</tr>
</table>
<%end if%>
</body>
</html>
