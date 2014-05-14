<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<script type="text/javascript" src="../js/dtree.js"></script>
<script>
function check(){
if (document.employee.name.value=="")
{
alert("请填写员工名称！");
document.employee.name.focus();
return false; 
}
if ($("#birthday").val() == "")
{
alert("员工生日不能为空！");
$("#birthday").focus();
return false; 
}
}
function check_name(){
	if ($("#name").val() == "") {
		$("#div_check_name").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>不能为空</font></strong></li>");
	}else{
    $.post("../select/addemployee_ajax_name.asp",{name:escape($("#name").val())},
	function(data)
	{ 
       if (data == "True"){
		   $("#div_check_name").attr("innerHTML","<img src='../img/btn_true.gif'>"); 
		   }else{
		   $("#div_check_name").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>员工名称重复</font></strong></li>"); 
	   }
	}
	);	
	}
}
function check_date(){
    $.post("../select/addemployee_ajax_date.asp",{name:escape($("#birthday").val())},
	function(data)
	{ 
       if (data == "True"){
		   $("#div_check_date").attr("innerHTML","<img src='../img/btn_true.gif'>"); 
		   }else{
		   $("#div_check_date").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>输入格式不正确</font></strong></li>"); 
	   }
	}
	);	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>员工信息</title>
</head>

<body bgcolor="#F3F1E9"><br>
<div align="center"><span class="STYLE1">员工信息</span></div>
<p><br>
</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><b><font color="#ff0000">免费版不提供此功能 请联系小二科技购买商业版 http://www.hokilly.com/ 咨询QQ：15916190</font></b></p>
</body>
</html>
