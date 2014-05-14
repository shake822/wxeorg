<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../inc/config.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<title>增加/修改货品资料</title>
<script type="text/javascript" src="../js/AnPlus.js"></script>
<script type="text/javascript" src="../js/AjaxUploader.js"></script>
<script type="text/javascript" src="../js/jQuery.js"></script>
<div id="uploadContenter" style="background-color:#eeeeee;position:absolute;border:1px #555555 solid;padding:3px;"></div>
<iframe style="display:none;" name="AnUploader"></iframe>
<script type="text/javascript" src="../js/upload.js"></script>
<script language="JavaScript" src="../js/ShowHideDiv.js"></script>
<script type="text/javascript" src="../js/dtree.js"></script>
<script>
function clicknode(nodename,nodecode){
	if (document.getElementById("goodstype")!=null){
		document.getElementById("goodstype").value = String(nodename);	
	}
	if (document.getElementById("typecode")!=null){
		document.getElementById("typecode").value = String(nodecode);	
	}	
	closeProc();
}
function check_code(){
	if ($("#goodscode").val() == "") {
		$("#div_check_code").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li  style='float:left;width:auto'><strong><font color=#FF0000>不能为空</font></strong></li>"); 
	}else{
    $.post("../select/addgoods_ajax_code.asp",{goodscode:escape($("#goodscode").val())},
	function(data)
	{ 
		
       if (data == "True"){
		   $("#div_check_code").attr("innerHTML","<img src='../img/btn_true.gif'>"); 
		   }else{
		   $("#div_check_code").attr("innerHTML","<li style='float:left;width:auto'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>货品编码重复</font></strong></li>");
	   }
	}
	);
	}
}
function check_name(){
	if ($("#goodsname").val() == "") {
		$("#div_check_name").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li  style='float:left;width:auto'><strong><font color=#FF0000>不能为空</font></strong></li>");
	}else{
    $.post("../select/addgoods_ajax_name.asp",{goodsname:escape($("#goodsname").val())},
	function(data)
	{ 
       if (data == "True"){
		   $("#div_check_name").attr("innerHTML","<img src='../img/btn_true.gif'>"); 
		   }else{
		   $("#div_check_name").attr("innerHTML","<li style='float:left;width:auto'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>货品名称重复</font></strong></li>"); 
	   }
	}
	);	
	}
}
function showphoto() {
if (document.getElementById("img").value == "" ){
alert("无相关图片！");
return false;
}
else{
window.open ('photo.asp?img='+document.getElementById("img").value, 'showphoto', 'height=600, width=800,,top=100,left=150,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
}
}

function CreateReturnValue(){
var nodecode=document.getElementById("goodstype");
nodecode.value=document.getElementById('nodename').value; 
}

function check(){
	if (document.getElementById("goodscode").value=="")
	{
	alert("请输入货品编码！");
	document.getElementById("goodscode").focus();
	return false; 
	}
	if (document.getElementById("goodsname").value=="")
	{
	alert("请输入货品名称！");
	document.getElementById("goodsname").focus();
	return false; 
	}
}

function formsubmit(){
	if (document.getElementById("goodscode").value=="")
	{
		alert("请输入货品编码！");
		document.getElementById("goodscode").focus();
		return false; 
	}
	if (document.getElementById("goodsname").value=="")
	{
		alert("请输入货品名称！");
		document.getElementById("goodsname").focus();
		return false; 
	}
	document.form1.submit();
}

function setHiddenRow(oTable,k)
{
   oTable.style.display = oTable.style.display == "none"?"block":"none";
}

function showProc(){
  message_box.style.visibility='visible';
  //创建灰色背景层
  procbg = document.createElement("div"); 
  procbg.setAttribute("id","mybg"); 
  procbg.style.background = "#f7f7f7"; 
  procbg.style.width = "100%"; 
  procbg.style.height = "100%"; 
  procbg.style.position = "absolute"; 
  procbg.style.top = "0"; 
  procbg.style.left = "0"; 
  procbg.style.zIndex = "500"; 
  procbg.style.opacity = "0.3"; 
  procbg.style.filter = "Alpha(opacity=30)"; 
  //背景层加入页面
  document.body.appendChild(procbg);
  document.body.style.overflow = "hidden";
}
//拖动
function drag(obj){  
     var s = obj.style;  
     var b = document.body;   
  var x = event.clientX + b.scrollLeft - s.pixelLeft;   
  var y = event.clientY + b.scrollTop - s.pixelTop; 
 
  var m = function(){  
   if(event.button == 1){  
    s.pixelLeft = event.clientX + b.scrollLeft - x;   
    s.pixelTop = event.clientY + b.scrollTop - y;   
   }else {
    document.detachEvent("onmousemove", m);
   }  
  }  
  document.attachEvent("onmousemove", m);
  if(!this.z) 
   this.z = 999;   
  s.zIndex = ++this.z;   
  event.cancelBubble = true;   
}
 
function closeProc(){
  message_box.style.visibility= "hidden";
  procbg.style.visibility = "hidden";
}
function addoption(obj){


	document.getElementById("units").options.add(new Option(obj,obj));
	
}
</script>
</head>
<body style=""padding:0px;margin:0px;"" onmousemove="movediv(event)" onmouseup="obj=0">

<%
sqlGoods = "select * from t_goods where goodscode='"&Request.QueryString("goodscode")&"'"
set rs_goods = Server.CreateObject("adodb.recordset")
rs_goods.open sqlGoods,conn,1,1

sql_auto = "select goodscode,autogoodscode from T_SoftInfo"
Set rs_auto = conn.Execute(sql_auto)

if rs_auto("autogoodscode") = True then
	sql_code = "select max(goodscode) as maxcode from t_goods"
	sql_code = "select max(goodscode) as maxcode,count(goodscode) as num from t_goods"
	Set rs_code = server.CreateObject("adodb.recordset")
	rs_code.Open sql_code, conn, 1, 1
	If rs_code("num") = 0 Then
	  s_goodscode = rs_auto("goodscode")&"00001"
	Else
		rs_code.movefirst
	  s_goodscode = NewCode(rs_code("maxcode"))
	End If
end if

If Request("add")<>"true" Then
	sAction = "../action/savegoods.asp?type=edit&goodscode="&rs_goods("goodscode")
	sGoodsCode = rs_goods("goodscode")
	sGoodsName = rs_goods("goodsname")
	sGoodsUnit = rs_goods("goodsunit")
	sGoodsType = rs_goods("goodstype")
	sCode = rs_goods("code")
	sUnits = rs_goods("units")
	sBarcode = rs_goods("barcode")
	sInprice = rs_goods("inprice")
	sOutprice = rs_goods("outprice")
	sDepotup = rs_goods("depotup")
	sDepotdown = rs_goods("depotdown")
	sRemark = rs_goods("remark")
	sImg = rs_goods("img")
	sCheckGoodsCode = ""
	sCheckGoodsName = ""
	sGoodsid = rs_goods("goodsid")
else
	sAction = "../action/savegoods.asp?type=add"
	sGoodsCode = s_goodscode
	sGoodsName = ""
	sGoodsUnit = ""
	sGoodsType = ""
	sCode = ""
	sUnits = ""
	sBarcode = ""
	sInprice = "0"
	sOutprice = "0"
	sDepotup = "0"
	sDepotdown = "0"
	sRemark = ""
	sImg = ""
	sCheckGoodsCode = "<div id=""div_check_code"" ></div>"
	sCheckGoodsName = "<div id=""div_check_name"" ></div>"
	sGoodsid = ""
end if
%>
<br>
<div align="center"><span class="STYLE1">货品资料</span></div>
<br>
<form name="form1" method="post" action="<%=sAction%>">
<input type="hidden" name="goodsid" value="<%=sGoodsid%>">
<table align="center" width="100%">
  <tr>
    <td  align="right">货品编码：</td>
    <td width="200">
    	<input type="text" name="goodscode" onBlur="check_code();" id="goodscode" value="<%=sGoodsCode%>">
        <font color="red" color="#FF0000" >*</font>
        <input type="hidden" name="oldcode" value="<%=sGoodsCode%>"></td>
   	<td width="340"><%=sCheckGoodsCode%></td>
  </tr>
  <tr>
    <td align="right">货品名称：</td>
    <td>
    	<input type="text" name="goodsname" onBlur="check_name();" id="goodsname" value="<%=sGoodsName%>">
        <font color="red">*</font></td>
    <td><%=sCheckGoodsName%></td>
  </tr>
  <tr>
    <td align="right">货品类别：</td><input type="hidden" id="typecode" name="typecode" value="<%=sCode%>">
    <td><input type="text" name="goodstype" id="goodstype" value="<%=sGoodsType%>"><a href="#" onClick="showProc()"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">货品规格：</td>   
    <td><input type="text" name="goodsunit" id="goodsunit" value="<%=sGoodsUnit%>"></td>
    <td></td>
  </tr>
  <tr>
	<td align="right">单&nbsp;&nbsp;&nbsp;&nbsp;位：</td>
    <td>
	<select name="units" id="units" >
	<option value=""></option>
	<%
	set t = server.createobject("adodb.recordset")
	sql = "select * from Dict_Units where 1=1"
	t.open sql, conn, 1, 3
	do while not t.eof
		if t("name") = sUnits then
		%>
		<option value="<%=t("name")%>" selected="selected"><%=t("name")%></option>
		<%else%>
		<option value="<%=t("name")%>"><%=t("name")%></option>
		<%
		end if
		t.movenext
	loop
	t.close
	set t=nothing
	%>
	</select>
	<img border="0" src="../img/choose.gif" width="21" height="17"  onclick="openwin('../common/selectunit.asp?table=depart',600,400)"></td>
      <td></td>
  </tr>
  <tr>
    <td align="right">条&nbsp;形&nbsp;码：</td>
    <td><input type="text" name="barcode" id="barcode" value="<%=sBarcode%>"></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">入&nbsp;库&nbsp;价：</td>
    <td><input type="text" name="InPrice" id="InPrice" value="<%=sInprice%>"></td>
    <td></td>
  </tr>
  <tr>
	<td align="right">出&nbsp;库&nbsp;价：</td>
    <td><input type="text" name="OutPrice" id="OutPrice" value="<%=sOutprice%>"></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">库存上限：</td>
    <td><input type="text" name="DepotUp" id="DepotUp" value="<%=sDepotup%>"></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">库存下限：</td>
    <td><input type="text" name="DepotDown" id="DepotDown" value="<%=sDepotdown%>"></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
    <td colspan="2"><input type="text" name="remark" id="remark" size="60" value="<%=sRemark%>"></td>
	<%
	if Request.QueryString("filename") <> "" then
    s_filename = Request.QueryString("filename")
  end if
	%>
  </tr>
</table><br>
<div align="center">
<input name="save" type="button" onClick="formsubmit()" class="button" value=" 保 存 " >
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input name="reset" type="reset" class="button" value=" 重 置 " >
</div>
</form>
<div align="center"><span class="style1"></span></div>
<div id="message_box" style="position:absolute;left:48%;top:20%;width:250px;height:400px;filter:dropshadow(color=#666666,offx=3,offy=3,positive=2);z-index:1000;visibility:hidden">
   <div id= "message" style="border:#036 solid; border-width:1 1 3 1;width:95%; height:95%; background:#fff; color:#036; font-size:12px; line-height:150%;">
    <!-- DIV弹出状态行：标题、关闭按钮 -->
    <div style="background:#7DC6F0;height:5%;font-family:宋体; font-size:13px; padding:3 5 0 5; color:#00385E" onMouseDown="drag(message_box);return false">
     <span style="display:inline;width:100%;position:absolute;font-size:120%">单击选择类别</span>
     <span onClick="closeProc();" style="float:right;display:inline;cursor:pointer;font-size:150%">×</span>
    </div>
<script language="JavaScript">
	d = new dTree('d');
	<%
    Response.Write "d.add(0,-1,'货品分类','edittree.asp?type=goods&name="&s_name&"&id="&i_id&"&pid=0');"
		sql_gtype = "select * from t_tree where type='goods'"
		set rs_gtype = conn.Execute(sql_gtype)
		do while rs_gtype.eof=false
		  i_id=rs_gtype("id")
			i_pid=rs_gtype("pid")
			s_name=rs_gtype("name")
			s_url=rs_gtype("url")
			s_code=rs_gtype("code")
		  Response.Write "d.add("&i_id&","&i_pid&",'"&s_name&"',""javascript:clicknode('"&s_name&"','"&s_code&"')"",'','','','','','"&s_code&"');"
		  rs_gtype.movenext
		loop
		close_rs(rs_gtype)
		%>
	document.write(d);
</script>
</div><!-- message -->
</div><!-- message_box -->
</body>
<%
endconnection
%>
</html>
