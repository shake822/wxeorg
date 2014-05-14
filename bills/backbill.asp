<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
if Request.QueryString("type") = "CT" then
	call CheckAuthority("strAddCT")
end if
if Request.QueryString("type") = "XT" then
	call CheckAuthority("strAddXT")
end if%>
<html>
<head>
<script>
function check(){
	var qtyid = "";
	var stockid = "";
	var goodsnameid = "";
	var errCount = 0;
	if (document.sample.cust.value=="")
	{
		alert("请选择往来单位！");
		document.sample.cust.focus();
		errCount++;
	}
	if ($("#depot").val() == "")
	{
		alert("请选择仓库！");
		document.sample.depot.focus();
		errCount++;
	}
	if (document.getElementById("sqd").rows.length == 1)
	{
		alert("请添加货品！");
		errCount++;
	}
	$(".number").each(
		function(i)
		{
			qtyid = $(this).attr("id");
			stockid = qtyid.replace("number", "fact_num");
			goodsnameid = qtyid.replace("number", "goodsname");
			if (Number($("#"+qtyid).val())>Number($("#"+stockid).val())){
				alert($("#"+goodsnameid).val()+"订单剩余数量不足！");
				errCount++;				
			}
		}
	);
	if(errCount>0){
		return false;
	}
}
function edit_row(i)
{
openwin('../common/selectgoods.asp?depot='+document.getElementById("depot").value+'&type=<%=request.QueryString("type")%>&adddate='+document.all.date.value+'&id='+i,800,600)
}
function counttotal(){

var vTotalNumber=0;
var vTotalMoney=0;//总金额的初始值为0;
$(".money").each( 
	function(i)
	{
	var vTempValue=$(this).val();
		if(vTempValue=="")
		{
			vTempValue=0;
		}
	vTotalMoney=vTotalMoney+parseFloat(vTempValue);//计算总费用
	if (document.all.yfprice)
	{
		document.all.yfprice.value=vTotalMoney;
	}
	}
)//遍历结束
$("#total_money").val(vTotalMoney); //将总费用显示到对应文本框对象中
$(".number").each( 
	function(i)
	{
	var vTempValue=$(this).val();
		if(vTempValue=="")
		{
			vTempValue=0;
		}
	vTotalNumber=vTotalNumber+parseFloat(vTempValue);//计算总费用
	}
)//遍历结束
$("#total_number").val(vTotalNumber); //将总费用显示到对应文本框对象中
}
function count(i){
r_price=Number(document.getElementById("price"+i).value);

r_number=Number(document.getElementById("number"+i).value);
document.getElementById("money"+i).value=(r_price*r_number).toFixed(2);
document.getElementById('total_money').value=0;
document.getElementById('total_number').value=0;
counttotal();
}
function del_row(i) {	
	document.getElementById("sqd").deleteRow(i);
	$("#rowcount").val($("#rowcount").val() - 1);
	counttotal();	
}
</script>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" href="../style.css" type="text/css">
<title>退货单</title>
</head>

<BODY>
<table align="center" border="0">
<tr>
<td>
<br>
<%
sql = "select * from t_bill where billcode='"&Request.QueryString("planbillcode")&"'"
Set a = server.CreateObject("adodb.recordset")
a.Open sql, conn, 1, 1
if a("check") <> True then
	Response.Write "<script>alert('单据未审核，不允许退货')</script>"
	Response.Write "<script>window.close()</script>"
	Response.End()
end if
If Request("type") = "CT" Then
%>
<form method="POST"  action="../action/savebill.asp?type=<%=Request("type")%>&add=true" name="sample">
<div align="center"><span class="style1">采购退货单</span></div>
<div align="center"><span class="style1">
<%
End If
If Request("type") = "XT" Then
%>
<form method="POST" action="../action/savebill.asp?type=<%=Request("type")%>&add=true" name="sample">
<div align="center"><span class="style1">销售退货单</span></div>
<div align="center"><span class="style1">
<%
End If
%><br>
<input type="hidden" name="planbillcode" value="<% =a("billcode") %>">
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr><td align="right" width="70">制单日期：</td><td width="320"><input type="text" name="date" size="16" value=<%=a("adddate")%>><%showdate("date")%><font color="red">*</font></td>
<td align="right" width="70">
<%
If a("billtype") = "采购入库" Then
    response.Write "供&nbsp;应&nbsp;商："
End If
If a("billtype") = "销售出库" Then
    response.Write "客&nbsp;&nbsp;&nbsp;&nbsp;户："
End If
%>
</td>
<td width="320"><input type="text" name="Cust" id="cust" size="24" value=<%=a("custname")%>><a href="#SelectDate" onClick="JavaScript:window.open ('../common/selectcust.asp', 'newwindow', 'left=150,top=100,height=600, width=800, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a><font color="red">*</font></td></tr>
<tr>
	<td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
    <td><input type="text" name="depot" id="depot" readonly value="<%=a("depotname")%>"><font color="red">*</font></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td><input type="text" name="maker" size="16" readonly value="<%=request.cookies("username")%>"><font color="red">*</font></td>
</tr>
<tr>
	<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
  <td ><input type="text" name="memo" size="30" value="<%=a("memo")%>"></td>
  <td align="right">经&nbsp;办&nbsp;人：</td><td><select name="user">
    <%
   sql = "select * from t_Employee"
   Set rs = conn.Execute(sql)
   Do While rs.EOF = False
    s_name = rs("name")
    If s_name = a("username") Then
        Response.Write "<option value="&s_name&" selected>"&s_name&"</option>"
    Else
        Response.Write "<option value="&s_name&">"&s_name&"</option>"
    End If
    rs.movenext
   Loop
   close_rs(rs)%></select><font color="red">*</font></td>
  </tr></tbody></table>
<table style="font-size:12px" width="780" id="sqd" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
  <th width=3%>&nbsp;</th>
  <th width=5%>删除</th>
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

sql = "select goodscode,goodsname,goodsunit,units,price,detailnote,number-ifnull((select sum(number) from s_billdetail where planbillcode = bill.billcode and goodscode = bill.goodscode),0) as qty from t_billdetail as bill where billcode='"&a("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
%>
<input type="hidden" id="rowcount" name="rowcount" value=<%=rs_detail.recordcount%>>
<%
For i = 1 To rs_detail.recordcount
%>
<tr><td><%=i%></td>
<td><a href='#' onClick='del_row(<%=i%>)'>删除</a></td>
<td><input name=goodscode type=text class=INPUT1 id=goodscode<%=i%> size=8 value="<%=rs_detail("goodscode")%>"></td>
<td><input name=goodsname type=text class=INPUT1 id=goodsname<%=i%>  size=16 value="<%=rs_detail("goodsname")%>"></td>
<td><input name=goodsunit type=text class=INPUT1 id=goodsunit<%=i%>  size=8 value="<%=rs_detail("goodsunit")%>"></td>
<td><input name=units type=text class=INPUT1 id=units<%=i%>  size=3 value="<%=rs_detail("units")%>"></td>
<td><input onpropertychange="count(<%=i%>)" name=price type=text class="price" id=price<%=i%>  size=8 value="<%=rs_detail("price")%>"></td>
<td><input onpropertychange="count(<%=i%>)" name=number type=text class="number" id=number<%=i%>  size=8 value="<%=rs_detail("qty")%>"> </td>
<td><input name=money type=text class="money" id=money<%=i%> readonly size=8 value="<%=rs_detail("qty") * rs_detail("price")%>"></td>
<td><input name=remark type=text class=INPUT1 id=remark<%=i%> size=20 value="<%=rs_detail("DetailNote")%>">
    <input name=fact_num type=hidden id=fact_num<%=i%> value="<%=rs_detail("qty")%>">
    <input name=aveprice type=hidden id=aveprice<%=i%> value="<%=rs_detail("price")%>">
	</td>
</tr>

<%
total_number = total_number + cdbl(rs_detail("qty"))
total_money  = total_money  + cdbl(rs_detail("qty") * rs_detail("price"))
total_money  = (formatnumber(total_money,2,-1,false,false))
rs_detail.movenext
Next
close_rs(rs_detail)
endconnection
%>
</table>
<table style="font-size:12px" width="780" id="sqd1" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
  <th width=60%>合计</th>
  <th width=10%><input id="total_number" type="text" size="8" value="<%=total_number%>"></th>
  <th width=10%><input id="total_money" type="text" size="8" value="<%=total_money%>"></th>
  <th width=20%></th>
</tr>
</table>
<input type="hidden" id="yfprice" name="yfprice" value="<%=total_money%>">
<div align="center" style="margin-top:5px;margin-bottom:5px;"><input type="submit" onClick="return check();" class="button" value=" 保 存 " name="B1"></div>
</form>
</td></tr></table>
</BODY>
</html>
