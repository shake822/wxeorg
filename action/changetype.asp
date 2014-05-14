<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
dim arr
arr = split(Request.Form("tt"),",")
for i = lbound(arr) to ubound(arr)-1
	sql = "update t_goods set goodstype = '" & Request.Form("nodename") & "',code = '" & Request.Form("typecode") & "' where goodscode = '" & arr(i) & "'"
	conn.execute(sql)
next
endconnection
response.redirect "../common/goods1.asp"
%>