<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strAddLL") %>
<HTML><HEAD><TITLE></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" href="../style.css" type="text/css">
<META http-equiv=Pragma content=no-cache>
<script language="JavaScript" src="../js/jquery.js"></script>
<script language="JavaScript" src="../js/addrow.js"></script>
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
	   $("#price"+i).val(str[5]);
	}
	);
	$("#barcode").val("");
  }
}
function check(){
if (document.sample.cust.value=="")
{
alert("请选择部门！");
document.sample.cust.focus();
return false;
}
if ($("#depot").val() == "")
{
alert("请选择仓库！");
document.sample.depot.focus();
return false;
}
if (document.getElementById("sqd").rows.length == 1)
{
alert("请添加货品！");
return false;
}
for (i=1;i<=Number(document.getElementById("rowcount").value);i++){
  need_number = Number(document.getElementById("number"+i).value);
  fact_number = Number(document.getElementById("fact_num"+i).value);
  <%
  sqlFCK = "select fuchuku from t_softinfo"
  set rsFCK = Server.CreateObject("adodb.recordset")
  rsFCK.open sqlFCK,conn,1,1
  if rsFCK("fuchuku") = false then
  %>
  if (need_number>fact_number){
  alert(document.getElementById("goodsname"+i).value+"库存数量不足！");
  return false;
  }
  <%end if%>
}
}
function edit_row(i)
{
openwin('../common/selectgoods.asp?depot='+document.getElementById("depot").value+'&type=<%=request.QueryString("type")%>&adddate='+document.all.date.value+'&id='+i,800,600)
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
	openwin('../common/selectgoods.asp?depot='+document.getElementById("depot").value+'&type=<%=request.QueryString("type")%>&adddate='+document.all.date.value+'&id='+j,800,600)
}

function opencgbill(){
	openwin('selectcgbill.asp', 850,600);
}

function del_row() {
	document.all.sqd.deleteRow(window.event.srcElement.parentElement.parentElement.rowIndex);
}
</script>
</HEAD>
<BODY>
<table border="0" align="center">
<tr>
<td>
<%if Request.QueryString("choosebill") = "" then %>
<form method="POST"  onKeyPress="if(event.keyCode==13){return false;}" action="../action/savebill.asp?type=LL" name="sample">
<br>
<div align="center"><span class="style1">领料单</span></div>
<input type="hidden" id="rowcount" name="rowcount">
<div align="center"><span class="style1"><%
today = Now()
tdate = Year(today) & "-" & Right("0" & Month(today), 2) & "-" & Right("0" & Day(today), 2)
sql = "select * from t_bill where billcode like 'LL-"&tdate&"%' order by billcode desc"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
If rs.recordcount = 0 Then
    s_billcode = "LL-"&tdate&"-0001"
Else
    s_temp = rs("billcode")
    s_temp = Right(s_temp, 4) + 1
    s_billcode = "LL-"&tdate&"-"&Right("000"&s_temp, 4)
End If
close_rs(rs)
Response.Write "<label id=tittle_lable>"&s_billcode&"</label>"
Response.Write "<INPUT type=hidden id=""billcode_input"" name=""billcode"" value="&s_billcode&">"
%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr><td align="right" width="70">制单日期：</td>
<td width="320"><input type="text" name="date" id="date" size="16" value=<%=formatdate(date)%>><%showdate("date")%><font color="red">*</font></td>
<td align="right" width="70">部&nbsp;&nbsp;&nbsp;&nbsp;门：</td>
<td width="320"><%call ShowCombo("t_department","name","cust","")%></td>
</tr>
<tr><td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
    <td><%call showdepot("depot","")%><font color="red">*</font></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td><input type="text" size="16" name="maker" readonly value="<%=request.cookies("username")%>"><font color="red">*</font></td></tr>
  <tr><td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td><td><input onKeyDown="" type="text" name="memo" size="30"></td>
  <td align="right">经&nbsp;办&nbsp;人：</td><td><select name="user">
    <%
    sql = "select * from t_Employee"
    Set a = conn.Execute(sql)
    Do While a.EOF = False
    s_name = a("name")
    Response.Write "<option value="&s_name&">"&s_name&"</option>"
    a.movenext
    Loop
	close_rs(a)
   %>
  </select><font color="red">*</font></td>
  </tr></tbody></table>

<div style="margin-top:5px;margin-bottom:5px;">
<input name="add" type="button" onClick=add_row() class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value=" 添 加 ">
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
<div align="center" class="but_mar"><input type="submit" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  onMouseDown="checkbill();" onClick="return check();" class="button" value=" 保 存 " name="B1"></div>
</form>
<%ELSE%>
<%
sql = "select * from t_bill where billcode='" & Request.QueryString("billcode") & "'"
Set rs_bill = server.CreateObject("adodb.recordset")
rs_bill.Open sql, conn, 1, 1
%>
<form method="POST" onKeyPress="if(event.keyCode==13){return false;}" action="../action/savebill.asp?type=LL" name="sample">
<br>
<div align="center"><span class="style1">领料单</span></div>
<div align="center"><span class="style1"><%
today = Now()
tdate = Year(today) & "-" & Right("0" & Month(today), 2) & "-" & Right("0" & Day(today), 2)
sql = "select * from t_bill where billcode like 'LL-"&tdate&"%' order by billcode desc"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
If rs.recordcount = 0 Then
    s_billcode = "LL-"&tdate&"-0001"
Else
    s_temp = rs("billcode")
    s_temp = Right(s_temp, 4) + 1
    s_billcode = "LL-"&tdate&"-"&Right("000"&s_temp, 4)
End If
close_rs(rs)
Response.Write "<label id=tittle_lable>"&s_billcode&"</label>"
Response.Write "<INPUT type=hidden id=""billcode_input"" name=""billcode"" value="&s_billcode&">"
%></span></div><br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
	<td align="right" width="70">制单日期：</td>
	<td width="320"><input type="text" name="date" id="date" size="16" value="<%=rs_bill("adddate")%>" readonly ><%showdate("date")%><font color="red">*</font></td>
	<td align="right" width="70">部&nbsp;&nbsp;&nbsp;&nbsp;门：</td>
	<td width="320"><%call ShowCombo("t_department","name","cust","")%></td>
</tr>
<tr>
	<td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
	<td><%call showdepot("depot",rs_bill("depotname"))%><font color="red">*</font></td>
	<td align="right">制&nbsp;单&nbsp;人：</td>
	<td><input type="text" size="16" name="maker" readonly value="<%=request.cookies("username")%>"><font color="red">*</font></td>
</tr>
  <tr><td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
  <td><input onKeyDown="" type="text" name="memo" size="30" value="<%=rs_bill("memo")%>"></td>
  <td align="right">经&nbsp;办&nbsp;人：</td>
  <td><select name="user">
    <%
    sql = "select * from t_Employee"
    Set a = conn.Execute(sql)
    Do While a.EOF = False
 
    s_name = a("name")
    If s_name = rs_bill("username") Then
        Response.Write "<option value="&s_name&" selected>"&s_name&"</option>"
    Else
        Response.Write "<option value="&s_name&">"&s_name&"</option>"
    End If
    a.movenext
    Loop
		close_rs(a)
   %>
  </select><font color="red">*</font></td>
</tr>
</tbody>
</table>
<div style="margin-top:5px;margin-bottom:5px;">
<input name="add" type="button" onClick=add_row() onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" value=" 添 加 ">
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
sql = "select s1.goodscode,goodsname,goodsunit,units,price,case when s2.t_num is null then s1.t_num else s1.t_num-s2.t_num end as number,price*case when s2.t_num is null then s1.t_num else s1.t_num-s2.t_num end as money,detailnote,inprice from (select goodscode,goodsname,goodsunit,units,price,detailnote,sum(number) as t_num,billcode,inprice from s_billdetail where billcode='"&request.QueryString("billcode")&"' group by billcode,goodscode,goodsname,goodsunit,units,price,detailnote,inprice) as s1 left join (select planbillcode,goodscode,sum(number) as t_num from s_billdetail group by planbillcode,goodscode) as s2 on s1.billcode = s2.planbillcode and s1.goodscode=s2.goodscode"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1

%>
<input type="hidden" id="rowcount" name="rowcount" value=<%=rs_detail.recordcount%>>
<%
For i = 1 To rs_detail.recordcount
%>
<tr><td><%=i%></td>
<td><input name=delNumber type=radio ></td>
<td><input name=goodscode<%=i%> type=text class=INPUT1 id=goodscode<%=i%> size=8 value="<%=rs_detail("goodscode")%>"></td>
<td><input name=goodsname<%=i%> type=text class=INPUT1 id=goodsname<%=i%>  size=16 value="<%=rs_detail("goodsname")%>"></td>
<td><input name=goodsunit<%=i%> type=text class=INPUT1 id=goodsunit<%=i%>  size=8 value="<%=rs_detail("goodsunit")%>"></td>
<td><input name=units<%=i%> type=text class=INPUT1 id=units<%=i%>  size=3 value="<%=rs_detail("units")%>"></td>
<td><input onpropertychange=count(<%=i%>) name=price<%=i%> type=text class=INPUT1 id=price<%=i%>  size=8 value="<%=rs_detail("price")%>"></td>
<td><input onpropertychange=count(<%=i%>) name=number<%=i%> type=text class=INPUT1 id=number<%=i%>  size=8 value="<%=rs_detail("number")%>"> </td>
<td><input name=money<%=i%> type=text class=INPUT1 id=money<%=i%> size=8 value="<%=rs_detail("money")%>"></td>
<td><input name=remark<%=i%> type=text class=INPUT1 id=remark<%=i%> size=20 value="<%=rs_detail("DetailNote")%>"><input name=aveprice<%=i%> type=hidden class=INPUT1 id=aveprice<%=i%> value="<%=rs_detail("inprice")%>"></td></tr>
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
<div align="center" class="but_mar"><input type="submit" onMouseDown="checkbill();" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  onClick="return check();" class="button" value=" 保 存 " name="B1"></div>
</form>
<%END IF%>
<%endconnection%>
</td>
</tr>
</table>
</BODY>
</HTML>
