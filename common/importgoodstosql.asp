<!-- #include file="../inc/conn.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<html>
<head>
<title>Excel货品导入</title>
</head>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<body>
<script language="javascript">
function savegoodstosql(){
	var obj = document.getElementById("import"); 
	obj.action="../action/savegoodstosql.asp";
	obj.submit();
}
</script>
</form>
<div align="center"><span class="STYLE1">Excel货品导入</span></div>
<hr>
<form id="import" name="import" action="" method="post">
<div id="inner-table-hpzl">
<table>
<tr>
	<th width="80px" align="center">货品类别</th>
	<th width="80px" align="center">货品编码</th>
	<th width="80px" align="center">货品名称</th>
	<th width="80px" align="center">货品规格</th>
	<th width="80px" align="center">单位</th>
	<th width="80px" align="center">出库价</th>
	<th width="80px" align="center">入库价</th>	
	<th width="80px" align="center">库存上限</th>	
	<th width="80px" align="center">库存下限</th>	
	<th width="80px" align="center">条形码</th>
	<th width="80px" align="center">备注</th>	
</tr>
<%
connstr="DBQ="&Server.Mappath("../Database/JXC.mdb")&";DRIVER={Microsoft Access Driver (*.mdb)};" 
set conn1=Server.CreateObject("adodb.connection") 
conn1.Open connstr
sql = "select * from t_temp_goods"
Set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn1, 1, 1
response.write "<tr>"
for i=1 to 11
	response.write "<td align=center>"
	response.write "<select name=field_"&i&" >"
	response.write "<option value=></option>"
	for j=0 to rs.fields.count - 1
		response.write "<option value="&rs.fields(j).name&" >"&rs.fields(j).name&"</option>"
	next
	response.write "</select></td>"
next
response.write "</tr>"
%>
</table>
</div>
<hr>
<div id="inner-table-bill1">
<table>
	<tr>
		<th align="center" width="35px">序号</th>
		<%
			for m=0 to rs.fields.count - 1
				response.write "<th width=90px>"&rs.fields(m).name&"</th>"
			next
		%>
	</tr>
	<%rs.movefirst
		for i=0 to rs.recordcount-1
			if rs.bof or rs.eof then exit for
	%>
	<tr>
		<td align="center"><%=i+1%></td>
			<%for j=0 to rs.fields.count -1
					response.write "<td>"&rs(rs.fields(j).name)&"</td>"
				next
			%>
	</tr>
	<%	rs.movenext
		next
		%>
</table>
</div>
<hr>
<input type="button" name="sub1" class="button" value="开始导入" onClick="savegoodstosql()">
</form>
</body>
</html>