<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
Dim sql
sql = "update t_tree set name = '" & request.Form("name3") & "' where id = " & Request.QueryString("id")
conn.Execute(sql)
endconnection
%>
<script language=javascript>
window.location='../common/edittree.asp?type=<%=request.QueryString("type")%>'
</script>