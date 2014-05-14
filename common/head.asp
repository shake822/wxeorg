<!-- #include file="../inc/conn.asp" -->
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
strAddCG = instr(strPower,"AddCG")
strAddXS = instr(strPower,"AddXS")
strDepotCount = instr(strPower,"DepotCount")
strDepotDetail = instr(strPower,"DepotDetail")

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
<meta http-equiv='Content-Type' content='text/html; charset=Gb2312;'>
<link rel="stylesheet" href="../skin.css"  type="text/css">
<script language="JavaScript" src="../js/jquery.min.js"></script>
<script language="JavaScript" src="../js/jQuery.timers.js"></script>
<script language=javascript>
//
//jQuery(document).ready(function(){ 
//$(".ww").hover(
//	function(){
//		var _s=document.getElementById('snd');
//			_s.src = '../sound/click_01.wav';					
//	},
//	function(){
//		var _s=document.getElementById('snd');
//			_s.src = '';			
//	}); 				
//});
//

function loginout(){
	window.parent.location.reload()
}

function tick() {
   var today
   today = new Date()
   Clock.innerHTML = today.toLocaleString()
   Clock2.innerHTML = TimeAdd(today.toGMTString(), CLD.TZ.value)
   window.setTimeout("tick()", 1000);
}

function about(){
	window.open ('about.asp', 'newwindow', 'height=250, width=330,top=200,left=250,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}
function openwin(URL,x,y){
var URL;
var x1=window.screen.width;
var y1=window.screen.height;
x2=(x1-x)/2;
y2=(y1-y)/2;
window.open(URL,'','top='+y2+',left='+x2+',width='+x+',height='+y+',status=yes,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes')
}
function NewBill(str){
openwin('../bills/addbill.asp?type='+str,900,600)

}

 
function frm_password()
{
	alert('该功能禁止使用');
}
 
function frm_backup()
{
	alert('该功能禁止使用');
}

</script>
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
</HEAD>
<body leftmargin="0" topmargin="0">
 

 
<table border=0 width=100% height=45 cellpadding=0 cellspacing=0 background="../images/head-01.gif">
  <tr>
    <td width="392"><img src="../images/head-02.gif" border=0></td>
	<td width="96"><span style=" margin-top:0px"><font size="2" color="#FFFFFF" ><strong>V<%=version%></strong></font></span></td>
	<td align=right>
 
	  <table border=0 cellpadding=0 cellspacing=0 >
	    <tr height=20>
		  		  <td width=80 align=center><img src="../images/pos.png"	 align="absmiddle">&nbsp;<a href="#"  onClick="javascript:window.parent.main.location.href='../common/main.asp';"><font color=#FFFFFF>桌面</font></a></td>
			<%if strAddCG > 0 then%>	  
		  <td width=80 align=center><img src="../images/number.png"	 align="absmiddle">&nbsp;<a href="#" onClick="NewBill('CG')"><font color=#FFFFFF>采购入库</font></a></td>
		  <%end if%>
		   <%if strAddXS > 0 then%>
		  <td width=80 align=center><img src="../images/jxc.png"	 align="absmiddle">&nbsp;<a href="#" onClick="NewBill('XS')"><font color=#FFFFFF>销售出库</font></a></td>
		  <%end if%>
		 
		  <%if strDepotNum > 0 then%>
		  <td width=80 align=center><img src="../images/backup.png"	 align="absmiddle">&nbsp;
		  <a href="#" onclick=window.parent.main.location.href='../report/viewdepot.asp'  ><font color=#FFFFFF>库存查询</font></a></td>
		  <%end if%>
		  
		  
		  <%if strBrowseCustom > 0 then%>
		  <td width=80 align=center><img src="../images/logout.png"	 align="absmiddle">&nbsp;
		  <a href="#" onclick=window.parent.main.location.href='../common/custom.asp'  ><font color=#FFFFFF>往来单位</font></a></td>
		  <%end if%>
		   <%if strBrowseGoods > 0 then%>
		    <td width=80 align=center><img src="../images/logout.png"	 align="absmiddle">&nbsp;
			<a href="#"  onclick=window.parent.main.location.href='../common/goods.asp'><font color=#FFFFFF>货品资料</font></a></td>
			<%end if%>
			 <%if strDepotDetail > 0 then%>
		    <td width=80 align=center><img src="../images/logout.png"	 align="absmiddle">&nbsp;
			<a href="#"  onclick=window.parent.main.location.href='../report/viewdetail.asp'><font color=#FFFFFF>库存明细</font></a></td>
			<%end if%>
			
			  <td width=80 align=center><img src="../images/logout.png"	 align="absmiddle">&nbsp;
			  <a href="#" onClick="zOpen('./common/backup.asp','数据备份',600,300)"><font color=#FFFFFF>数据备份</font></a></td>
			  
			    <td width=80 align=center><img src="../images/logout.png"	 align="absmiddle">&nbsp;
				 <a href="#" onClick="zOpen('./common/about.asp','关于我们',450,300)"><font color=#FFFFFF>关于</font></a></td>
				 
			<td width=80 align=center><img src="../images/logout.png"	 align="absmiddle">&nbsp;<a href="../action/exit.asp" target="_parent"><font color=#FFFFFF>退出</font></a></td>
		  		  <td width=5></td>
		</tr>
	  </table>
 
	</td>
  </tr>
</table>
 
</body>
</HTML>
