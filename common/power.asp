<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>权限设置</title>
<style type="text/css">
<!--
.STYLE2 {color: #000000
}
#ttt{display;none;}
-->
</style>
<script language="JavaScript" src="../js/jquery.js"></script>
<script language=javascript>


$(document).ready(function() {
	// do something here
	$("table").hide();
});

function checkAll(e, itemName){
var aa = document.getElementsByName(itemName);
for (var j=0; j<aa.length; j++)
aa[j].checked = e.checked;
}
function checkItem(e, allName){
var all = document.getElementsByName(allName)[0];
if(!e.checked) all.checked = false;
else{
var aa = document.getElementsByName(e.name);
for (var j=0; j<aa.length; j++)
if(!aa[j].checked) return;
all.checked = true;
}
}
function hidetable(str){
	if(!$("#t"+str).is(":hidden")){
		$("#t"+str).hide();
		$("#img"+str).attr("src","../img/open.gif"); 
	}else{
		$("#t"+str).show();	
		$("#img"+str).attr("src","../img/close.gif");
	}
}

</script>
</head>

<body style="background:#FFFFFF" >
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><b><font color="#ff0000">免费版不提供此功能 请联系小二科技购买商业版 http://www.hokilly.com/ 咨询QQ：15916190</font></b></p>
</body>

</html>
