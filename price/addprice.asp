<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>收付款单</title>
<script language="JavaScript" src="../js/jquery.js"></script>
<script language="javascript" type="text/javascript">
$(document).ready(function(){
	$("#depot").change(function(){
		$.post("finddepot_ajax.asp",{goodscode:escape($("#goodscode").val()),depotname:escape($("#depot").val())},
		function(data)
		{
		   str=data.split("|");
		   $("#oldqty").val(str[0]);
		   $("#oldprice").val(str[1]);
		});
	});
});
function showdetail(){
	$.post("findgoods_ajax.asp",{goodscode:escape($("#goodscode").val())},
	function(data)
	{
	   str=data.split("|");
	   $("#goodsname").val(str[0]);
	   $("#goodsunit").val(str[1]);
	   $("#units").val(str[2]);
	});	
}
function CheckValue(){
	if($("#goodscode").val()==""){
		alert("请选择货品！");
		$("#goodscode").focus();
		return false;
	}
	if($("#depot").val()==""){
		alert("请选择仓库！");
		$("#depot").focus();
		return false;
	}
	if($("#username").val()==""){
		alert("请选择经办人！");
		$("#username").focus();
		return false;
	}
}
</script>
</head>

<body onLoad="showdetail()">
<%
today = Now()
tdate = Year(today) & "-" & Right("0" & Month(today), 2) & "-" & Right("0" & Day(today), 2)
sql = "select * from t_price where billcode like 'TJ-"&tdate&"%' order by billcode desc"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
If rs.recordcount = 0 Then
    s_billcode = "TJ-"&tdate&"-0001"
Else
    s_temp = rs("billcode")
    s_temp = Right(s_temp, 4) + 1
    s_billcode = "TJ-"&tdate&"-"&Right("000"&s_temp, 4)
End If
close_rs(rs)

sql = "select * from t_price where billcode='"&Request.QueryString("billcode")&"'"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
if rs.recordcount > 0 then
	sBillCode = rs("billcode")
	sAddDate = rs("adddate")
	sGoodsCode = rs("goodscode")
	sDepot = rs("depotname")
	sUsername = rs("username")
	sOldqty = rs("oldqty")
	sOldprice = rs("oldprice")
	sNewqty = rs("newqty")
	sNewprice = rs("newprice")
	sDetailnote = rs("detailnote")
	sMaker = rs("maker")
else
	sBillCode = s_billcode
	sAddDate = date
	sGoodsCode = ""
	sDepot = ""
	sUsername = ""
	sOldqty = "0"
	sOldprice = "0"
	sNewqty = "0"
	sNewprice = "0"
	sDetailnote = ""
	sMaker = Request.Cookies("username")
end if
%>
<form name="price" method="post"  onSubmit="return CheckValue()" action="saveprice.asp">
<div align="center" class="STYLE1">
调整库存数量和单价
</div>
<div align="center" class="STYLE1">
<%
Response.Write sBillCode
Response.Write "<INPUT type=hidden name=""add"" value="&Request.QueryString("billcode")&">"
Response.Write "<INPUT type=hidden name=""billcode"" value="&sBillCode&">"
%>
</div>
<table width="500" id="tbl" align="center">
<tr>
	<td width="15%" align="right">制单日期</td>
	<td width="35%"><input type="text" name="date" id="date" value=<%=sAdddate%>><%showdate("date")%><font color="red">*</font></td>
	<td width="15%" align="right">货品编码</td>
	<td width="35%"><input type="text" name="goodscode" onpropertychange="showdetail();" id="goodscode" size="20" value=<%=sGoodsCode%>><a href="#" onClick="window.open ('selectgoods.asp', 'newwindow', 'height=600, width=800,top=100,left=150, toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
</tr>
<tr>
	<td align="right">货品名称</td>
	<td><input type="text" name="goodsname" id="goodsname" readonly="true" size="20"></td>
	<td align="right" width="15%">货品规格</td>
	<td align="left" width="35%"><input type="text" name="goodsunit" id="goodsunit" readonly="true" size="20"></td>
</tr>
<tr>
	<td align="right">单位</td>
	<td><input type="text" name="units" size="20" readonly="true" id="units"></td>
	<td align="right">仓库</td>
	<td><%call showdepot("depot",sDepot)%></td>
</tr>
<tr>
	<td align="right">原数量</td>
	<td><input type="text" name="oldqty" id="oldqty" readonly="true" size="20" value="<%=sOldqty%>"></td>
	<td align="right">新数量</td>
	<td><input type="text" name="newqty" size="20" value=<%=sNewqty%>></td>
</tr>
<tr>
	<td align="right">原价格</td>
	<td><input type="text" name="oldprice" id="oldprice" readonly="true" size="20" value="<%=sOldprice%>"></td>
	<td align="right">新价格</td>
	<td><input type="text" name="newprice" size="20" value=<%=sNewprice%>></td>
</tr>
</tr>
<tr>
	<td align="right">经办人</td>
	<td><%call showemployee("username",sUsername)%></td>
	<td align="right">制单人</td>
	<td><input type="text" name="maker" size="20" readonly="true" value="<%=sMaker%>"></td>
</tr>
<tr>
	<td align="right">备注</td>
	<td colspan="3"><input type="text" name="detailnote" size="50" value="<%=sDetailnote%>"></td>
</tr>
</table>
<br>
<div align="center"><input type="submit" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"   class="button" value=" 保 存 " align="middle"></div>
</form>
</body>
</html>
