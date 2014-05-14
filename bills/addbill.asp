<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
if request.QueryString("type")="CG" then
  call CheckAuthority("strAddCG")
else
  call CheckAuthority("strAddXS")
end if
if request.QueryString("type")="XS" or request.QueryString("type")="CG" then
set rs=server.CreateObject("adodb.recordset")
sql="select * from t_bill  where billcode='"&request("billcode")&"'"
rs.open sql,conn,1,1
if not rs.eof then
custname=rs("custname")
DepotName=rs("DepotName")
end if 
end if 
%>
<HTML><HEAD><TITLE>单据</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<link rel="stylesheet" href="../style.css" type="text/css">
<META http-equiv=Pragma content=no-cache>
<script language="JavaScript" src="../js/jquery.min.js"></script>
<script>
function openwin(URL,x,y){
var URL;
var x1=window.screen.width;
var y1=window.screen.height;
x2=(x1-x)/2;
y2=(y1-y)/2;
window.open(URL,'','top='+y2+',left='+x2+',width='+x+',height='+y+',status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes')
}
function adddepot(){
	$("#depot")[0].options.add(new Option("test","value"));
}
function bar(){
  if ((event.keyCode == 13) && ($("#barcode").val()!="")){
	
    $.post("barcode.asp",{date:escape($("#date").val()),barcode:escape($("#barcode").val()),depot:escape($("#depot").val())},
	function(data)
	{ 
	  if(data!="")
	  {
	  addrow_bar();
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
	   <%if request("type") = "CG" then%>
	     $("#price"+i).val(str[4]);
	   <%else%>
	     $("#price"+i).val(str[5]);
	   <%end if%>
	   }
	   else
	   {
	   alert('没有相关的数据!!');
	   }
	}
	);
	$("#barcode").val("");
  }
}
function locking(){   
	document.all.ly.style.display="block";   
	document.all.ly.style.width=document.body.clientWidth;   
	document.all.ly.style.height=document.body.clientHeight;   
	document.all.Layer2.style.display='block';  
}   
function Lock_CheckForm(theForm){   
	document.all.ly.style.display='none';document.all.Layer2.style.display='none';
	return false;   
} 
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
	<%
	if (request("type") = "XS") and ((Request("billcode")="") or (Request("chooseplan") <> ""))  Then 
		sqlFCK = "select fuchuku from t_softinfo"
		set rsFCK = Server.CreateObject("adodb.recordset")
		rsFCK.open sqlFCK,conn,1,3
		if rsFCK("fuchuku") = false then%> 
			$(".number").each(
				function(i)
				{
					qtyid = $(this).attr("id");
					stockid = qtyid.replace("number", "fact_num");
					goodsnameid = qtyid.replace("number", "goodsname");
					if (Number($("#"+qtyid).val())>Number($("#"+stockid).val())){
						alert($("#"+goodsnameid).val()+"库存数量不足！");
						errCount++;				
					}
				}
			);
		  <%end if%>
	<%end if%>
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
	document.all.zdprice.value=vTotalMoney;
	document.all.yfprice.value=parseFloat((document.all('zdprice').value))-parseFloat((document.all('zkprice').value));
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
function add_row(){
	if($("#depot").val() == "")
	{
	alert("请选择仓库！");
	document.sample.depot.focus();
	return false;
	}
	openwin('../common/selectgoods.asp?depot='+document.getElementById("depot").value+'&type=<%=request.QueryString("type")%>&adddate='+document.all.date.value+	'&cust='+document.getElementById("cust").value+'', 900, 600);
}
function del_row(i) {
	document.getElementById("sqd").deleteRow(i);
	$("#rowcount").val($("#rowcount").val() - 1);
	counttotal();	
}
function checkbill(){
var temp = "";
var temp1 = "";
$.post("checkbillcode_ajax.asp",{billcode:escape($("#tittle_lable").val())},
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
function changesk(){
	document.all.yfprice.value=parseFloat((document.all('zdprice').value))-parseFloat((document.all('zkprice').value))
}
</script>
</HEAD>
<BODY>
<table border="0" align="center">
<tr>
<td>
<br>
<%if Request.QueryString("chooseplan") = "" then '没有选择订单%>
<form method="POST" onKeyPress="if(event.keyCode==13){return false;}" action="../action/savebill.asp?type=<%=Request("type")%>" name="sample" onSubmit="return">
<div align="center"><span class="style1"><%
If request("type") = "CG" Then
  response.Write "采购单"
End If
If request("type") = "XS" Then
  response.Write "销售单"
End If
%></span></div>
<input type="hidden" id="rowcount" name="rowcount">
<br>
<table id="tbl" style="font-size:12px" width="860" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
  <td width="70" align="right">制单日期：</td>
  <td colspan="3"><input type="text" name="date" id="date" size="16" readonly value=<%= formatdate(date)%>><%showdate("date")%><font color="red">*</font></td>
  <td width="53" align="right"><%If request("type") = "CG" Then
                    response.Write "供&nbsp;应&nbsp;商："
                   End If
                   If request("type") = "XS" Then
                    response.Write "客&nbsp;&nbsp;&nbsp;&nbsp;户："
                   End If%></td>
  <td colspan="3"><input type="text" name="Cust" id="cust" value="<%=custname%>" size="35"><a href="#" onClick="JavaScript:window.open ('../common/selectcust.asp', 'newwindow', 'left=150,top=100,height=600, width=800, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a><font color="red">*</font></td>
</tr>
<tr>
  <td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
  <td colspan="3"><%call showdepot("depot","")%><font color="red">*</font></td>


  
  <td align="right">经&nbsp;办&nbsp;人：</td>
  <td width="119" >
  <select name="user"><% sql = "select * from t_Employee"
                             Set a = conn.Execute(sql)
                             Do While a.EOF = False
                              s_name = a("name")
                              Response.Write "<option value="&s_name&">"&s_name&"</option>"
                              a.movenext
                             Loop%></select><font color="red"></font></td>
							  <td width="48" align="right">帐&nbsp;&nbsp;&nbsp;&nbsp;户：</td>
  <td ><select name="account" style="width:118"><option value=""></option>
      <%	sql_account = "select * from t_account"
	    	  Set rs_account = server.CreateObject("adodb.recordset")
				  rs_account.open sql_account,conn,1,1
				  Do While rs_account.EOF = False
				  Response.Write "<option value="&rs_account("account")&">"&rs_account("account")&"</option>"
				  rs_account.movenext
				  loop
				  %></select></td>
</tr>

<tr>
<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
  <td colspan="5"><input onKeyDown="" type="text" name="memo" id="memo" size="78"></td>
    <td align="right">制&nbsp;单&nbsp;人：</td>
  <td  width="133"><input type="text" size="15" name="maker" readonly value="<%=request.cookies("username")%>"><font color="red">*</font></td>
</tr>
<tr>
  <td align="right" ><%If request("type") = "CG" Then
                    response.Write "整单金额："
					 yftitle="应付金额"
					 sftitle="实付金额"
                   End If
                   If request("type") = "XS" Then
                    response.Write "整单金额："
					yftitle="应收金额"
					sftitle="实收金额"
                   End If%></td>
  <td width="150"><input type="text" name="zdprice"  id="zdprice" onKeyUp="changesk()" size="15" value="0"></td>
  <td   width="79" align="right">折扣金额：</td>
  <td   ><input type="text"  name="zkprice" onKeyUp="changesk()" size="16" value="0"></td>
 

       <td  align="right"><%=yftitle%>：</td>
	   <td><input type="text" name="yfprice"  id="yfprice" size="15" value="0"></td>
	   <td  align="right"><%=sftitle%>：</td>
	   <td><input type="text" name="pay" size="15" value="0"></td>
</tr>
</tbody>
</table>



<script>
function chooseplan(){
window.open ('selectorder.asp?type=<%=request("type")%>', 'newwindow', 'height=500, width=600,top=100,left=150,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=yes')
}
</script>
<div class="but_mar">
<table>
<tr>
	<td width="80" valign="top" >
	<input name="add" type="button" onClick=add_row() onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" value=" 添加商品">
	</td>
	<td width="80" valign="top">
	<input name="choose" onClick="" type="button"  class="button" value="选择订单">
	</td>
	<td width="320" valign="top" style="margin-top:10px">
	条码录入框：<input name="barcode"  id="barcode" size="16" onKeyUp="bar();">
	</td>
</tr>
</table>
</div>
<table style="font-size:12px; margin-top:-5px " width="860" id="sqd" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
  <th width=3%>&nbsp;</th>
  <th width=5%>删除</th>
  <th width=15%>商品编码</th>
  <th width=15%>商品名称</th>
  <th width=12%>商品规格</th>
  <th width=10%>单位</th>
  <th width=10%>单价</th>
  <th width=10%>数量</th>
  <th width=10%>金额</th>
  <th width=10%>备注</th>
</tr>
</table>
<table style="font-size:12px" width="860" id="sqd1" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
  <th width=70%>合计</th>
  <th width=10%><input id="total_number" type="text" size="8"></th>
  <th width=10%><input id="total_money" type="text" size="8"></th>
  <th width=10%></th>
</tr>
</table>
 <div align="center" style="margin-top:5px;margin-bottom:5px;">
	<input type="submit" onMouseDown="return checkbill();" onClick="return check();" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"   class="button" value=" 保 存 " name="B1"></div>
</form>

<%else
sql = "select * from t_bill where billcode='" & Request.QueryString("billcode") & "'"
Set rs_bill = server.CreateObject("adodb.recordset")
rs_bill.Open sql, conn, 1, 1
%>
<form method="POST" onSubmit="" action="../action/savebill.asp?type=<%=Request.QueryString("type")%>" name="sample">
<input type="hidden" name="planbillcode" value="<%=request.QueryString("billcode")%>">
<div align="center"><span class="style1"><%
If request.QueryString("type") = "CG" Then
    response.Write "采购单"
End If
If request.QueryString("type") = "XS" Then
    response.Write "销售单"
End If
%></span></div>
<br>
<table id="tbl" style="font-size:12px" width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tbody>
<tr>
  <td align="right" width="70">制单日期：</td>
  <td colspan="3"><input type="text" name="date" id="date" size="16" readonly value=<%= formatdate(date)%>><%showdate("date")%><font color="red">*</font></td>
  <td width="53" align="right"><%If request("type") = "CG" Then
                    response.Write "供&nbsp;应&nbsp;商："
                   End If
                   If request("type") = "XS" Then
                    response.Write "客&nbsp;&nbsp;&nbsp;&nbsp;户："
                   End If%></td>
  <td colspan="3"><input type="text" name="Cust" id="cust" value="<%=custname%>" size="35"><a href="#" onClick="JavaScript:window.open ('../common/selectcust.asp', 'newwindow', 'left=150,top=100,height=600, width=800, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a><font color="red">*</font></td>
</tr>
<tr>
  <td align="right">仓&nbsp;&nbsp;&nbsp;&nbsp;库：</td>
  <% if request("billcode")<>"" then%>
  <td colspan="3">
   <select name="depot">
    <option value="<%=depotname%>"><%=depotname%></option>
   </select>
  </td>
  <%else%>
  <td colspan="3"><%call showdepot("depot","")%><font color="red">*</font></td>
  <%end if%>


  
  <td align="right">经&nbsp;办&nbsp;人：</td>
  <td width="119" ><select name="user"  style="width:118"><% sql = "select * from t_Employee"
                             Set a = conn.Execute(sql)
                             Do While a.EOF = False
                              s_name = a("name")
                              Response.Write "<option value="&s_name&">"&s_name&"</option>"
                              a.movenext
                             Loop%></select><font color="red">*</font></td>
							  <td width="48" align="right">帐&nbsp;&nbsp;&nbsp;&nbsp;户：</td>
  <td ><select name="account" style="width:118"><option value=""></option>
      <%	sql_account = "select * from t_account"
	    	  Set rs_account = server.CreateObject("adodb.recordset")
				  rs_account.open sql_account,conn,1,1
				  Do While rs_account.EOF = False
				  Response.Write "<option value="&rs_account("account")&">"&rs_account("account")&"</option>"
				  rs_account.movenext
				  loop
				  %></select></td>
</tr>

<tr>
<td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
  <td colspan="5"><input onKeyDown="" type="text" name="memo" id="memo" size="78"></td>
    <td align="right">制&nbsp;单&nbsp;人：</td>
  <td  width="133"><input type="text" size="15" name="maker" readonly value="<%=request.cookies("username")%>"><font color="red">*</font></td>
</tr>
<tr>
  <td align="right" ><%If request("type") = "CG" Then
                    response.Write "整单金额："
					 yftitle="应付金额"
					 sftitle="实付金额"
                   End If
                   If request("type") = "XS" Then
                    response.Write "整单金额："
					yftitle="应收金额"
					sftitle="实收金额"
                   End If%></td>
  <td width="150"><input type="text" name="zdprice"  id="zdprice" onKeyUp="changesk()" size="15" value="0"></td>
  <td   width="79" align="right">折扣金额：</td>
  <td   ><input type="text"  name="zkprice" onKeyUp="changesk()" size="16" value="0"></td>
 

       <td  align="right"><%=yftitle%>：</td>
	   <td><input type="text" name="yfprice"  id="yfprice" size="15" value="0"></td>
	   <td  align="right"><%=sftitle%>：</td>
	   <td><input type="text" name="pay" size="15" value="0"></td>
</tr>

</tbody>
</table>
 <div align="left" style="margin-top:5px;margin-bottom:5px;">
    <input name="add" type="button" onClick=add_row() onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button"  value=" 添 加 ">
	<input name="del" onclick=del_row() type="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" value=" 删 除 ">
	&nbsp;&nbsp;条码录入框：<input name="barcode" id="barcode" size="16" onKeyUp="bar();"></div>
<table style="font-size:12px" width="822" id="sqd" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
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
sql = "select s1.goodscode,goodsname,goodsunit,units,s1.price,case when s2.t_num is null then s1.t_num else s1.t_num-s2.t_num end as [number],s1.price*case when s2.t_num is null then s1.t_num else s1.t_num-s2.t_num end as [money],detailnote,inprice,isnull(qty,0) as qty from (select goodscode,goodsname,goodsunit,units,price,detailnote,sum(number) as t_num,billcode,inprice,depotname from s_billdetail where billcode='"&request.QueryString("billcode")&"' and [check]=1 group by billcode,goodscode,goodsname,goodsunit,units,price,detailnote,inprice,depotname) as s1 left join (select planbillcode,goodscode,sum(number) as t_num from s_billdetail group by planbillcode,goodscode) as s2 on s1.billcode = s2.planbillcode and s1.goodscode=s2.goodscode left join t_stock on t_stock.goodscode = s1.goodscode and t_stock.depotname = s1.depotname"

Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>

<input type="hidden" id="rowcount" name="rowcount" value="<%=rs_detail.recordcount%>">
<tr><td><%=i%></td>
<td><a href='#' onClick='del_row()'>删除</a></td>
<td><input name=goodscode type=text class=INPUT1 id=goodscode<%=i%> size=8 value="<%=rs_detail("goodscode")%>"></td>
<td><input name=goodsname type=text class=INPUT1 id=goodsname<%=i%>  size=16 value="<%=rs_detail("goodsname")%>"></td>
<td><input name=goodsunit type=text class=INPUT1 id=goodsunit<%=i%>  size=8 value="<%=rs_detail("goodsunit")%>"></td>
<td><input name=units type=text class=INPUT1 id=units<%=i%>  size=3 value="<%=rs_detail("units")%>"></td>
<td><input onpropertychange=count(<%=i%>) name=price type=text class=INPUT1 id=price<%=i%>  size=8 value="<%=rs_detail("price")%>"></td>
<td><input onpropertychange=count(<%=i%>) name=number type=text class="number" id=number<%=i%>  size=8 value="<%=rs_detail("number")%>"></td>
<td><input name=money type=text class=money id=money<%=i%>  size=8 readonly value="<%=rs_detail("money")%>"></td>
<td><input name=remark type=text class=INPUT1 id=remark<%=i%> size=20 value="<%=rs_detail("DetailNote")%>"><input name=aveprice type=hidden class=INPUT1 id=aveprice<%=i%> value="<%=rs_detail("inprice")%>"><input name=fact_num type=hidden class=fact_num id=fact_num<%=i%> value="<%=rs_detail("qty")%>"></td>
</tr>

<%
total_number = total_number + cdbl(rs_detail("number"))
total_money  = total_money  + cdbl(rs_detail("money"))
total_money  = (formatnumber(total_money,2,-1,false,false))
rs_detail.movenext
Next
%>
</table>
<table style="font-size:12px" width="822" id="sqd1" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
  <th width=60%>合计</th>
  <th width=10%><input id="total_number" type="text" size="8" value="<%=total_number%>"></th>
  <th width=10%><input id="total_money" type="text" size="8" value="<%=total_money%>"></th>
  <th width=20%></th>
</tr>
<script language="javascript">
    document.getElementById("zdprice").value= document.getElementById("total_money").value
	document.getElementById("yfprice").value= document.getElementById("total_money").value
</script>
</table>
<div align="center" style="margin-top:5px;margin-bottom:5px;">
<input type="submit" onMouseDown="checkbill();" onClick="return check();" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" value=" 保 存 " name="B1"></div>
</form>
<%
close_rs(rs_bill)
close_rs(rs_detail)
end if
endconnection%>
</td></tr></table>

/table>

