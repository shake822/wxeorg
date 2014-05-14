<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>无标题文档</title>
</head>

<body>
<%if Request("add") = "true" then %>
<form name="form1" method="post" action="../action/savecashtype.asp?add=true">
  <table width="100%" border="0">
    <tr>
      <td width="30%" height="19">支付方式</td>
      <td width="70%"><input type="text" name="name" id="name" size="20"></td>
    </tr>
    <tr>
      <td> 备 注 </td>
      <td><input type="text" name="note" id="note" size="20"></td>
    </tr>
  </table>
<input type="submit"  class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value=" 保 存 ">
</form>
<%else%>
<form name="form1" method="post" action="../action/savecashtype.asp?add=false">
  <table width="100%" border="0">
    <tr>
      <td width="30%" height="19">支付方式</td><input type="hidden" name="id" id="id" value=<%= Request("id") %>>
      <td width="70%"><input type="text" name="name" id="name" size="20" value=<%= Request("name") %>></td>
    </tr>
    <tr>
      <td> 备 注 </td>
      <td><input type="text" name="note" id="note" size="20" value=<%= Request("note") %>></td>
    </tr>
  </table>
<input type="submit"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" class="button" value=" 保 存 ">
</form>
<%end if%>
</body>
</html>
