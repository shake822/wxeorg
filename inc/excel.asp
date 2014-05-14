<!-- #include file="../inc/connExcel.asp" -->
<%
Response.AddHeader "Content-Disposition", "attachment;filename=红金羚软件导出Excel.xls"
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

 sql_sys = "select * from T_softinfo"
 set rs_sys = conn.Execute(sql_sys) '调用系统参数表
 dim arr '定义合计数组
 for i =1 to 100
  redim arr(i)
 next

sql_field = "select * from t_fieldshow where tablename = '" & Request.Form("table") & "' and show=1 order by showid"
sql = Request.Form("sql")
set rs_field = server.CreateObject("adodb.recordset")
rs_field.Open sql_field, conn, 1, 1

set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1

 Response.Write "<table border=""1"" align=""center"">"
 Response.Write "<tr align=""center"">"
 for k = 1 to rs_field.recordcount '显示表头
  Response.Write "<th>"&rs_field("name")&"</th>"
  rs_field.movenext
 Next
 Response.Write "</tr>"
 
 for i = 1 to rs.recordcount
 if not rs.eof then
  Response.Write "<tr>"
  rs_field.movefirst
  for k=1 to rs_field.recordcount
    str_show = rs(""&rs_field("field")&"")
	Response.Write "<td>"
	if rs_field("DotSize") = 1 then '小数点位数
	  if isnumeric(str_show) then
	    str_show = SetSmallInt(formatnumber(str_show,rs_sys("DotPrice"),-1))
	  else
	    str_show = SetSmallInt(formatnumber(0,rs_sys("DotPrice"),-1))
	  end if
	elseif rs_field("DotSize") = 2 then
	  if isnumeric(str_show) then 
	    str_show = SetSmallInt(formatnumber(str_show,rs_sys("DotNum"),-1))
	  else
	    str_show = SetSmallInt(formatnumber(0,rs_sys("DotNum"),-1))
	  end if
	elseif rs_field("DotSize") = 3 then
	  if isnumeric(str_show) then 
	    str_show = SetSmallInt(formatnumber(str_show,rs_sys("DotMon"),-1))
	  else
	    str_show = SetSmallInt(formatnumber(0,rs_sys("DotMon"),-1))
	  end if
	else
	  str_show = str_show
	end if
	if rs_field("SumField") = 1 then
	  arr(k) = cdbl(arr(k)) + cdbl(str_show)
	end if
	Response.Write str_show
	Response.Write "</td>"
    rs_field.movenext
  next
  Response.Write "</tr>"
 rs.movenext 
 end if
 next
 sql_flag = "select sum(sumfield) as sum_flag from t_fieldshow where t_fieldshow.show=1 and tablename='"&tablename&"'"
 Set rs_flag = server.CreateObject("adodb.recordset")
 rs_flag.Open sql_flag, conn, 1, 1 
 if rs_flag("sum_flag") >= 1 then
   Response.Write "<tr>"
   rs_field.movefirst
   for i = 1 to rs_field.recordcount
    Response.Write "<td align=""center"">"
    if i = 1 then
      Response.Write "合计"
    else
      Response.Write arr(i)
    end if  
    Response.Write "</td>"  
    rs_field.movenext()
   next
   Response.Write "</tr>"
 end if
 Response.Write "</table>"
%>

</body>
</html> 