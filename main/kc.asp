<!-- #include file="../inc/conn.asp" -->
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
'response.write strPower
strAddIn = instr(strPower,"AddIn")
strSelectIn = instr(strPower,"SelectIn")
strAddOut = instr(strPower,"AddOut")
strSelectOut = instr(strPower,"SelectOut")
strAddDB = instr(strPower,"AddDB")
strAddPD = instr(strPower,"AddPD")
strAddLL = instr(strPower,"AddLL")
strAddTL = instr(strPower,"AddTL")
strAddZZ = instr(strPower,"AddZZ")
strSelectProduct = instr(strPower,"SelectProduct")
strReportProduct = instr(strPower,"ReportProduct")
strBorrowDetail = instr(strPower,"BorrowDetail")
strGoodsBorrowCount = instr(strPower,"GoodsBorrowCount")
strDepartBorrowCount = instr(strPower,"DepartBorrowCount")
intDepot = cint(strAddIn) + cint(strSelectIn) + cint(strAddOut) + cint(strSelectOut) + cint(strAddDB) + cint(strAddPD) + cint(strAddLL) + cint(strAddTL) + cint(strAddZZ) + cint(strSelectProduct) + cint(strReportProduct) + cint(strBorrowDetail) + cint(strGoodsBorrowCount) + cint(strDepartBorrowCount)
%>
<html>
<head>
<title>宜商进销存连锁加盟版</title>
<%mypath="../"%>
<meta http-equiv='Content-Type' content='text/html; charset=Gb2312;'>
<link rel="stylesheet" href="../skin.css"  type="text/css">

<style>
body {background: #ffffff;	color: #444;}
a{	color: #09d;	text-decoration: none;	border: 0;	background-color: transparent;}
body,div,q,iframe,form,h5{	margin: 0;	padding: 0;}
img,fieldset { border: none 0; }
body,td,textarea {	word-break: break-all;	word-wrap: break-word;	line-height:1.5;}
body,input,textarea,select,button {	margin: 0;	font-size: 12px;	font-family: Tahoma, SimSun, sans-serif;}
div,p,table,th,td {	font-size:1em;	font-family:inherit;	line-height:inherit;}
h5{ font-size:12px;}
</style>
<script type="text/javascript" src="../js/Dialog.js"></script>
<script>
function zOpen(url,name,x,y){
	var diag = new Dialog("Diag2");
	diag.Width = x;
	diag.Height = y;
	diag.Title = name;
	diag.URL = url;
	diag.OKEvent = zAlert;//点击确定后调用的方法
	diag.show();
}
function zAlert(){
	
}

</script>

</head>
<body topmargin=0 leftmargin=0 style="background:#FFFFFF">

 
<table border=0 width=100% height=100% cellpadding=0 cellspacing=0>
  <tr>
	
	<td valign=top align="left">
 
	    <table border=0 width=100% height=100% cellpadding=0 cellspacing=0>
		  <tr>
		    <td height=29 background="../images/main-02.gif"><img src="../images/main-01.gif"></td>
		  </tr>
	      <tr>
		    <td>
 
			  <table border=0 width=100% height=100% cellpadding=0 cellspacing=0 align=center>
			    <tr>
				  <td>
				  
					<table border=0 width=100% cellpadding=0 cellspacing=0 align=center>
					  <tr>
						<td>
 
						  <table border=0 width=100% align=center>
							<tr height=80>
		 <%if strSelectIn > 0 then%>
		<td align=center><a href="#" onclick=window.parent.main.location.href='../report/kc_bill.asp?type=rk'
		><img src="../images/depot_loseS.gif" border=0><BR>其他入库</a></td>
		 <%end if%>				 
		 <%if strSelectOut > 0 then%>				 
		<td align=center><a href="#" onclick=window.parent.main.location.href='../report/kc_bill.asp?type=ck'
		><img src="../images/depot_loseY.gif" border=0><BR>其他出库</a></td>
		<%end if%>					 
		<%if strAddDB > 0 then%>				 
		 <td align=center><a href="#"  onclick=window.parent.main.location.href='../report/kc_bill.asp?type=db'
		 ><img src="../images/depot_move.gif" border=0><BR>仓库调拨</a></td>
		<%end if%>					</tr>
		<tr height="50">
		 <td></td>
		</tr>
						
			<tr height=80>
		<%if strAddPD > 0 then%>
		 <td align=center><a href="#" onclick=window.parent.main.location.href='../report/kc_bill.asp?type=pd'><img src="../images/depot_number.gif" border=0><BR>库存盘点</a></td>
		 <%end if%>
		 <%if strAddLL > 0 then%>
		 <td align=center><a href="#" onclick=window.parent.main.location.href='../report/kc_bill.asp?type=ll'><img src="../images/depot_price.gif" border=0><BR>部门领料</a></td>
		 <%end if%>
							
		<%if strAddTL > 0 then%>				  
		<td align=center><a href="#"  onclick=window.parent.main.location.href='../report/kc_bill.asp?type=tl'
		><img src="../images/depot_come.gif" border=0><BR>部门退料</a></td>
		<%end if%>
							</tr> 
						  </table>
 
						</td>
					  </tr>
					</table>
 
				  </td>
				  <td width=1 background="../images/main-03.gif"></td>
				  <td width="200" valign="top">
 
					<table border=0 width=85% align=center cellpadding=2 cellspacing=2>
					  <tr height=10>
						<td align=left></td>
					  </tr>
					  <tr height=20>
					  <%if strBorrowDetail > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/GoodsBorrowDetail.asp'
						>领用明细表</a></td>     <%end if%>
					  </tr>
					  <tr height=20>
					  <%if strGoodsBorrowCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/GoodsBorrowCount.asp'
						>货品领用汇总</a></td>
					<%end if%>
					  </tr>
					  <tr height=20>
					  <%if strDepartBorrowCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#"  onclick=window.parent.main.location.href='../report/DepartBorrowCount.asp' >部门领用汇总</a></td>
					<%end if%>	
					  </tr>
					
					  
					</table>
 
				  </td>
				</tr>
			  </table>
 
			</td>
		  </tr>
	      <tr>
		    <td height=1 background="../images/main-04.gif"></td>
		  </tr>
	      <tr>
		    <td  height="50"  align=center>
			  
 
	</td>
  </tr>
</table>

</body>
</html>
