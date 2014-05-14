<!-- #include file="../inc/connExcel.asp" -->
<%
Response.AddHeader "Content-Disposition", "attachment;filename=领用明细Excel.xls"
Response.ContentType  =  "application/vnd.ms-excel "
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Excel</title>
</head>
<body>
<%
Function SetSmallInt(DataValue)
	if (DataValue<1) and (DataValue>0) then
	  if left(DataValue,1)<>"0" then
	    DataValue="0"&DataValue   
	  end if
	end if
	SetSmallInt = DataValue
End Function

sql = request.form("sql")
set rs = server.createobject("adodb.recordset")
rs.open sql,conn,1,1

%>

<table style="font-size:12px;" width="100%" id="sqd" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
	<th width=3%></th>
	<th width=8%>货品编码</th>
  <th width=8%>货品名称</th>
  <th width=8%>货品规格</th>
  <th width=5%>单位</th>
  <th width=8%>领料仓</th>
  <th width=8%>部门名称</th>
  <th width=9%>添加时间</th>
  <th width=5%>数量</th>
  <th width=8%>单价</th>
  <th width=8%>金额</th>
  <th width=10%>单号</th>
  <th width=6%>备注</th>
  <th width=6%>经办人</th>
</tr>

<%
totalnum = 0
totalmon = 0
if rs.eof=false then
For i = 0 To rs.recordcount -1
  If rs.bof Or rs.EOF Then Exit For
  totalnum = totalnum + rs("t_num")
	totalmon = totalmon + rs("t_mon")
%>

<tr align="center">
	<th><%=i+1%></th>
  <td><%=rs("goodscode")%></td>
  <td><%=rs("goodsname")%></td>
  <td><%=rs("goodsunit")%></td>
  <td><%=rs("units")%></td>
  <td><%=rs("depotname")%></td>
  <td><%=rs("custname")%></td>
  <td><%=rs("adddate")%></td>
  <td><%=rs("t_num")%></td>
  <td><%=rs("price")%></td>
  <td><%=rs("t_mon")%></td>
  <td><%=rs("billcode")%></td>
  <td><%=rs("memo")%></td>
  <td><%=rs("username")%></td>
</tr>

<%rs.movenext
next
end if
%>

<tr align="center">
	<th colspan=8 >合计</th>
	<th ><%=totalnum%></th>
	<th ></th>
	<th ><%=totalmon%></th>
	<th ></th>
	<th ></th>
	<th ></th>
</tr>
</table>
</body>
</html> 