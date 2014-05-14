<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>支付方式</title>

<script>
function openform1()
{
  var width="400", height="120";
  var left = (screen.width/2) - width/2;
  var top = (screen.height/2) - height/2;
window.open ('addcashtype.asp?add=true', 'newwindow', 'width='+width+',height='+height+',left='+left+',top='+top+',toolbar=no,menubar=no, scrollbars=no, resizable=no,location=no, status=no');
}
function openform2(i)
{
  var width="400", height="120";
  var left = (screen.width/2) - width/2;
  var top = (screen.height/2) - height/2;
  var id=document.getElementById('tbl').rows[i].cells[1].innerHTML;;
  var name=document.getElementById('tbl').rows[i].cells[2].innerHTML;;
  var note=document.getElementById('tbl').rows[i].cells[3].innerHTML;;
window.open ('addcashtype.asp?add=false&id='+id+'&name='+name+'&note='+note+'', 'newwindow', 'width='+width+',height='+height+',left='+left+',top='+top+',toolbar=no,menubar=no, scrollbars=no, resizable=no,location=no, status=no');
}
</script>
</head>

<body>
  <p align="center" class="STYLE1">支付方式</p>
  <input type="button" name="add" value=" 新 增 "   onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" class="button" onClick="openform1()">
<table id="tbl" border="0" cellpadding="3" cellspacing="0" width="100%" align="center">
<tr align="center">
<th width="30%">操作</th><th width="10%">ID</th><th width="30%">支付方式</th><th width="30%">备注</th></tr>
<%
sql = "select * from Dict_CashType"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
For k = 1 To rs.recordcount
%>
<tr id="tr" bgcolor="#FFFFFF" align="center"><td><a href="#" onClick="openform2(<%=k%>)">修改</a>&nbsp;<a href="../action/delcashtype.asp?id=<%=rs("id")%>">删除</a></td>
<td><%=rs("id")%></td><td><%=rs("name")%></td><td><%=rs("note").value%></td></tr>
<%
rs.movenext
Next
close_rs(rs)
%>
</table>
</body>
</html>
