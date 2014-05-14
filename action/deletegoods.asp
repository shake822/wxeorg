<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
If Request.QueryString("goodscode") = "" Then
%>
 <script language=javascript>
  alert('请选择要删除商品！')
  window.history.go(-1)
 </script>
  <%
Else
	sql = "select * from t_goods where goodscode = '"& Request.QueryString("goodscode") & "'"
	set rs = server.CreateObject("adodb.recordset")
	rs.Open sql, conn, 1, 1
    sql = "delete from t_goods where goodscode='"&rs("goodscode")&"'"
    conn.Execute(sql)
	sql = "delete from t_billdetail where goodscode='"&rs("goodscode")&"'"
	conn.Execute(sql)
	sql = "delete from t_start where goodscode='"&rs("goodscode")&"'"
	conn.Execute(sql)
	endconnection
response.Redirect "../common/goods.asp"
end if%>
