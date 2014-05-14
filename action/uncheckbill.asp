<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
if instr(Request.QueryString("billcode"),"CD") <> 0 then
	CheckAuthority("strUnCheckCD")
end if
if instr(Request.QueryString("billcode"),"CG") <> 0 then
	CheckAuthority("strUnCheckCG")
end if
if instr(Request.QueryString("billcode"),"CT") <> 0 then
	CheckAuthority("strUnCheckCT")
end if
if instr(Request.QueryString("billcode"),"XD") <> 0 then
	CheckAuthority("strUnCheckXD")
end if
if instr(Request.QueryString("billcode"),"XS") <> 0 then
	CheckAuthority("strUnCheckXS")
end if
if instr(Request.QueryString("billcode"),"XT") <> 0 then
	CheckAuthority("strUnCheckXT")
end if
if instr(Request.QueryString("billcode"),"RK") <> 0 then
	CheckAuthority("strUnCheckIn")
end if
if instr(Request.QueryString("billcode"),"CK") <> 0 then
	CheckAuthority("strUnCheckOut")
end if
if instr(Request.QueryString("billcode"),"DB") <> 0 then
	CheckAuthority("strUnCheckDB")
end if
if instr(Request.QueryString("billcode"),"PD") <> 0 then
	CheckAuthority("strUnCheckPD")
end if
if instr(Request.QueryString("billcode"),"LL") <> 0 then
	CheckAuthority("strUnCheckLL")
end if
if instr(Request.QueryString("billcode"),"TL") <> 0 then
	CheckAuthority("strUnCheckTL")
end if
s_billcode = Request.QueryString("billcode")
'检查相关单据
sqlcheck = "select count(billcode) as c from t_bill where planbillcode = '"& s_billcode &"'"
set rscheck = Server.CreateObject("adodb.recordset")
rscheck.open sqlcheck, conn, 1, 1
if CInt(rscheck("c")) > 0 then
	Response.Write("<script>alert('该单据被相关单据引用，不允许直接反审！');</script>")
	Response.Write("<script>window.close();</script>")
	Response.End()
end if
rscheck.close()
set rscheck = nothing
'检查收付款记录
sqlcheck = "select count(billcode) as c from t_cash where billcode = '"& s_billcode &"'"
set rscheck = Server.CreateObject("adodb.recordset")
rscheck.open sqlcheck, conn, 1, 1
if CInt(rscheck("c")) > 0 then
	Response.Write("<script>alert('该单据存在收付款记录，不允许直接反审！');</script>")
	Response.Write("<script>window.close();</script>")
	Response.End()
end if
rscheck.close()
set rscheck = nothing
sqlbill = "select billcode,depotname,flag,custname,billtype,t_bill.check from t_bill where billcode = '"& s_billcode &"'"
set rsbill = server.CreateObject("adodb.recordset")
rsbill.open sqlbill, conn, 1, 1
if rsbill("check") = False then
	Response.Write("<script>alert('该单据已反审！');</script>")
	Response.Write("<script>window.close();</script>")
	Response.End()
end if
on error resume next
conn.BeginTrans
sql = "update t_bill set t_bill.check=0,checkman='' where billcode = '" & s_billcode & "'"
Set rs = conn.Execute(sql)
if rsbill("flag") <> 0 then
sqldetail = "select goodscode,number,price,inprice from t_billdetail where billcode = '"& s_billcode &"'"
Set rsdetail = server.CreateObject("adodb.recordset")
rsdetail.Open sqldetail, conn, 1,3
rsdetail.movefirst
sql = "select * from t_inout where id < 0"
Set rs_inout = server.CreateObject("adodb.recordset")
rs_inout.Open sql, conn, 1, 3
while not rsdetail.eof
	rs_inout.addnew
	rs_inout("billcode") = rsbill("billcode")
	rs_inout("goodscode") = rsdetail("goodscode")
	rs_inout("qty") = rsdetail("number")
	rs_inout("price") = rsdetail("price")
	rs_inout("inprice") = rsdetail("inprice")
	rs_inout("depotname") = rsbill("depotname")
	rs_inout("flag") = -1 * rsbill("flag")
	rs_inout.update
	rsdetail.movenext
wend

rsdetail.movefirst
if rsbill("BillType") = "仓库调拨" then
while not rsdetail.eof
	rs_inout.addnew
	rs_inout("billcode") = rsbill("billcode")
	rs_inout("goodscode") = rsdetail("goodscode")
	rs_inout("qty") = rsdetail("number")
	rs_inout("price") = rsdetail("price")
	rs_inout("inprice") = rsdetail("inprice")
	rs_inout("depotname") = rsbill("custname")
	rs_inout("flag") = rsbill("flag")
	rs_inout.update
	rsdetail.movenext
wend
end if
end if
if err <> 0 then
	Response.Write("<script>alert('该单据反审未成功!');</script>")
	conn.rollbacktrans
else
	Response.Write("<script>alert('该单据已反审！');</script>")
	conn.CommitTrans
end if
endconnection
%>
<script language=javascript>
window.opener.location.reload();
window.close();
</script>