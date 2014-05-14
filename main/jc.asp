<!-- #include file="../inc/conn.asp" -->
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
'response.write strPower
strBrowseCustom = instr(strPower,"BrowseCustom")
strBrowseGoods = instr(strPower,"BrowseGoods")
strBrowseEmployee = instr(strPower,"BrowseEmployee")
strBrowseDepot = instr(strPower,"BrowseDepot")
strBrowseUnit = instr(strPower,"BrowseUnit")
strBrowseAccount = instr(strPower,"BrowseAccount")
strBrowseCompany = instr(strPower,"BrowseCompany")
strModel = instr(strPower,"Model")
strBrowseGoods1 = instr(strPower,"BrowseGoods1")
strBrowseDepartment = instr(strPower,"BrowseDepartment")
intBase = cint(strBrowseCustom) + cint(strBrowseGoods) + cint(strBrowseEmployee) + cint(strBrowseDepot) + cint(strBrowseUnit) + cint(strBrowseAccount) + cint(strBrowseCompany) + cint(strModel) + cint(strBrowseGoods1) + cint(BrowseDepartment)
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
	<%if strBrowseCustom > 0 then%>
	<td align=center><a href="#" onclick=window.parent.main.location.href='../common/custom.asp'><img src="../images/pay_proce.gif" border=0><BR>往来单位资料</a></td>
	<td align=center><a href="#" onclick=window.parent.main.location.href='../common/edittree.asp?type=cust'><img src="../images/depot_check1.gif" border=0><BR>往来单位分类</a></td>
	 <%end if%>
							 
	<%if strBrowseGoods > 0 then%>		 		 
	<td align=center><a href="#" onclick=window.parent.main.location.href='../common/goods.asp'><img src="../images/base_goods.gif" border=0><BR>货品资料</a></td>
			      </tr>
							
	<tr height=80>
	<td align=center><a href="#" onclick=window.parent.main.location.href='../common/edittree.asp?type=goods'><img src="../images/depot_begin.gif" border=0><BR>货品分类</a></td>
 <td align=center><a href="#"  onclick=window.parent.main.location.href='../common/importgoods.asp'><img src="../images/system_logout.gif" border=0><BR>Excel批量导入货品</a></td>
    <%end if%>
							
	<%if strBrowseGoods1 > 0 then%>				  
	 <td align=center><a href="#" onclick=window.parent.main.location.href='../common/goods1.asp'><img src="../images/system_corp.gif" border=0><BR>批量修改货品分类</a></td>
	 <%end if%>
		         </tr> 
				<tr height=80>
	<%if strBrowseEmployee > 0 then%>				
	<td align=center><a href="#" onclick=window.parent.main.location.href='../common/employee.asp' ><img src="../images/base_emplee.gif" border=0><BR>员工信息</a></td>
	<%end if%>					 
	<%if strBrowseDepot > 0 then%>					 
	<td align=center><a href="#" onclick=window.parent.main.location.href='../common/depot.asp'><img src="../images/base_depot.gif" border=0><BR>仓库资料</a></td>
	<%end if%>					 
	<%if strBrowseDepartment > 0 then%>					 
    <td align=center><a href="#" onclick=window.parent.main.location.href='../common/department.asp'><img src="../images/base_branch.gif" border=0><BR>部门资料</a></td>
	<%end if%>
					</tr>
					<tr height=80>
	<%if strBrowseUnit > 0 then%>	
	 <td align=center><a href="#" onclick=zOpen('./common/unit.asp','计量单位',800,500) ><img src="../images/depot_check2.gif" border=0><BR>计量单位</a></td>
	<%end if%>	
	<%if strBrowseAccount > 0 then%>		 
	 <td align=center><a href="#" onclick=window.parent.main.location.href='../common/account.asp'><img src="../images/base_member.gif" border=0><BR>帐户信息</a></td>
	<%end if%>						 
	 <%if strBrowseCompany > 0 then%>						 
     <td align=center><a href="#" onClick="zOpen('./common/company.asp','公司信息',600,300)"><img src="../images/base_client3.gif" border=0><BR>公司信息</a></td>
	 <%end if%>
							</tr>
						  </table>
 
						</td>
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
