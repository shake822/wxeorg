<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
If Request("add") = "false" Then
	s_billtype = Request.QueryString("type")
	s_adddate = Trim(Request.Form("date"))
	s_custname = Trim(Request.Form("cust"))
	s_depot = Trim(Request.Form("depot"))
	s_maker = trim(Request.Form("maker"))
	s_user = Trim(Request.Form("user"))
	s_memo = Trim(Request.Form("memo"))
	s_pay = Trim(Request.Form("pay"))
	s_account = Trim(Request.Form("account"))
	s_billcode = Trim(Request.Form("billcode"))
	i_rowcount = Trim(Request.Form("rowcount"))
	s_zkprice=trim(request.Form("zkprice"))
	s_yfprice=trim(request.Form("yfprice"))
	s_zdprice=trim(request.Form("zdprice"))
	if s_pay = "" then s_pay = "0" end if
	if s_zkprice = "" then s_zkprice="0" end if
	if s_yfprice = "" then s_yfprice="0" end if
	if s_zdprice = "" then s_zdprice="0" end if
	if s_account = "" then s_account = "" end if
	if s_pay = "" then s_pay = "0" end if
	'添加开始
	on error resume next
	conn.BeginTrans
	set rs = Server.CreateObject("adodb.recordset")
	sql = "select * from dict_bill where name = '"& s_billtype &"'"
	rs.open sql, conn, 1, 1
	set rsBill = Server.CreateObject("adodb.recordset")
	sql = "select * from t_bill where billcode = '" & s_billcode & "'"
	rsBill.Open sql, conn, 1, 3
	rsBill("adddate") = s_adddate
	rsBill("custname") = s_custname
	rsBill("depotname") = s_depot
	rsBill("username") = s_user
	rsBill("memo") = s_memo
	rsBill("account") = s_account
	rsBill("zdprice") = s_zdprice
	rsBill("zkprice") = s_zkprice
	rsBill("yfprice") = s_yfprice
	rsBill("pay") = s_pay
	rsBill.update
	rsBill.close
	set rsBill = nothing	
Else
	set rs = Server.CreateObject("adodb.recordset")
	sql = "select * from dict_bill where billtype = '"& Request.QueryString("type") &"'"
	rs.open sql, conn, 1, 1
	
	today = Now()
	tdate = Year(today) & "-" & Right("0" & Month(today), 2) & "-" & Right("0" & Day(today), 2)
	set rsCode = Server.CreateObject("adodb.recordset")
	sql = "select * from t_bill where billcode like '"&rs("billtype")&"-"&tdate&"%' order by billcode desc"
	rsCode.Open sql, conn, 1, 1
	If rsCode.recordcount = 0 Then
		s_billcode = rs("billtype")&"-"&tdate&"-0001"
	Else
		s_temp = rsCode("billcode")
		s_temp = Right(s_temp, 4) + 1
		s_billcode = rs("billtype")&"-"&tdate&"-"&Right("000"&s_temp, 4)
	End If
	s_billtype = rs("name")
    s_adddate = Trim(Request.Form("date"))
    s_custname = Trim(Request.Form("cust"))
    s_depot = Trim(Request.Form("depot"))
	s_maker = trim(Request.Form("maker"))
    s_user = Trim(Request.Form("user"))
    s_memo = Trim(Request.Form("memo"))
	s_pay = Trim(Request.Form("pay"))
	s_account = Trim(Request.Form("account"))
    's_billcode = Trim(Request.Form("billcode"))
    i_rowcount = Trim(Request.Form("rowcount"))
	s_planbillcode = trim(Request.Form("planbillcode"))
	s_zkprice=trim(request.Form("zkprice"))
	s_yfprice=trim(request.Form("yfprice"))
	s_zdprice=trim(request.Form("zdprice"))
	if s_zkprice = "" then s_zkprice="0" end if
	if s_yfprice = "" then s_yfprice="0" end if
	if s_zdprice = "" then s_zdprice="0" end if
	if s_account = "" then s_account = "" end if
	if s_pay = "" then s_pay = "0" end if
	'添加开始
	on error resume next
	conn.BeginTrans
	set rsBill = Server.CreateObject("adodb.recordset")
	sql = "select * from t_bill where billcode = '" & s_billcode & "'"
	rsBill.Open sql, conn, 1, 3
	rsBill.addnew
	rsBill("billtype") = s_billtype
	rsBill("billcode") = s_billcode
	rsBill("planbillcode") = s_planbillcode
	rsBill("adddate") = s_adddate
	rsBill("custname") = s_custname
	rsBill("depotname") = s_depot
	rsBill("username") = s_user
	rsBill("memo") = s_memo
	rsBill("maker") = s_maker
	rsBill("flag") = rs("billflag")
	rsBill("account") = s_account
	rsBill("zdprice") = s_zdprice
	rsBill("zkprice") = s_zkprice
	rsBill("yfprice") = s_yfprice
	rsBill("pay") = s_pay
	rsBill.update
	rsBill.close
	set rsBill = nothing  
End If
	
sql = "delete from t_billdetail where billcode='"&s_billcode&"'"
conn.Execute(sql)

set rsMemory = Server.CreateObject("adodb.recordset")

set rsDetail = Server.CreateObject("adodb.recordset")
sql = "select * from t_billdetail where billcode = '" & s_billcode & "'"
rsDetail.Open sql, conn, 1, 3
arrGoodscode = split(Trim(Request.Form("goodscode")), ",")
arrGoodsname = split(Trim(Request.Form("goodsname")), ",")
arrGoodsunit = split(Trim(Request.Form("goodsunit")), ",")
arrUnits     = split(Trim(Request.Form("units")), ",")
arrPrice     = split(Trim(Request.Form("price")), ",")
arrNumber    = split(Trim(Request.Form("number")), ",")
arrMoney     = split(Trim(Request.Form("money")), ",")
arrRemark    = split(Trim(Request.Form("remark")), ",")
arrAvgprice  = split(Trim(Request.Form("aveprice")), ",")
if UBound(arrGoodscode) = 0 then
	rsDetail.addnew
	rsDetail("billcode") = s_billcode
	rsDetail("goodscode") = Trim(Request.Form("goodscode"))
	rsDetail("goodsname") = Trim(Request.Form("goodsname"))
	rsDetail("goodsunit") = Trim(Request.Form("goodsunit"))
	rsDetail("units") = Trim(Request.Form("units"))
	rsDetail("price") = cdbl(Trim(Request.Form("price")))
	rsDetail("number") = cdbl(Trim(Request.Form("number")))
	rsDetail("money") = cdbl(Trim(Request.Form("money")))
	rsDetail("detailnote") = Trim(Trim(Request.Form("remark")))
	if rs("inorout") = "入库" then
		rsDetail("inprice") = cdbl(Trim(Request.Form("price")))
	else
		rsDetail("inprice") = cdbl(Trim(Request.Form("aveprice")))
	end if
	sql = "select * from t_memoryprice where goodscode = '"& Request.Form("goodscode") &"' and billtype = '"& s_billtype &"' and custname = '"& s_custname &"'"
	rsMemory.open sql, conn, 1, 3
	if rsMemory.eof then
		rsMemory.addnew
	end if
	rsMemory("goodscode") = Trim(Request.Form("goodscode"))
	rsMemory("custname") = s_custname
	rsMemory("billtype") = s_billtype
	rsMemory("price") = cdbl(Trim(Request.Form("price")))
	rsMemory.update
	rsMemory.close
else
	For i = LBound(arrGoodscode) To UBound(arrGoodscode)
		rsDetail.addnew
		rsDetail("billcode") = s_billcode
		rsDetail("goodscode") = Trim(arrGoodscode(i))
		rsDetail("goodsname") = Trim(arrGoodsname(i))
		rsDetail("goodsunit") = Trim(arrGoodsunit(i))
		rsDetail("units") = Trim(arrUnits(i))
		rsDetail("price") = cdbl(Trim(arrPrice(i)))
		rsDetail("number") = cdbl(Trim(arrNumber(i)))
		rsDetail("money") = cdbl(Trim(arrMoney(i)))
		rsDetail("detailnote") = Trim(arrRemark(i))
		if rs("inorout") = "入库" then
			rsDetail("inprice") = cdbl(Trim(arrPrice(i)))
		else
			rsDetail("inprice") = cdbl(Trim(arrAvgprice(i)))
		end if
	sql = "select * from t_memoryprice where goodscode = '"& Trim(arrGoodscode(i)) &"' and billtype = '"& s_billtype &"' and custname = '"& s_custname &"'"
	rsMemory.open sql, conn, 1, 3
	if rsMemory.eof then
		rsMemory.addnew
	end if
	rsMemory("goodscode") = Trim(arrGoodscode(i))
	rsMemory("custname") = s_custname
	rsMemory("billtype") = s_billtype
	rsMemory("price") = cdbl(Trim(arrPrice(i)))
	rsMemory.update
	rsMemory.close
	Next
end if
set rsMemory = nothing
rsDetail.update
rsDetail.close
set rsDetail = nothing
rs.close
set rs = nothing
'Response.Write err.number
if err.number <= 0 then
	conn.CommitTrans
	conn.close
	set conn=nothing
	if (Request("type") = "CG") or (Request("type")="XS") then
		response.write "<script>alert('保存成功！');location.href='../bills/addbill.asp?type="&request.QueryString("type")&"';</script>"
	elseif (Request("type") = "CD") or (Request("type")="XD") then
		response.write "<script>alert('保存成功！');location.href='../bills/orderbill.asp?type="&request.QueryString("type")&"';</script>"
	elseif request("type")="RK" or request("type")="CK" then
		response.write "<script>alert('保存成功！');location.href='../bills/kc_depotbill.asp?type="&request.QueryString("type")&"';</script>"
	elseif request("type")="DB" then
		response.write "<script>alert('保存成功！');location.href='../bills/kc_depotbill.asp?type="&request.QueryString("type")&"&bill=bill';</script>"
	elseif request("type")="PD" then
		response.write "<script>alert('保存成功！');location.href='../bills/kc_depotbill.asp?type="&request.QueryString("type")&"&bill=pbill';</script>"
	elseif request("type")="LL" then
		response.write "<script>alert('保存成功！');location.href='../bills/kc_depotbill.asp?type="&request.QueryString("type")&"&bill=lbill';</script>"
	elseif request("type")="TL" then
		response.write "<script>alert('保存成功！');location.href='../bills/kc_depotbill.asp?type="&request.QueryString("type")&"&bill=lbill';</script>"
	else
		response.write "<script>alert('保存成功！');window.close();</script>"
	end if
else
	conn.RollbackTrans '否则回滚
	conn.close
	set conn=nothing
	response.write err.description
	response.write "<script>alert('保存失败！');window.close();</script>"
end if
%>
