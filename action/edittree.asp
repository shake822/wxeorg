<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
Dim s_pid, s_name, s_type
s_pid = request("pid")
s_type = request.QueryString("type")
s_name = request.Form("name1")

If s_name = "" Then
    s_name = Request.Form("name2")
End If
If s_name = "" Then
%>
<script language=javascript>
window.history.go(-1)
</script>
<%
End If
if s_pid <> "" Then
Str = "select * from t_tree where type='"&s_type&"' and pid="&s_pid&" order by code"
Set rs = server.CreateObject("adodb.recordset")
rs.Open Str, conn, 1, 1
If rs.recordcount = 0 Then
    str1 = "select * from t_tree where id="&s_pid
    Set rs_temp = server.CreateObject("adodb.recordset")
    rs_temp.Open str1, conn, 1, 1
    If rs_temp.recordcount = 0 Then
        s_code = "01"
    Else
        s_code = rs_temp("code") + "01"
    End If
Else
    rs.movelast
    s_code = rs("code")
    s_code1 = Left(s_code, Len(s_code) -2)
    s_code2 = Right("0" & (Right(s_code, 2) + 1), 2)
    s_code = s_code1 + s_code2
End If
sql = "insert into t_tree (pid,name,type,code) values ("&s_pid&",'"&s_name&"','"&s_type&"','"&s_code&"')"
conn.Execute(sql)
end if
endconnection
%>
<script language=javascript>
window.location='../common/edittree.asp?type=<%=s_type%>'
</script>
