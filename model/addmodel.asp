<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" href="../style.css" type="text/css">
<META http-equiv=Pragma content=no-cache>
<script language="JavaScript" src="../js/addrow.js"></script>
<script language="JavaScript" src="../js/jquery.js"></script>
<script>
function checkbill(){
var temp = "";
var temp1 = "";
$.post("checkbillcode_ajax.asp",{billcode:escape($("#billcode").val())},
function(data)
{ 
   if (data == "False"){
	   alert("有重复单号，请再次点击保存");
		temp = $("#tittle_lable").html();
		temp1 = "000"+String(Number(temp.substring(14))+1);
	   $('#tittle_lable').html(temp.substring(0,14)+temp1.substring(temp1.length-4)); 
	   $('#billcode_input').attr("value",$('#tittle_lable').html());
	   return false;
   }
}
);		
	}
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
if (document.getElementById("sqd").rows.length == 1)
{
alert("请添加货品！");
return false;
}
}
function edit_row(i)
{
	window.open ('../common/selectgoods.asp?depot='+document.getElementById("depot").value+'&type=<%=request.QueryString("type")%>&adddate='+document.all.date.value+'&id='+i, 'newwindow', 'top=100,left=150,height=600, width=800,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
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
			count(i)
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
function selectgoods(){
	window.open ('selectgoods.asp', 'newwindow', 'top=100,left=150,height=600, width=800,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}
</script>
</HEAD>
<BODY>
<table align="center" border="0"><tr><td>
<form method="POST" onKeyPress="if(event.keyCode==13){return false;}" action="savemodel.asp" name="sample">

<br><div align="center"><span class="style1">组装、拆卸模板</span></div>
<input type="hidden" id="rowcount" name="rowcount">
<div align="center"><span class="style1"><%
today = Now()
tdate = Year(today) & "-" & Right("0" & Month(today), 2) & "-" & Right("0" & Day(today), 2)
sql = "select * from t_ModelTotal where billcode like 'PM-"&tdate&"%' order by billcode desc"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
If rs.recordcount = 0 Then
    s_billcode = "PM-"&tdate&"-0001"
Else
    s_temp = rs("billcode")
    s_temp = Right(s_temp, 4) + 1
    s_billcode = "PM-"&tdate&"-"&Right("000"&s_temp, 4)
End If
close_rs(rs)
Response.Write "<label id=tittle_lable>"&s_billcode&"</label>"
Response.Write "<INPUT type=hidden id=""billcode_input"" name=""billcode"" value="&s_billcode&">"
%></span></div><br>
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
	<td><input type="text" id="totalgoodscode" name="totalgoodscode" size="10"><a href="#" onClick="window.open ('selectgoods.asp', 'selectgoods', 'height=600, width=800,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></td>
    <td><input type="text" id="totalgoodsname" name="totalgoodsname" size="20"></td>
    <td><input type="text" id="totalgoodsunit" name="totalgoodsunit" size="20"></td>
    <td><input type="text" id="totalunits" name="totalunits" size="10"></td>
    <td><input type="text" id="totalnumber" name="totalnumber" size="10"></td>
    <td><input type="text" id="memo" name="memo" size="20"></td>
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
</table>
<table style="font-size:12px" width="780" id="sqd1" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
  <th width=60%>合计</th>
  <th width=10%><input id="total_number" type="text" size="8"></th>
  <th width=10%><input id="total_money" type="text" size="8"></th>
  <th width=20%></th>
</tr>
</table>
<div align="center" class="but_mar"><input type="submit" onMouseDown="checkbill();" onClick="return check();" class="button" value=" 保 存 " name="B1"></div>
</form>
</td></tr></table>
<%endconnection%>
</BODY>
</HTML>
