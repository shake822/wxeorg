<%
set conn = server.createobject("adodb.connection") 
Conn.Open "DRIVER={MySQL ODBC 3.51 Driver};SERVER=23.110.56.109;DATABASE=a0411115033;USER=a0411115033;PASSWORD=10118197;"
function CheckAuthority(str)
sqlCheckAuthority = "select * from t_user where username = '" & request.cookies("username") & "' and Authority like '%"& str &"%'"
set rsCheckAuthority = Server.CreateObject("adodb.recordset")
rsCheckAuthority.open sqlCheckAuthority,conn,1,1
if rsCheckAuthority.recordcount = 0 then
	Response.Write "<script>alert('该操作员没有此权限！')</script>"
	Response.End()
end if
end function

sub endConnection()
	conn.close
	set conn=nothing
end sub

function close_rs(rs)
  rs.close
  set rs=nothing
end function
%>
