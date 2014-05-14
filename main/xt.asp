<!-- #include file="../inc/conn.asp" -->
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
'response.write strPower

%>

<%
strOperator = instr(strPower,"Operator")
strSys = instr(strPower,"SYS")
strCleanData = instr(strPower,"CleanData")
strReg = instr(strPower,"Reg")
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
						<%if strOperator > 0 then%>
							  <td align=center><a href="#" onclick=window.parent.main.location.href='../common/user.asp'><img src="../images/base_client6.gif" border=0><BR>操作员管理</a></td><%end if%>
							 
							 <%if strSys > 0 then%>
							  <td align=center><a href="#"  onclick=window.parent.main.location.href='../common/sys.asp'><img src="../images/system_backup.gif" border=0><BR>系统设置</a></td>                   <%end if%>
							 
							 <%if strCleanData > 0 then%>
							  <td align=center><a href="#"  onclick=window.parent.main.location.href='../common/Clear.asp'><img src="../images/system_rebuild.gif" border=0><BR>数据初始化</a></td><%end if%>
							</tr>
							<tr height=80>
							  <td align=center></td>
							  <td align=center></td>
							  
							  
							  <td align=center></td>
							  
							</tr>
							<tr height=80>
							<%if strReg > 0 then%>
							  <td align=center><a href="#" onClick="zOpen('./common/regedit.asp','软件认证',400,300)"><img src="../images/pay_pdata.gif" border=0><BR>软件认证</a></td><%end if%>
							    <td align=center><a href="#" onclick=window.parent.main.location.href='../common/calendar.htm'><img src="../images/system_resume.gif" border=0><BR>万年历</a></td>
								<%
sql1 = "select * from t_softinfo"
Set rs1 = server.CreateObject("adodb.recordset")
rs1.Open sql1, conn, 1, 1
if rs1("regedit") = True then%>
								 <td align=center><a href="#" onClick="zOpen('./common/changepassword.asp','修改密码',400,300)"><img src="../images/system_rebuild.gif" border=0><BR>修改密码</a></td>
						 <%end if%>
							
							 
							
							</tr> 
						  </table>
 
						</td>
					  </tr>
					</table>
 
				  </td>
				  <td width=1 background="../images/main-03.gif"></td>
				  
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
