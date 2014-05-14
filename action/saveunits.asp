<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
If Request.QueryString("add") = "false" Then
    sql = "update dict_units set name='"&request("name")&"' where id="&request("id")
Else
    sql = "insert into dict_units (name) values ('"&request.QueryString("name")&"')"
End If
conn.Execute(sql)
endconnection
response.Redirect "../common/units.asp"
%>

