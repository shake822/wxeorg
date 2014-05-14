<%
connstr="DBQ="&Server.Mappath("../Database/JXC.mdb")&";DRIVER={Microsoft Access Driver (*.mdb)};" 
set conn1=Server.CreateObject("adodb.connection") 
conn1.Open connstr
set conn2=server.createobject("adodb.connection")
conn2.open "driver={microsoft excel driver (*.xls)};dbq=" & server.mappath("../Database/data.xls")
on error resume next
	conn1.execute "drop table t_temp_goods"
if err.number = 0 then
	Response.Write "s"
else
	Response.Write "f"
end if
conn2.execute "select * into t_temp_goods in '"&server.mappath("../Database/JXC.mdb")&"' from [data$]"
conn2.close : set conn2=nothing
conn1.close : set conn1=nothing
%>