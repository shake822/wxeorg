<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
if Request.QueryString("add") = "true" then
s_planbillcode = Trim(Request.QueryString("planbillcode"))
s_adddate = Trim(Request.Form("date"))
s_cust = Trim(Request.Form("cust"))
s_depot = Trim(Request.Form("depot"))
s_maker = Trim(Request.Form("maker"))
s_user = Trim(Request.Form("user"))
s_memo = Trim(Request.Form("memo"))
s_billcode = Trim(Request.Form("billcode"))
i_rowcount = Trim(Request.Form("rowcount"))
	'判断重复单据号
	sql_check = "select count(*) as c from t_bill where billcode='"&s_billcode&"'"
	set rs_check = server.CreateObject("adodb.recordset")
	rs_check.Open sql_check, conn, 1, 1
	if CInt(rs_check("c")) > 0 then
      Response.Write("<script language=javascript>alert('单号有重复!');history.go(-1);</script>")
	  Response.End()
	end if
	close_rs(rs_check)
	'判断结束
on error resume next
conn.BeginTrans
If Request("type") = "CT" Then
    sql = "insert into t_bill (billcode,adddate,custname,depotname,UserName,Memo,billtype,inorout,flag,planbillcode,maker) values ('"&s_billcode&"','"&s_adddate&"','"&s_cust&"','"&s_depot&"','"&s_user&"','"&s_memo&"','采购退货','出库',-1,'"&s_planbillcode&"','"&s_maker&"')"
End If
If Request("type") = "XT" Then
    sql = "insert into t_bill (billcode,adddate,custname,depotname,UserName,Memo,billtype,inorout,flag,planbillcode,maker) values ('"&s_billcode&"','"&s_adddate&"','"&s_cust&"','"&s_depot&"','"&s_user&"','"&s_memo&"','销售退货','入库',1,'"&s_planbillcode&"','"&s_maker&"')"
End If
conn.Execute(sql)
For i = 1 To i_rowcount
    s_goodscode = Trim(Request.Form("goodscode"&i))
    s_goodsname = Trim(Request.Form("goodsname"&i))
    s_goodsunit = Trim(Request.Form("goodsunit"&i))
    s_units = Trim(Request.Form("units"&i))
    s_price = Trim(Request.Form("price"&i))
    s_number = Trim(Request.Form("number"&i))
    s_money = Trim(Request.Form("money"&i))
    s_remark = Trim(Request.Form("remark"&i))
    s_aveprice = Trim(Request.Form("aveprice"&i))
	if s_goodscode <> "" then
		sql = "insert into t_billdetail ([billcode],[goodscode],[goodsname],[goodsunit],[units],[price],[number],[money],[DetailNote],[inprice]) values ('"&s_billcode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_aveprice&"')"
		on error resume next
		conn.Execute sql,recaffected
		if err <> 0 then
		  Response.Write sql
		  Response.Write("<br>")
		else
		  'Response.Write("<h3>" & recaffected & " record added</h3>")
		end if
	end if 
Next
if err.number=0 then
	conn.CommitTrans
	conn.close
	set conn=nothing
	response.write "<script>alert('保存成功！')</script>"
else
	conn.RollbackTrans '否则回滚
	response.write "<script>alert('保存失败！')</script>"
end if
else
s_adddate = Trim(Request.Form("date"))
s_cust = Trim(Request.Form("cust"))
s_depot = Trim(Request.Form("depot"))
s_maker = trim(Request.Form("maker"))
s_user = Trim(Request.Form("user"))
s_memo = Trim(Request.Form("memo"))
s_billcode = Trim(Request.Form("billcode"))
i_rowcount = Trim(Request.Form("rowcount"))

on error resume next
conn.BeginTrans
  sql = "update t_bill set adddate='"&s_adddate&"',custname='"&s_cust&"',depotname='"&s_depot&"',UserName='"&s_user&"',Memo='"&s_memo&"',maker='"&s_maker&"' where billcode='"&s_billcode&"'"
conn.Execute(sql)
sql = "delete from t_billdetail where billcode='"&s_billcode&"'"
conn.Execute(sql)
For i = 1 To i_rowcount
    s_goodscode = Trim(Request.Form("goodscode"&i))
    s_goodsname = Trim(Request.Form("goodsname"&i))
    s_goodsunit = Trim(Request.Form("goodsunit"&i))
    s_units = Trim(Request.Form("units"&i))
    s_price = Trim(Request.Form("price"&i))
    s_number = Trim(Request.Form("number"&i))
    s_money = Trim(Request.Form("money"&i))
    s_remark = Trim(Request.Form("remark"&i))
    s_aveprice = Trim(Request.Form("inprice"&i))
    sql = "insert into t_billdetail ([billcode],[goodscode],[goodsname],[goodsunit],[units],[price],[number],[money],[DetailNote],[inprice]) values ('"&s_billcode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_aveprice&"')"
	if s_goodscode <> "" then
		sql = "insert into t_billdetail ([billcode],[goodscode],[goodsname],[goodsunit],[units],[price],[number],[money],[DetailNote],[inprice]) values ('"&s_billcode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_aveprice&"')"
		on error resume next
		conn.Execute sql,recaffected
		if err <> 0 then
		  Response.Write sql
		  Response.Write("<br>")
		else
		  'Response.Write("<h3>" & recaffected & " record added</h3>")
		end if
	end if
Next
if err.number=0 then
	conn.CommitTrans
	conn.close
	set conn=nothing
	response.write "<script>alert('保存成功！')</script>"
else
	conn.RollbackTrans '否则回滚
	response.write "<script>alert('保存失败！')</script>"
end if
end if
endconnection

'response.Redirect "../bills/selectbackbill.asp?type="&Request("type")
%>
<script>
window.close()
</script>
