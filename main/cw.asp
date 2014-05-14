<!-- #include file="../inc/conn.asp" -->
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
'response.write strPower
strAddFK = instr(strPower,"AddFK")
strBrowseFK = instr(strPower,"BrowseFK")
strAddSK = instr(strPower,"AddSK")
strBrowseSK = instr(strPower,"BrowseSK")
strAddSR = instr(strPower,"AddSR")
strBrowseSR = instr(strPower,"BrowseSR")
strAddZC = instr(strPower,"AddZC")
strBrowseZC = instr(strPower,"BrowseZC")
strDailyAccount = instr(strPower,"DailyAccount")
strTotalAccount = instr(strPower,"TotalAccount")
strBillFKCount = instr(strPower,"BillFKCount")
strCustFKCount = instr(strPower,"CustFKCount")
strBillSKCount = instr(strPower,"BillSKCount")
strCustSKCount = instr(strPower,"CustSKCount")
intCW = cint(strAddFK) + cint(strBrowseFK) + cint(strAddSK) + cint(strBrowseSK) + cint(strAddSR) + cint(strBrowseSR) + cint(strAddZC) + cint(strBrowseZC) + cint(strDailyAccount) + cint(strTotalAccount) + cint(strBillFKCount) + cint(strCustFKCount) + cint(strBillSKCount) + cint(strCustSKCount)
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
						<%if strDailyAccount > 0 then%>
 <td align=center><a href="#" onclick=window.parent.main.location.href='../report/account.asp'><img src="../images/fund_move.gif" border=0><BR>帐户查询</a></td> 
						<%end if%>
							 
						<%if strBrowseFK > 0 then%> 
 <td align=center><a href="#" onclick=window.parent.main.location.href='../cash/cash.asp?type=FK'
 ><img src="../images/fund_cpay.gif" border=0><BR>付款单</a></td>                    
                        <%end if%>
							 
						<%if strBrowseSK > 0 then%>	 
<td align=center><a href="#" onclick=window.parent.main.location.href='../cash/cash.asp?type=SK'
><img src="../images/fund_spay.gif" border=0><BR>收款单</a></td>
						<%end if%>
							</tr>
							<tr height="50">
							    <td></td>
							</tr>
							
							<tr height=80>
						<%if strBrowseSR > 0 then%>	
<td align=center><a href="#" 
onclick=window.parent.main.location.href='../cash/income.asp'
><img src="../images/fund_come.gif" border=0><BR>其他收入</a></td>
 						<%end if%>
						<%if strBrowseZC > 0 then%>
 <td align=center><a href="#" onclick=window.parent.main.location.href='../cash/expend.asp'
 ><img src="../images/fund_sendA.gif" border=0><BR>其他支出</a></td> 					<%end if%>
							
						<%if strTotalAccount > 0 then%>						  
<td align=center><a href="#" onClick="zOpen('./report/Totalaccount.asp','帐户余额查询',700,400)"><img src="../images/fund_sendB.gif" border=0><BR>帐户余额查询</a></td>
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
					  <%if strBillFKCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" 
						onclick=window.parent.main.location.href='../report/cashcount_bill.asp?type=FK'
						>未付账单据一览</a></td>
					 <%end if%>	
					  </tr>
					  <tr height=20>
					  <%if strCustFKCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/cashcount_cust.asp?type=FK'
						>应付账款表</a></td>
					<%end if%>
					  </tr>	
					  <tr height=20>
					  <%if strBillSKCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/cashcount_bill.asp?type=SK'
						>未收账单据一览</a></td>
					<%end if%>
					  </tr>
					  <tr height=20>
					  <%if strCustSKCount > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../report/cashcount_cust.asp?type=SK'
						>应收账款表</a></td>
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
