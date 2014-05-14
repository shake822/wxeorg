<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../inc/config.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<%
invoicetype = Request.QueryString("type")
invoicecode = Request.Form("invoicecode")
custname = Request.Form("cust")
adddate = Request.Form("adddate")
money = Request.Form("money")
maker = Request.Form("maker")
billcode = Request.Form("billcode")
memo = Request.Form("memo")

if Request.QueryString("add") = "true" then
	sql = "insert into t_invoice (invoicecode,custname,adddate,[money],maker,billcode,memo,type) values ('"& invoicecode &"','"& custname &"','"& adddate &"','"& money &"','"& maker &"','"& billcode &"','"& memo &"','"& invoicetype &"')"
else
	sql = "update t_invoice set invoicecode = '"& invoicecode &"',custname = '"& custname &"',adddate = '"& adddate &"',[money] = '"& money &"',maker = '"& maker &"',billcode = '"& billcode &"',memo = '"& memo &"',type = '"& invoicetype &"' where id = " & Request.Form("id")
end if
on error resume next
conn.BeginTrans
set rs = Server.CreateObject("adodb.recordset")
sql = "select * from t_invoice where invoicecode = '"& invoicecode &"'"
rs.open sql,conn, 1, 3
if Request.QueryString("add") = "true" then
	rs.addnew
end if
rs("invoicecode") = invoicecode
rs("custname") = custname
rs("adddate") = adddate
rs("money") = money
rs("maker") = maker
rs("billcode") = billcode
rs("memo") = memo
rs("type") = invoicetype
rs.update
rs.close
set rs = nothing
if err.number <= 0 then
	conn.CommitTrans
	conn.close
	set conn=nothing
	response.write "<script>alert('保存成功！');window.close();</script>"
else
	conn.RollbackTrans '否则回滚
	conn.close
	set conn=nothing
	response.write err.description
	response.write "<script>alert('保存失败！');window.close();</script>"
end if
%>
