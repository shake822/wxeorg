<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
s_id = Request.QueryString("depotid")
s_type = Request.QueryString("type")
s_depotname = Request.Form("depotname")
s_department = Request.Form("department")
s_controller = Request.Form("controller")
s_principal = Request.Form("principal")
s_tel = Request.Form("tel")
s_address = Request.Form("address")
s_remark = Request.Form("remark")
s_userlist = Request("userlist")
If s_type = "edit" Then
    sql = "update t_depot set depotname='"&s_depotname&"',department='"&s_department&"',controller='"&s_controller&"',principal='"&s_principal&"',tel='"&s_tel&"',address='"&s_address&"',remark='"&s_remark&"' where id="&s_id
Else
    sql = "insert into t_depot (depotname,department,controller,principal,tel,address,remark) values ('"&s_depotname&"','"&s_department&"','"&s_controller&"','"&s_principal&"','"&s_tel&"','"&s_address&"','"&s_remark&"')"
End If
conn.Execute(sql)
If s_type = "add" Then
	arr = split(s_userlist,",")
	if ubound(arr) <> -1 then
	  for i = lbound(arr) to ubound(arr)-1
	    s_userpower = s_userpower & "'" & arr(i) & "',"
		next
	end if
  sql = "update t_user set depotname=depotname + '"&s_depotname&",' where username in ("&s_userpower&"'')"
  conn.Execute(sql)
end if
endconnection
%>
<script language="javascript">
	window.location="../common/depot.asp"
</script>
