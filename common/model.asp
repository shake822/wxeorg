<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%call CheckAuthority("strModel")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>组装模板</title>
<script language="JavaScript" src="../js/exportexcel.js"></script>
<script>
function changegoodstype(){
  if (document.getElementById('nodename').value == "") {
	 document.getElementById('typecode').value ="";
	  }	
}
function CreateReturnValue(){
　　 var nodecode=document.getElementById("goodstype");
     nodecode.value=document.getElementById('nodename').value; 
}
function del(){
if (document.getElementById('temp').value == "" ){
alert("请选贼要删除的模板！");
return false;
}
else{
if(!confirm('确定要删除该货品的模板吗?')){
return false
}else{
window.location.href='../model/delbill.asp?billcode='+document.getElementById('temp').value
}
}
}
function edit(){
if(document.getElementById('temp').value == "" ){
alert("请选择要编辑的货品资料！");
return false;
}
}
</script>
</head>
<body>
<table align="center"><tr><td>
<form name="form1" method="post" action="model.asp">
<table border="0">
<tr>
	<td align="right">产品货品编码：</td>
    <td><input type="text" name="totalgoodscode" size="16" value="<%=request.Form("totalgoodscode")%>"></td>
    <td align="right">零件货品编码：</td>
    <td><input type="text" name="detailgoodscode" size="16" value="<%=request.Form("detailgoodscode")%>"></td>
    <td rowspan="3"><input type="submit" class="button" value=" 查 询 "></td>
</tr>
<tr>
	<td align="right">产品货品名称：</td>
    <td><input type="text" name="totalgoodsname" size="16" value="<%=request.Form("totalgoodsname")%>"></td>
	<td align="right">零件货品名称：</td>
    <td><input type="text" name="detailgoodsname" size="16" value="<%=request.Form("detailgoodsname")%>"></td>
</tr>
<tr>
	<td align="right">产品货品规格：</td>
    <td><input type="text" name="totalgoodsunit" size="16" value="<%=request.Form("totalgoodsunit")%>"></td>
	<td align="right">零件货品规格：</td>
    <td><input type="text" name="detailgoodsunit" size="16" value="<%=request.Form("detailgoodsunit")%>"></td>
</tr>
</table>
</form>

<div align="center"><span class="style1">组装模板</span></div>
<form name="addgoods" method="post" action="../model/editmodel.asp">
<input type="button" value=" 新 增 " onClick="window.location.href='../model/addmodel.asp?add=true'" class="button">
<input type="submit" value=" 编 辑 " onClick="return edit();" class="button">
<input type="button" value=" 删 除 " onClick="return del();" class="button">
</td></tr>
<tr valign="top">
<td>
<%
if Request.Form("totalgoodscode") = "" then
	sTotalGoodsCode = ""
else
	sTotalGoodsCode = " and totalgoodscode like '%"& Request.Form("totalgoodscode") &"%'"
end if

if Request.Form("detailgoodscode") = "" then
	sDetailGoodsCode = ""
else
	sDetailGoodsCode = " and Detailgoodscode like '%"& Request.Form("detailgoodscode") &"%'"
end if


if Request.Form("totalgoodsname") = "" then
	sTotalGoodsName = ""
else
	sTotalGoodsName = " and totalgoodsname='"&request.Form("totalgoodsname")&"'"
end if

if Request.Form("detailgoodsname") = "" then
	sDetailGoodsName = ""
else
	sDetailGoodsName = " and detailgoodsname='"&request.Form("detailgoodsname")&"'"
end if

if Request.Form("totalgoodsunit") = "" then
	sTotalGoodsUnit = ""
else
	sTotalGoodsUnit = " and totalgoodsunit='"&request.Form("totalgoodsunit")&"'"
end if

if Request.Form("detailgoodsunit") = "" then
	sDetailGoodsUnit = ""
else
	sDetailGoodsUnit = " and totalgoodsunit='"&request.Form("totalgoodsunit")&"'"
end if

sql = "select distinct memo,billcode,totalgoodscode,totalgoodsname,totalgoodsunit,totalunits,totalnumber from s_model where 1=1 " & sTotalGoodsCode & sDetailGoodsCode & sTotalGoodsName & sDetailGoodsName & sTotalGoodsUnit & sDetailGoodsUnit
call showpage(sql,"model",1)

endconnection
 %>
</td></tr></table>
</body>
</html>
