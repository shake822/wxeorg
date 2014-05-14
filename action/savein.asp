<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
If Request.QueryString("add") = "false" Then
    sql = "update dict_in set name='"&request("name")&"' where id="&request("id")
Else
    sql = "insert into dict_in (name) values ('"&request.QueryString("name")&"')"
End If
conn.Execute(sql)
endconnection
response.Redirect "../common/in_type.asp"
%>

