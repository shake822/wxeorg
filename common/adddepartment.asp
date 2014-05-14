<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<script type="text/javascript" src="../js/jQuery.js"></script>
<script type="text/javascript" src="../js/dtree.js"></script>
<script>


function check_name(){
	if ($("#departname").val() == "") {
		$("#div_check_name").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>不能为空</font></strong></li>");
	}else{
    $.post("../select/adddepartment_ajax_name.asp",{name:escape($("#departname").val())},
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

function check(){
if (document.department.departname.value=="")
{
alert("请输入部门名称！");
document.department.departname.focus();
return false; 
}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<title>部门资料</title>
</head>

<body style="background:#FFFFFF">
<div align="center"><span class="style1">部门资料</span></div>
<form name="department" method="post" onSubmit="return check()" action="../action/savedepartment.asp?add=true">
<table style="margin-left:280px" width="600" border="0" align="center">
  <tr>
    <input type="hidden" name="Departid" value=>
    <td width="100" align="right">部门名称</td>
    <td width="300" align="left"><input type="text" onBlur="check_name();" name="departname" id="departname" size="30" value=><font color="#FF0000">*</font></td>
    <td width="200"><div id="div_check_name" ></div></td>
  </tr>
  <tr>
    <td width="100" align="right">联&nbsp;系&nbsp;人</td>
    <td width="192" align="left"><input type="text" name="contact" id="contact" size="10" value=></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">电&nbsp;&nbsp;&nbsp;&nbsp;话</td>
    <td align="left"><input type="text" name="tel" id="tel" size="16" value=></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">手&nbsp;&nbsp;&nbsp;&nbsp;机</td>
    <td align="left"><input type="text" name="mobile" id="mobile" size="16" value=></td>
    <td></td>
  </tr>
  <tr>
    <td align="right">地&nbsp;&nbsp;&nbsp;&nbsp;址</td>
    <td colspan="2" align="left"><input type="text" name="address" id="address" size="50" value=></td>
  </tr>
  <tr>
    <td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注</td>
    <td colspan="2" align="left"><input type="text" name="memo" id="memo" size="59" value=></td>
  </tr>
  <tr>
    <td  align="" width="100" valign="top">
    <input type="submit" class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value=" 保 存 ">
	</td>
   <td  align="" width="65" valign="top">
   
     
    <input type="reset" class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value=" 重 置 "></td>
	 <td  align="left"></td>
  </tr>
</table>
</form>


</body>
</html>
