<!-- #include file="../inc/conn.asp" -->
<%
sql = "delete from t_modeltotal where billcode='"&Request.QueryString("billcode")&"'"
conn.Execute(sql)
sql = "delete from t_modeldetail where billcode='"&Request.QueryString("billcode")&"'"
conn.Execute(sql)
endconnection
%>
<script>
window.history.go(-1);
</script>
