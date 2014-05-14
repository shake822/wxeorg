<%
On Error Resume Next

set conn = server.createobject("adodb.connection") 
Conn.Open "DRIVER={MySQL ODBC 3.51 Driver};SERVER=23.110.56.109;DATABASE=a0411115033;USER=a0411115033;PASSWORD=10118197;"
Conn.execute("set names 'gb2312'")
conn.cursorlocation=3
If Err.Number <> 0 Then
	Err.Clear
	Conn.Close
	Set Conn = Nothing
	Response.Write "对不起,您的数据库连接出错,请与管理员联系!"
    Response.End
End If


function CheckAuthority(str)
sqlCheckAuthority = "select * from t_user where username = '" & request.cookies("username") & "' and Authority like '%"& str &"%'"
set rsCheckAuthority = Server.CreateObject("adodb.recordset")
rsCheckAuthority.open sqlCheckAuthority,conn,1,1
if rsCheckAuthority.recordcount = 0 then
	Response.Write "<script>alert('该操作员没有此权限！')</script>"
	Response.End()
end if
end function

function Authority(str)
sqlCheckAuthority = "select * from t_user where username = '" & request.cookies("username") & "' and Authority like '%"& str &"%'"
set rsCheckAuthority = Server.CreateObject("adodb.recordset")
rsCheckAuthority.open sqlCheckAuthority,conn,1,1
if rsCheckAuthority.recordcount = 0 then
	Authority = "False"
else
	Authority = "True"	
end if
rsCheckAuthority.close
set rsCheckAuthority = nothing
end function

'Dim Ft_Post,Ft_Get,Ft_In,Ft_Inf,Ft_Xh,Ft_db,Ft_dbstr,Kill_IP,WriteSql
Ft_In = "'|exec |insert |delete |count |chr |mid |truncate |char |declare "
Kill_IP=True
WriteSql=True
Ft_Inf = split(Ft_In,"|")
If Request.Form<>"" Then
	For Each Ft_Post In Request.Form
		For Ft_Xh=0 To Ubound(Ft_Inf)
			If Instr(LCase(Request.Form(Ft_Post)),Ft_Inf(Ft_Xh))<>0 Then
				If WriteSql=True Then
					Response.Write "<Script Language=JavaScript>alert('请不要在参数中包含非法字符尝试注入！');</Script>"
					Response.Write "<Script Language=JavaScript>history.go(-1);</Script>"
					Response.End
				End If
			End If
		Next
	Next
End If

If Request.QueryString<>"" Then
	For Each Ft_Get In Request.QueryString
		For Ft_Xh=0 To Ubound(Ft_Inf)
			If Instr(replace(LCase(Request.QueryString(Ft_Get)),"<br><li>",""),Ft_Inf(Ft_Xh))<>0 Then
				If WriteSql=True Then
					Response.Write "<Script Language=JavaScript>alert('请不要在参数中包含非法字符尝试注入！');</Script>"
					Response.Write "<Script Language=JavaScript>history.go(-1);</Script>"
					Response.End
				End If
			End If
		Next
	Next
End If

sub endConnection()
	conn.close
	set conn=nothing
end sub

function close_rs(rs)
  rs.close
  set rs=nothing
end function

function OpenDataSet(sql,rs)
	set rs = server.CreateObject("adodb.recordset")
	rs.Open sql, conn, 1, 1
end function

function NewCode(oldstr)
	if oldstr="" then 
		NewCode = "1"
	else
		i = Len(oldstr)
		laststr = right(oldstr,1)
		if laststr<>"0" and laststr<>"1" and laststr<>"2" and laststr<>"3" and laststr<>"4" and laststr<>"5" and laststr<>"6" and laststr<>"7" and laststr<>"8" and laststr<>"9" then
			NewCode = laststr + "1"
		elseif laststr="9" then
			NewCode = NewCode(left(oldstr,i-1)) + "0"
		else		
			NewCode = left(oldstr,i-1) + cstr(cint(laststr)+1)
		end if
	end if
end function
%>
