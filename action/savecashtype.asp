<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
If Request("add") = "true" Then
    sql = "insert into Dict_CashType (name,note) values ('" & Request("name") & "','" & Request("note") & "')"
Else
    sql = "update Dict_CashType set name='" & Request("name") & "',note='" & Request("note") & "' where id=" & Request("id")
End If
conn.Execute(sql)
endconnection
%>
<script language=javascript>
alert('±£´æ³É¹¦£¡');
this.opener=null;
window.close();
</script>
