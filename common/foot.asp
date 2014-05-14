<!-- #include file="../inc/conn.asp" -->
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
strAddCG = instr(strPower,"AddCG")
strAddXS = instr(strPower,"AddXS")
strDepotCount = instr(strPower,"DepotCount")
strDepotNum = instr(strPower,"DepotNum")
strDepotWarn = instr(strPower,"DepotWarn")
strBrowseCustom = instr(strPower,"BrowseCustom")
strBrowseGoods = instr(strPower,"BrowseGoods")

soft_sql = "select * from t_softinfo"
set rs_soft = Server.CreateObject("adodb.recordset")
rs_soft.open soft_sql, conn, 1, 1
version= rs_soft("version")
close_rs(rs_soft)

%>

<HTML>
<HEAD>
<title></title>
<meta http-equiv='Content-Type' content='text/html; charset=GB2312;'>
<link rel="stylesheet" href="../skin.css"  type="text/css">

<script language=javascript> 
<!--
//-----------------------------------------------
//当前时间 Finish
//-----------------------------------------------
function runClock()
{
	theTime = window.setTimeout("runClock()", 1000);
	var now				= new Date();
	var dateValue		= now.toLocaleDateString();
	var timeValue		= now.toLocaleTimeString();
	var datetimeValue	= dateValue + ' ' + timeValue;
	document.all.nowtime.innerHTML = datetimeValue;
}
//-----------------------------------------------
-->
</script>
</HEAD>
<body leftmargin="0" topmargin="0" style="background:#1C5BB2" onLoad="runClock();">
 
<table border=0 width=100% cellpadding=0 cellspacing=0 style="color:#FFFFFF">
  <tr>
	<td height=1 colspan=6 bgcolor=#FFFFFF></td>
  </tr>
  <tr height=24>
    <td nowrap width=20%><P>&nbsp;&nbsp;&nbsp;用户姓名：<%=request.cookies("username")%></P></td>
    <td nowrap width=20%><P>&nbsp;&nbsp;&nbsp;ＩＰ地址：<%=request.cookies("id")%></P></td>
    <td nowrap width=20%><P>&nbsp;&nbsp;&nbsp;登录时间：<%=request.cookies("date")%></P></td>
    <td nowrap width=20%><P>&nbsp;&nbsp;&nbsp;当前时间：<label id=nowtime  style="width:160;"></label></P></td>
  </tr>
</table>
 
</body>
</HTML>
