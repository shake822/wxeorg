<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strBrowseCompany") %>
<%
sql = "select * from t_company"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
if rs.recordcount>0 then
	s_company=rs("company")
	s_contact=rs("contact")
	s_address=rs("address")
	s_fax=rs("fax")
	s_tel=rs("tel")
	s_email=rs("email")
	s_zip=rs("zip")
end if

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>公司信息</title>
</head>

<body>
<br>
<div align="center"><span class="STYLE1">公司信息</span></div><br>
<form name="form1" method="post" action="../action/savecompany.asp">
  <table width="500" border="0" align="center">
    <tr>
      <td width="202" align="right">公司名称：</td>
      <td width="286"><input type="text" size="30" name="company" value="<%=s_company%>"></td>
    </tr>
    <tr>
      <td align="right">联&nbsp;系&nbsp;人：</td>
      <td><input type="text" size="10" name="contact" value="<%=s_contact%>"></td>
    </tr>
    <tr>
      <td align="right">地&nbsp;&nbsp;&nbsp;&nbsp;址：</td>
      <td><input type="text" size="35" name="address" value="<%=s_address%>"></td>
    </tr>
    <tr>
      <td align="right">传&nbsp;&nbsp;&nbsp;&nbsp;真：</td>
      <td><input type="text" size="20" name="fax" value="<%=s_fax%>"></td>
    </tr>
    <tr>
      <td align="right">电&nbsp;&nbsp;&nbsp;&nbsp;话：</td>
      <td><input type="text" size="20" name="tel" value="<%=s_tel%>"></td>
    </tr>
    <tr>
      <td align="right">邮政编码：</td>
      <td><input type="text" size="20" name="zip" value="<%=s_zip%>"></td>
    </tr>
    <tr>
      <td align="right">电子邮箱：</td>
      <td><input type="text" size="20" name="email" value="<%=s_email%>"></td>
    </tr>
  </table><br>
  <div align="center"><input type="submit" value=" 保 存 "   onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" class="button">&nbsp;&nbsp;<input type="reset" value=" 重 置 "   onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button"></div>
</form>
<%
close_rs(rs)
endconnection
%>
</body>
</html>
