<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../inc/config.asp" -->
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" href="../style.css" type="text/css">
<META http-equiv=Pragma content=no-cache>
<script language="JavaScript" src="../js/jquery.js"></script>
<script language="JavaScript" src="../js/addrow.js"></script>
<script>
function bar(){
  if ((event.keyCode == 13) && ($("#barcode").val()!="")){
	addrow_bar();
    $.post("barcode.asp",{date:escape($("#date").val()),barcode:escape($("#barcode").val()),depot:escape($("#depot").val())},
	function(data)
	{ 
	   i=$("#rowcount").val();
	   str=data.split("|");
	   $("#goodscode"+i).val(str[0]);
	   $("#goodsname"+i).val(str[1]);
	   $("#goodsunit"+i).val(str[2]);
	   $("#units"+i).val(str[3]);
	   $("#number"+i).val("1");
	   $("#aveprice"+i).val(str[8]);
	   $("#fact_num"+i).val(str[7]);
	   $("#remark"+i).val(str[6]);
	   $("#price"+i).val(str[8]);
	}
	);
	$("#barcode").val("");
  }
}
function check(){
//if (document.sample.cust.value=="")
//{
//alert("请选择往来单位！");
//document.sample.cust.focus();
//return false;
//}
if (document.getElementById("sqd").rows.length == 1)
{
alert("请添加货品！");
return false;
}
}
function edit_row(i)
{
	window.open ('../common/selectgoods.asp?depot='+document.getElementById("depot").value+'&type=<%=s_type%>&adddate='+document.all.date.value+'&id='+i, 'newwindow', 'top=100,left=150,height=600, width=800,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}
function count(i){
if (i!= 0){
r_price=Number(document.getElementById("price"+i).value);
r_number=Number(document.getElementById("number"+i).value);
document.getElementById("money"+i).value=(r_price*r_number).toFixed(2);
}document.getElementById('total_money').value=0;
document.getElementById('total_number').value=0;
    for (j=1;j<document.all.sqd.rows.length;j++)
	{	
	document.getElementById('total_money').value=(Number(document.getElementById('total_money').value)+Number(document.getElementById("money"+j).value)).toFixed(2);
	document.getElementById('total_number').value=Number(document.getElementById('total_number').value)+Number(document.getElementById("number"+j).value);
	}
}

var j=0
function add_row(){
	if ($("#depot").val() == "")
	{
	alert("请选择仓库！");
	document.sample.depot.focus();
	return false;
	}
    //addrow();
	window.open ('../common/selectgoods.asp', 'newwindow', 'top=100,left=150,height=600, width=800,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}
function del_row() {
    if(sqd.rows.length==1) return;
    var checkit = false
    for (var i=0;i<document.all.delNumber.length;i++) {
            if (document.all.delNumber[i].checked) {
            checkit=true;
            sqd.deleteRow(i+1)
			count(i);
            break;
            }
    }
    if (checkit) {
        for(i=1;i<sqd.rows.length;i++){
        sqd.rows[i].cells[0].innerText=i
		document.getElementById("rowcount").value=sqd.rows.length-1
        }

    } else
    {
    alert("请选择一个要删除的对象");
    return false}
}
</script>
</HEAD>
<BODY>
<%
sql = "select s1.memo,billcode,s1.goodscode as totalgoodscode,s2.goodsname as totalgoodsname,s2.goodsunit as totalgoodsunit,s2.units as totalunits,s1.number as totalnumber from ((select * from t_modeltotal where billcode='"&Request.Form("temp")&"') as s1 left join (select * from t_goods) as s2 on s2.goodscode = s1.goodscode)"
Set a = server.CreateObject("adodb.recordset")
a.Open sql, conn, 1, 1
%>
<table align="center" border="0"><tr><td>
<form method="POST" onKeyPress="if(event.keyCode==13){return false;}" action="savemodel.asp?add=false" name="sample">

<br><div align="center"><span class="style1">组装、拆卸模板</span></div>
<div align="center"><span class="style1"><%=Request("temp")%></span></div><br>
<INPUT type=hidden name="billcode" value=<%=Request("temp")%>></span></div><br>
<table border="0" align="center">
<tr>
	<th>产品编码</th>
    <th>产品名称</th>
    <th>产品规格</th>
    <th>单位</th>
    <th>产品数量</th>
    <th>备注</th>
</tr>
<tr>
	<td><input type="text" id="totalgoodscode" name="totalgoodscode" size="10" value="<%=a("totalgoodscode")%>"><a href="#" onClick="window.open ('selectgoods.asp', 'selectgoods', 'height=600, width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></td>
    <td><input type="text" id="totalgoodsname" name="totalgoodsname" size="20" value="<%=a("totalgoodsname")%>"></td>
    <td><input type="text" id="totalgoodsunit" name="totalgoodsunit" size="20" value="<%=a("totalgoodsunit")%>"></td>
    <td><input type="text" id="totalunits" name="totalunits" size="10" value="<%=a("totalunits")%>"></td>
    <td><input type="text" id="totalnumber" name="totalnumber" size="10" value="<%=a("totalnumber")%>"></td>
    <td><input type="text" id="memo" name="memo" size="20" value="<%=a("memo")%>"></td>
</tr>
</table>
<div align="left" class="but_mar">
    <input name="add" type="button" onClick=add_row() class="button" value=" 添 加 ">
	<input name="del" onclick=del_row() type="button" class="button" value=" 删 除 ">
	&nbsp;&nbsp;条码录入框：<input name="barcode" id="barcode" size="16" onKeyUp="bar();"></div>
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

sql = "select * from t_modeldetail where billcode='"&a("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
%>
<input type="hidden" id="rowcount" name="rowcount" value=<%=rs_detail.recordcount%>>
<%
For i = 1 To rs_detail.recordcount
%>
<tr>
<td><%=i%></td>
<td><input name=delNumber type=radio ></td>
<td><input name=goodscode<%=i%> type=text class=INPUT1 id=goodscode<%=i%> size=8 value="<%=rs_detail("goodscode")%>" onClick="edit_row(<%=i%>)"></td>
<td><input name=goodsname<%=i%> type=text class=INPUT1 id=goodsname<%=i%>  size=16 value="<%=rs_detail("goodsname")%>" onClick="edit_row(<%=i%>)"></td>
<td><input name=goodsunit<%=i%> type=text class=INPUT1 id=goodsunit<%=i%>  size=8 value="<%=rs_detail("goodsunit")%>"></td>
<td><input name=units<%=i%> type=text class=INPUT1 id=units<%=i%>  size=3 value="<%=rs_detail("units")%>"></td>
<td><input onpropertychange=count(<%=i%>) name=price<%=i%> type=text class=INPUT1 id=price<%=i%>  size=8 value="<%=rs_detail("price")%>"></td>
<td><input onpropertychange=count(<%=i%>) name=number<%=i%> type=text class=INPUT1 id=number<%=i%>  size=8 value="<%=rs_detail("number")%>"> </td>
<td><input name=money<%=i%> type=text class=INPUT1 id=money<%=i%> size=8 value="<%=(formatnumber(rs_detail("money"),2,-1,false,false))%>"></td>
<td><input name=remark<%=i%> type=text class=INPUT1 id=remark<%=i%> size=20 value="<%=rs_detail("DetailNote")%>"></td>
</tr>
<%
total_number = total_number + cdbl(rs_detail("number"))
total_money  = total_money  + cdbl(rs_detail("money"))
total_money  = (formatnumber(total_money,2,-1,false,false))
rs_detail.movenext
Next
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
<div align="center" class="but_mar"><input type="submit" onClick="return check();" class="button" value=" 保 存 " name="B1"></div>
</form>
</td></tr></table>
<%
close_rs(a)
close_rs(rs_detail)
endconnection
%>
</BODY>
</HTML>
