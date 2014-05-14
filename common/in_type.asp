<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>入库类型</title>
<SCRIPT   language="javascript">
function   change()
{
var   oObj   =   event.srcElement;
if(oObj.tagName.toLowerCase()   ==   "td")
{
var   oTr   =   oObj.parentNode;
for(var   i=1;   i<document.all.tbl.rows.length;   i++)
{
document.all.tbl.rows[i].style.backgroundColor   =   "";
document.all.tbl.rows[i].tag   =   false;
}
oTr.style.backgroundColor   =   "#CCCCFF";   oTr.tag   =   true;
}
}
function   out()
{
var   oObj   =   event.srcElement;
if(oObj.tagName.toLowerCase()   ==   "td") 
{
var   oTr   =   oObj.parentNode;
if(!oTr.tag)   oTr.style.backgroundColor   =   "";
}
}
function   over()
{
var   oObj   =   event.srcElement;
if(oObj.tagName.toLowerCase()   ==   "td")
{
var   oTr   =   oObj.parentNode;
if(!oTr.tag)   oTr.style.backgroundColor   =   "#E1E9FD";
}
}
function addtext(i_row)
{
document.getElementById("id").value=document.getElementById('tbl').rows[i_row].cells[0].innerHTML;
document.getElementById("name").value=document.getElementById('tbl').rows[i_row].cells[1].innerHTML;
}
function postadd()
{
  if (document.getElementById("name").value==""){
    alert("请填写入库类型名称！");
	return false;
  }else{
    window.location='../action/savein.asp?add=true&name='+document.getElementById("name").value;
  }
}
function postdel()
{
  if (document.getElementById("id").value==""){
    alert("请选择需要删除的入库类型！");
	return false;
  }else{
    window.location='../action/delin.asp?id='+document.getElementById("id").value;
  }
}
function postedit()
{
  if (document.getElementById("id").value==""){
    alert("请选择需要编辑的入库类型！");
	return false;
  }
}
</SCRIPT>
</head>

<body>
<br>
<div align="center"><span class="style1">入库类型</span></div>
<table border="0" align="center">
<tr valign="top"><td><table cellpadding="5" id="tbl">
  <tr align="center">
    <th>ID</th>
    <th>入库类型</th>
  </tr>
  <%
sql = "select * from Dict_in order by id"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
For i = 1 To rs.recordcount
%>
  <tr id="tr" bgcolor="#FFFFFF" align="center"    onMouseOver="over()"   onClick="change()"   onMouseOut="out()">
    <td onClick="addtext(<%=i%>)"><%=rs("id")%></td>
    <td onClick="addtext(<%=i%>)"><%=rs("name")%></td>
  </tr>
  <%
rs.movenext
Next
close_rs(rs)
endconnection
%>
</table></td>
<td>
<form name="units" method="post" onSubmit="return postedit();" action="../action/savein.asp?add=false">
<table border="0" align="center">
<tr><td colspan="2"><input type="text" name="name" id="name" size="16"><input type="hidden" name="id" id="id" size="16"></td></tr>
<tr><td><input type="button" class="button" value=" 新 增 " onClick="postadd()"></td></tr>
<tr><td><input type="submit" class="button" value=" 编 辑 "></td></tr>
<tr><td><input type="button" class="button" value=" 删 除 " onClick="postdel()"></td></tr>
</table>
</form></td></tr></table>
</body>
</html>
