<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
path = "1"
%>
<!-- #include file="inc/conn.asp" -->
<%
sql = "select * from t_softinfo"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
if rs("regedit") = True then
  s_username = ""
  s_password = ""
  s_hint = ""
else
  s_username = "user"
  s_password = "123"
  s_hint = "正式版默认用户名及密码为空"
end if
version=rs("version")
rs.close
set rs = nothing
conn.close
set conn = nothing
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>红金羚进销存管理系统辉煌版（BS版仓库管理软件）</title>
<STYLE>
body {
	font-family: "宋体";
	font-size: 12px;
	text-decoration: none;
	background-color: #246DBA;
	font-weight: normal;
	color: #0099CC;
}
.login_box {
	width: 100%;
	margin-top: 50px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
}
.login_box .t{
	width: 800px;
	background-image: url(images/login_top.jpg);
	background-repeat: no-repeat;
	height: 162px;
	margin-top: 0px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;
}
.login_box .c{
	width: 800px;
	background-image: url(images/login_connt.jpg);
	background-repeat: no-repeat;
	height: 188px;
	margin-top: 0px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;

}
.login_box .b{
	width: 800px;
	background-image: url(images/login_bootom.jpg);
	background-repeat: no-repeat;
	background-position: left top;
	height: 157px;
		margin-top: 0px;
	margin-right: auto;
	margin-bottom: 0px;
	margin-left: auto;

}
.user {
	font-size: 12px;
	line-height: 24px;
	font-weight: normal;
	color: #999999;
	height: 24px;
	width: 170px;
}
.password {
	font-size: 12px;
	line-height: 24px;
	font-weight: normal;
	color: #999999;
	height: 24px;
	width: 170px;
	background-repeat: no-repeat;
	background-position: 5px center;
}

input {
	border: 1px solid #BCCBDE;
	height: 24px;
	line-height: 24px;
	text-indent: 0px;
}
.class {
	height: 24px;
	line-height: 24px;
	font-size: 12px;
	color: #006699;
	background-color: #FFFFFF;
}
.img {
	border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	height: 26px;
	width: 60px;
}
</STYLE>

</head>

<body>
<script language="javascript">
function check()
{
if (document.form1.username.value==""||document.form1.password.value=="")
{
alert("请输入用户名称和口令！");
return false;
}
}
</script>
<table  width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" align="center">
  <tr>
    <td align="center" valign="middle"><div class="login_box">
      <div class="t"></div>
      <div class="c">
        <form action="action/checklogin.asp" method="post" name="form1" id="form1">
          <table width="297" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
        <td height="55"></td>
        <td height="55">&nbsp;</td>
        </tr>
            <tr>
              <td height="35">登录名：</td>
              <td height="35"><input name="username" class="user" type="text" value="<%=s_username%>" /></td>
            </tr>
            <tr>
              <td height="35">密　码：</td>
              <td height="35"><input name="password" type="password" class="password" value="<%=s_password%>" /></td>
            </tr>
            <tr>
              <td height="35">&nbsp;</td>
              <td height="35"><input onclick="form1.submit()" type="image" class="img" name="submit" style="width:60px;height:26px;" src="images/login.jpg" /></td>
            </tr>
          </table>
        </form>
      </div>
      <div class="b">
        <table width="480" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td height="32">&nbsp;</td>
            </tr>
          <tr>
            <td height="35" align="left"><font color="#b1d0ef">Copyright & 2007-2015 Powered By <a href="http://www.hokilly.com" target="_blank" style="color:#b1d0ef">www.Hokilly.com</a> 红金羚软件 Version：V<%=version%>&nbsp; <br />
            红金羚进销存管理系统辉煌版(仓库管理软件) &nbsp;联系电话：13915064582</font></td>
            </tr>
        </table>
      </div>
    </div></td>
  </tr>
  <tr>
</table>

</body>
</html>
