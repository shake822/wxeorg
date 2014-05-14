<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<script type="text/javascript" src="../js/jQuery.js"></script>
<script language="JavaScript" src="../js/ShowHideDiv.js"></script>
<script type="text/javascript" src="../js/dtree.js"></script>
<script language="JavaScript">
function clicknode(nodename,nodecode){
	if (document.getElementById("nodename")!=null){
		document.getElementById("nodename").value = String(nodename);	
	}
	if (document.getElementById("typecode")!=null){
		document.getElementById("typecode").value = String(nodecode);	
	}	
	closeProc();
}

function check_name(){
	if ($("#custname").val() == "") {
		$("#div_check_name").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>不能为空</font></strong></li>");
	}else{
    $.post("../select/addcust_ajax_name.asp",{name:escape($("#custname").val())},
	function(data)
	{ 
       if (data == "True"){
		   $("#div_check_name").attr("innerHTML","<img src='../img/btn_true.gif'>"); 
		   }else{
		   $("#div_check_name").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>往来单位名称重复</font></strong></li>"); 
	   }
	}
	);	
	}
}

function formsubmit(){
	if (document.cust.custname.value==""){
		alert("请输入往来单位名称！");
		document.cust.custname.focus();
		return false; 
	}
	if ("<%=Request.QueryString("add")%>" == "true"){
		
	}
	document.cust.submit();
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
  //document.body.style.overflow = "hidden";
  document.body.style.overflow = "auto";
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
</script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<title>往来单位</title>
</head>

<body style=""padding:0px;margin:0px;"" onmousemove="movediv(event)" onmouseup="obj=0">
<%
sqlCust = "select * from t_custom where custname = '" & Request.QueryString("custname") & "'"
set rsCust = Server.CreateObject("adodb.recordset")
rsCust.open sqlCust, conn, 1, 1

if Request.QueryString("add") = "false" then
	sAction = "../action/savecust.asp?add=false"
	sCustid = rsCust("CustID")
	sCustName = rsCust("CustName")
	sContact = rsCust("Contact")
	sAddress = rsCust("Address")
	sTel = rsCust("Tel")
	sZip = rsCust("Zip")
	sFax = rsCust("fax")
	sCustType = rsCust("custtype")
	sTypeCode = rsCust("code")
	sEmail = rsCust("email")
	sBankName = rsCust("bankname")
	sMobile = rsCust("mobile")
	sBankAccount = rsCust("bankaccount")
	sTaxCode = rsCust("taxcode")
	sFR	= rsCust("fr")
	sURL = rsCust("url")
	sMemo = rsCust("memo")
	sStartmoneyf = rsCust("startmoneyf")
	sStartmoneys = rsCust("startmoneys")
	sCheckGoodsName = ""
else
	sAction = "../action/savecust.asp?add=true"
	sCustid = "" 
	sCustName = ""
	sContact = ""
	sAddress = ""
	sTel = ""
	sZip = ""
	sFax = ""
	sCustType = ""
	sTypeCode = ""
	sEmail = ""
	sBankName = ""
	sMobile = ""
	sBankAccount = ""
	sTaxCode = ""
	sFR	= ""
	sURL = ""
	sMemo = ""
	sStartmoneyf = "0"
	sStartmoneys = "0"
	sCheckGoodsName = "<div id=""div_check_name"" ></div>"
end if
%>

<div align="center"><span class="style1">往来单位资料</span></div>
<form name="cust" method="post" action="<%=sAction%>">
<table width="600" border="0" align="center">
  <tr>
    <input type="hidden" name="custid" value=<%=sCustid%>>
    <td width="100" align="right">往来单位名称</td>
    <td width="300" align="left"><input type="text" onBlur="check_name();" name="custname" id="custname" size="30" value=<%=sCustName%>><font color="#FF0000">*</font></td>
    <td width="200"><%=sCheckGoodsName%></td>
  </tr>
  <tr>
    <td align="right">往来单位分类</td>
    <td align="left">
      <input type="text" name="nodename" id="nodename" size="13" value=<%=sCustType%>><a href="#" onClick="showProc()"><img border="0" src="../img/choose.gif" width="21" height="17"></a></label><input type="hidden" name="typecode" id="typecode" value=<%=sTypeCode%>>
	</td>
    <td></td>
  </tr>
  <tr>
    <td width="100" align="right">联系人</td>
    <td width="192" align="left"><input type="text" name="contact" id="contact" size="10" value=<%=sContact%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">电话</td>
    <td align="left"><input type="text" name="tel" id="tel" size="16" value=<%=sTel%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">手机</td>
    <td align="left"><input type="text" name="mobile" id="mobile" size="16" value=<%=sMobile%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">邮编</td>
    <td align="left"><input type="text" name="zip" id="zip" size="16" value=<%=sZip%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">传真</td>
    <td align="left"><input type="text" name="fax" id="fax" size="16" value=<%=sFax%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">地址</td>
    <td colspan="2" align="left"><input type="text" name="address" id="address" size="50" value=<%=sAddress%>></td>
  </tr>
  <tr>
    <td align="right">E_MAIL</td>
    <td align="left"><input type="text" name="email" id="email" size="28" value=<%=sEmail%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">开户银行</td>
    <td align="left"><input type="text" name="bankname" id="bankname" size="16" value=<%=sBankName%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">银行账号</td>
    <td align="left"><input type="text" name="BankAccount" id="BankAccount" size="16" value=<%=sBankAccount%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">纳税号</td>
    <td align="left"><input type="text" name="taxcode" id="taxcode" size="16" value=<%=sTaxCode%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">期初应付款</td>
    <td><input type="text" name="startmoneyf" id="startmoneyf" size="16" value="<%=sStartmoneyf%>"></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">期初应收款</td>
    <td><input type="text" name="startmoneys" id="startmoneys" size="16" value="<%=sStartmoneys%>"></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">法人代表</td>
    <td align="left"><input type="text" name="fr" id="fr" size="10" value=<%=sFR%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">网址</td>
    <td align="left"><input type="text" name="url" id="url" size="28" value=<%=sURL%>></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">备注</td>
    <td colspan="2" align="left"><input type="text" name="memo" id="memo" size="59" value=<%=sMemo%>></td>
  </tr>
 
  <tr>
    <td colspan="3" align="center">
    <input type="hidden" name="userlist" id ="userlist" value="">
    <input type="button" class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value=" 保 存 " onClick="formsubmit()">
    <input type="reset" class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value=" 重 置 ">
    </td>
  </tr>
</table>
</form>
<div align="center"><span class="style1"></span></div>
<div id="message_box" style="position:absolute;left:45%;top:10%;width:250px;height:400px;filter:dropshadow(color=#666666,offx=3,offy=3,positive=2);z-index:1000;visibility:hidden">
   <div id= "message" style="border:#036 solid; border-width:1 1 3 1;width:95%; height:95%; background:#fff; color:#036; font-size:12px; line-height:150%;">
    <!-- DIV弹出状态行：标题、关闭按钮 -->
    <div style="background:#7DC6F0;height:5%;font-family:宋体; font-size:13px; padding:3 5 0 5; color:#00385E" onMouseDown="drag(message_box);return false">
     <span style="display:inline;width:100%;position:absolute;font-size:120%">单击选择类别</span>
     <span onClick="closeProc();" style="float:right;display:inline;cursor:pointer;font-size:150%">×</span>
    </div>
<script language="JavaScript">
	d = new dTree('d');
	<%
    Response.Write "d.add(0,-1,'往来单位分类','edittree.asp?type=cust&name="&s_name&"&id="&i_id&"&pid=0');"
		sql_gtype = "select * from t_tree where type='cust'"
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
<%endconnection%>
</body>
</html>
