<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
if Request.QueryString("type") = "fk" then
  call CheckAuthority("DelFK")
else
  call CheckAuthority("DelSK")
end if

sql = "delete from t_cash where cashcode='"&request.QueryString("cashcode")&"'"
conn.execute(sql)
endconnection
response.redirect "../cash/cash.asp?type="&request.QueryString("type")
%>