<!-- #include file="../inc/conn.asp" -->
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
'response.write strPower
strBrowseFK = instr(strPower,"BrowseFK")
strSelectCD = instr(strPower,"SelectCD")
strGoodsBuyDetail = instr(strPower,"GoodsBuyDetail")
strGoodsBuyCount = instr(strPower,"GoodsBuyCount")
strCustBuyCount = instr(strPower,"CustBuyCount")
strCGFinish = instr(strPower,"CGFinish")
strcglist = instr(strPower,"cglist")
strSelectCG = instr(strPower,"SelectCG")
intCG = cint(strSelectCD) + cint(strGoodsBuyDetail) + cint(strGoodsBuyCount) + cint(strCustBuyCount) + cint(strCGFinish) + cint(strcglist) + cint(strSelectCG)
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
	Dialog.alert("你点击了一个按钮");
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
							<%if strSelectCD > 0 then%>
							  <td align=center><a href="#" onclick=window.parent.main.location.href='../bills/selectplan.asp?type=CD'><img src="../images/buy_front.gif" border=0><BR>采购订货</a></td>
							  <td align=center width=50><img src="../images/base_right.gif" border=0></td>
							  <%end if%>
							  <%if strSelectCG > 0 then%>
							  <td align=center><a href="#" onclick=window.parent.main.location.href='../Bills/selectbill.asp?type=CG'><img src="../images/buy_comeS.gif" border=0><BR>采购入库</a></td>
							  <td align=center width=50><img src="../images/base_right.gif" border=0></td>
							  <%end if%>
							  <%if strBrowseFK > 0 then%> 
							  <td align=center><a href="#" onclick=window.parent.main.location.href='../cash/cash.asp?type=FK'><img src="../images/fund_cpay.gif" border=0><BR>付款单</a></td>                           <%end if%>
							</tr>
							<tr height=80>
							  <td align=center></td>
							  <td align=center></td>
							  <td align=center><img src="../images/base_down.gif" border=0></td>
							  <td align=center></td>
							  <td align=center><img src="../images/base_up.gif" border=0></td>
							</tr>
							<tr height=80>
							  <td align=center></td>
							  <td align=center></td>
							  <%if strGoodsBuyDetail > 0 then%>
							  <td align=center><a href="#" onclick=window.parent.main.location.href='../report/goodsbuydetail.asp'
							  ><img src="../images/depot_number.gif" border=0><BR>采购明细表</a></td>
							  <%end if%>
							  <%if strSelectCG > 0 then%>
							  <td align=center width=50><img src="../images/base_right.gif" border=0></td>
							  <td align=center><a href="#" onclick=window.parent.main.location.href='../Bills/selectbackbill.asp?type=CT'
							  ><img src="../images/buy_comeT.gif" border=0><BR>采购退货</a></td>						<%end if%>
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
					  <%if strGoodsBuyCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/goodsbuycount.asp'
						>货品采购汇总表</a></td>
						<%end if%>
					  </tr>
					  <tr height=20>
					  <%if strCustBuyCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/custbuycount.asp'
						>供应商采购汇总表</a></td>
						<%end if%>
					  </tr>
					  <tr height=20>
					  <%if strCGFinish > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/orderdetail.asp?type=CD'
						>采购订单完成情况</a></td>
						<%end if%>
					  </tr>
					  <tr height=20>
					  <%if strcglist > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/pricelist.asp?type=CG'>采购单价一览</a></td><%end if%>
					  </tr>
					  <tr height=20>
					      <%if strGoodsBuyDetail > 0 then%>
						 <td ><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;&nbsp;<a href="#" onclick=window.parent.main.location.href='../report/goodsbuydetail.asp'>采购明细表</a></td><%end if%>
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
		    <td height=50></td>
		  </tr>
		</table>
 
	</td>
  </tr>
</table>
</body>
</html>
