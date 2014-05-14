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
<html>

<head>
<title></title>
<script language="JavaScript" src="../js/jquery.min.js"></script>
<script language="JavaScript" src="../js/jQuery.timers.js"></script>
<script language=javascript>

jQuery(document).ready(function(){ 
$(".ww").hover(
	function(){
		var _s=document.getElementById('snd');
			_s.src = '../sound/click_01.wav';					
	},
	function(){
		var _s=document.getElementById('snd');
			_s.src = '';			
	}); 				
});


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
</script>
<STYLE type=text/css>
BODY {
	PADDING-RIGHT: 0px;
	PADDING-LEFT: 0px;
	PADDING-BOTTOM: 0px;
	MARGIN: 0px;
	PADDING-TOP: 0px;
	font-size: 12px;
}
#top {
	background-image: url(../img/top.jpg);
	background-repeat: no-repeat;
	background-position: left;
	height: 67px;
	width: 100%;
	overflow: hidden;
	font-size: 12px;
	color: #f1f1f1;
}

#txt {
	font-size: 12px;
	color: #FFF;
}
a:link {
	color: #fff;
	text-decoration: none;
	font-size: 12px;
}
a:visited {
	color: #fff;
	text-decoration: none;
	font-size: 12px;
}
a:hover {
	color: #fff;
	text-decoration: underline;
	font-size: 12px;
}
img {
  border:0px;
}
}
</STYLE>

</head>

<body>
<bgsound id="snd">
<table width="100%" height="67" border="0" cellpadding="0" cellspacing="0" background="../img/topbg1.jpg">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="146"  background="../img/top_logo.jpg"  style="border:5 solid #ffCCCC"><div style="font-weight:bold;font-family:黑体,宋体;color:#10365B;font-size:12px;margin-top:13px;margin-left:100px;">V<%=version%></div></td>
        <td><table width="100%" border="0" align="right" cellpadding="0" cellspacing="0" id="txt">
          <tr>
          	<td width="25%"><div class="alert"></div></td>
            <td width="25%"><div class="message"></div></td>
            <td><img src="../img/admin.gif" width="15" height="19">当前登录人：<%=request.cookies("username")%></td>
            <td><img src="../img/date.gif" width="18" height="16">今天：<%=year(date())%>年<%=month(date())%>月<%=day(date())%>日
            	<FONT id=Clock face=Arial color=#000080 size=4 align="center"></FONT>&nbsp;&nbsp;<%=weekdayname(weekday(now))%></td>
	        	<td><a href="#" onClick="about()">关于我们</a></td>
			<td><img src="../img/exit.gif" width="15" height="16"><a href="../action/exit.asp" target="_parent"><font color="#ffffff">退出</font></a></td>
            </tr>
        </table></td>
      </tr>
      <tr>
        <td height="35">&nbsp;</td>
        <td><table width="870" border="0" align="left" cellpadding="0" cellspacing="0">
          <tr>
            <td><a href="main.asp" target="main"><img class="ww" src="../img/top_4.jpg" width="93" height="27"></a></td>
            <%if strAddCG > 0 then%>
            <td><a href="#" onClick="NewBill('CG')"><img class="ww" src="../img/top_6.jpg" width="93" height="27"></a></td>
            <%end if%>
            <%if strAddXS > 0 then%>
			<td><a href="#" onClick="NewBill('XS')"><img class="ww" src="../img/top_10.jpg" width="93" height="27"></a></td>
            <%end if%>
            <%if strDepotCount > 0 then%>
			<td><a href="../report/depotcount.asp" target="main"><img class="ww" src="../img/top_20.jpg" width="93" height="27"></a></td>
            <%end if%>
            <%if strDepotNum > 0 then%>
            <td><a href="../report/viewdepot.asp" target="main"><img class="ww" src="../img/top_8.jpg" width="93" height="27"></a></td>
            <%end if%>
            <%if strDepotWarn > 0 then%>
            <td><a href="../report/depotwarn.asp" target="main"><img class="ww" src="../img/top_12.jpg" width="93" height="27"></a></td>
            <%end if%>
            <%if strBrowseCustom > 0 then%>
            <td><a href="../common/custom.asp" target="main"><img class="ww" src="../img/top_14.jpg" width="93" height="27"></a></td>
            <%end if%>
            <%if strBrowseGoods > 0 then%>
            <td><a href="../common/goods.asp" target="main"><img class="ww" src="../img/top_16.jpg" width="93" height="27"></a></td>
            <%end if%>
            <td><a href="#" onClick="JavaScript:window.open ('../common/backup.asp', 'newwindow', 'left=150,top=150,height=400, width=400, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img class="ww" src="../img/top_18.jpg" width="93" height="27"></a></td>
            </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>

</html>
