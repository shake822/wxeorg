<%
path = "1"
%>
<!-- #include file="inc/conn.asp" -->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB2312" />
<script type="text/javascript" language="javascript" src="js/Dialog.js"></script>
<script type="text/javascript" src="js/tab.js"></script>
<script language="javascript">
//var tab=null;
//$( function() {
//	  tab = new TabView( {
//		containerId :'tab_menu',
//		pageid :'page',
//		cid :'tab_po',
//		position :"bottom"
//	});
//	tab.add( {
//		id :'tab1_id_index1',
//		title :"导航图",
//		url :"./common/main.asp",
//		isClosed :false
//	});
//$("#tab1_id_index1").click(function(){   
//  //在文档加载之后为ul下的所有a节点注册鼠标点击事件   
//     window.main.location.href='./common/main.asp'  
//   }); 
//	
//});
//var index=1;
//
//function addTab(uid,name,url){
//   
//	var id='tab5_id_index'+uid;
//	var name=name
//	var url=url;
//     tab.add( {
//		id :id,
//		title:name, 
//	
//	    isClosed :true
//    	});
//	
//	$("#tab5_id_index"+uid).click(function(){  
//	    window.main.location.href=url  
//	 });
//
//	 
//	 
// index++;
//  
//}
</script>
<title>红金羚进销存管理系统辉煌版（BS版仓库管理软件）</title>
<style type="text/css">
<!--
.style1 {
	font-size: 12px;
}
a:link {
	color: #FFFFFF;
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: none;
}
a:active {
	text-decoration: none;
}
-->
.coolscrollbar 
{scrollbar-arrow-color:yellow;
scrollbar-base-color:#73a2d6;}

@IMPORT url("style/tab.css");

h2 {
	background-color: #cccccc;
	padding: 0px;
	font-size: 18px;
	font-family: "黑体";
}

#tab_menu {
	padding: 0px;
	width: 100%;
	height: 28px;
	overflow: hidden;
}

#page {
	width: 800px;
	height: 400px;
	border: solid 1px #cccccc;
	/*height: expression(parentNode . parentNode . offsetHeight-25);*/
}
body {background: #ffffff;	color: #444;}
a{	color: #09d;	text-decoration: none;	border: 0;	background-color: transparent;}
body,div,q,iframe,form,h5{	margin: 0;	padding: 0;}
img,fieldset { border: none 0; }
body,td,textarea {	word-break: break-all;	word-wrap: break-word;	line-height:1.5;}
body,input,textarea,select,button {	margin: 0;	font-size: 12px;	font-family: Tahoma, SimSun, sans-serif;}
div,p,table,th,td {	font-size:1em;	font-family:inherit;	line-height:inherit;}
h5{ font-size:12px;}
</style>

<script language="javascript">

window.status = "当前用户：<%response.write request.cookies("username")%>";
<!--
function switchSysBar(){
if (switchPoint.innerText==3){
switchPoint.innerText=4
document.all("frmTitle").style.display="none"
}else{
switchPoint.innerText=3
document.all("frmTitle").style.display=""
}}
  
function locking(){   
	document.all.ly.style.display="block";   
	document.all.ly.style.width=document.body.clientWidth;   
	document.all.ly.style.height=document.body.clientHeight;   
	document.all.Layer2.style.display='block';  
}   
function Lock_CheckForm(theForm){   
	document.all.ly.style.display='none';document.all.Layer2.style.display='none';
	return false;   
} 
//-->
</script>

<%
sql = "select * from t_softinfo"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
if rs("regedit") = True then
  Response.Write "<body style=""padding:0px;margin:0px;"" scroll=no>"
else
  Response.Write "<body style=""padding:0px;margin:0px;"" scroll=no onLoad=""locking();"">"
end if

If request.cookies("username") = "" Then
    response.Redirect "login.asp"
End If
%>
<body>
<div id="ly" style="position:absolute;top:0px;filter:alpha(opacity=60);background-color:#777;z-index:2;left:0px;display:none;"></div>
<!--浮层框架开始-->
<div id="Layer2" class="coolscrollbar" align="center" style="position:absolute;z-index:3;left:expression((document.body.offsetWidth-540)/2);top:expression((document.body.offsetHeight-170)/3);background-color:#fff;display:none;width:600px;height:400px;overflow-x:hidden;overflow-y:auto;">
  <table width="600" height="400" border="0" cellpadding="0" cellspacing="0" style="border:0 solid #e7e3e7;border-collapse:collapse;">
    <tr>
      <td style="background-color:#73A2d6;color:#fff;padding-left:4px;padding-top:2px;font-weight:bold;font-size:12px;" height="10" valign="middle"><div align="right"><a href="JavaScript:;" class="style1" onClick="Lock_CheckForm(this);">[关闭]</a>&nbsp;&nbsp;&nbsp;</div></td>
    </tr>
    <tr style="margin-left:50px;">
      <td align="left" >
<%
set fso=server.CreateObject("Scripting.FileSystemObject")
Set txtFile=fso.OpenTextFile(Server.MapPath("update.txt"))
%>

<%
Response.Write "<PRE style=""margin-left:50px;"">"
While Not txtFile.AtEndOfStream
Response.Write txtFile.ReadLine & "<br>"
Wend
txtFile.Close
Response.Write "<PRE>"
%>

</td>
    </tr>
  </table>
</div>

<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR valign="top">
    <TD colSpan=3 valign="top"><IFRAME style="padding:0px;margin:0px;WIDTH: 100%; HEIGHT: 45px" name=top 
      marginWidth=0 marginHeight=0 src="common/head.asp" frameBorder=0 
      noResize scrolling=no bordercolor="threedface"></IFRAME></TD></TR>
  <TR>
    <TD id=frmTitle valign="top" width=132 height="100%"><iframe id=BoardLeft 
      style="WIDTH:132px; HEIGHT: 100%" name=BoardLeft marginwidth=0 
      marginheight=0 src="common/left1.asp" frameborder=0 
      noresize></iframe></TD>

   
    <TD height="100%"  width="100%" valign="top" align="left" style="margin-left:0px; margin-right:0px" >
           <table width="100%" height="100%"cellSpacing=0 cellPadding=0 border="0">
	         
	    <tr id="page">
	           <td  valign="top"    width="100%" style="background:#3569B2">
			  
		   <IFRAME id=main style="WIDTH:100%; HEIGHT: 100%"   scrolling=yes name=main marginHeight=0 src="common/main.asp" frameBorder=0></IFRAME>
		  
		           </td>
		</tr>
	
	  </table>
	  </TD>
	  
	  
	  </tr>
	
	  </TBODY>
	     <tr>
		     <td colspan="3" background="images/foot.jpg" height="30" id="tab_menu"> </td>
		 </tr>
	   <tr>
	    
	   <td  colspan="3" width="100%" height="22"> <IFRAME id=foot style="WIDTH:100%; HEIGHT: 100%"  noResize scrolling=no   name=foot  src="common/foot.asp" frameBorder=0>
	   </IFRAME></td></tr>
	  </TABLE>
	 
</body>
</html>
 
 
