<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>修改密码</title>
<style type="text/css">
<!--
#noborder{
  border=0;
}
-->
</style>
<script language="JavaScript" src="../js/jquery.js"></script>
<script language=javascript>
function check(){
if (document.password.newpassword1.value=="")
{
alert("请输入新密码！");
document.password.newpassword1.focus();
return false;
}
if (document.password.newpassword1.value!=document.password.newpassword2.value)
{
alert("2次密码不一致！");
document.password.newpassword1.focus();
return false;
}
}
	   
</script>
</head>

<body>
<br>

<div align="center"><span class="style1">修改密码</span>
<form name="password" method="post" action="../action/changepassword.asp?username=<%=request.cookies("username")%>">
<table border="0" id="noborder">
  <tr valign="middle">
    <td width="100" align="right">旧密码</td>
    <td width="140"><input name="oldpassword" id="oldpassword" size="16" type="password"></td><td></td>
  </tr>
  <tr valign="middle">
    <td align="right">新密码</td>
    <td><input name="newpassword1" id="newpassword1" size="16" type="password" ></td>
  </tr>
  <tr valign="middle">
    <td align="right">确认新密码</td>
    <td><input name="newpassword2" id="newpassword2" size="16" type="password"></td><td></td>
  </tr>
</table></div>
<br>
<div align="center"><input class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  type="submit" onClick="return check();" value=" 保存 "></div>
</form>
</body>
</html>
