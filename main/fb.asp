<!-- #include file="../inc/conn.asp" -->
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
'response.write strPower
strAddFP_cg = instr(strPower,"AddFP_cg")
strSelectFP_cg = instr(strPower,"SelectFP_cg")
strAddFP_xs = instr(strPower,"AddFP_sx")
strSelectFP_xs = instr(strPower,"SelectFP_xs")
strInvoicecg = instr(strPower,"invoicecg")
strInvoicexs = instr(strPower,"invoicexs")
intFP = cint(strAddFP_cg) + cint(strSelectFP_cg) + cint(strAddFP_xs) + cint(strSelectFP_xs) + cint(strInvoicecg) + cint(strInvoicexs)

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
						<%if strSelectFP_cg > 0 then%>
							  <td align=center><a href="#" onclick=window.parent.main.location.href='../invoice/invoice.asp?type=KP'
							  ><img src="../images/fund_sendB.gif" border=0><BR>采购收票</a></td>   <%end if  %>
							 
						 <%if strSelectFP_xs > 0 then%>
							  <td align=center><a href="#"  onclick=window.parent.main.location.href='../invoice/invoice.asp?type=SP'
							  ><img src="../images/fund_sendA.gif" border=0><BR>销售开票</a></td>                   <%end if%>
							 
							 
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
					 <% if strInvoicecg > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../invoice/invoicedetail.asp?type=KP'
						>采购收票报表</a></td><%end if%>
					  </tr>
					  <tr height=20>
					  <%if strInvoicexs > 0 then%>
						<td><img src="../images/icon.gif" border=0 align="absmiddle">&nbsp;&nbsp;
						<a href="#" onclick=window.parent.main.location.href='../invoice/invoicedetail.asp?type=SP'>销售收票报表</a></td>
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
