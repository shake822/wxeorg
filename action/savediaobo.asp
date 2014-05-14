<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
Dim s_adddate, s_cust, s_depot, s_user, s_remark1, s_billcode, i_rowcount, s_billtype, s_maker
Dim s_goodscode, s_goodsname, s_goodsunit, s_units, s_price, s_number, s_money, s_remark
if Request.QueryString("add")="false" then
s_billtype = "仓库调拨"
s_adddate = Trim(Request.Form("date"))
s_cust = Trim(Request.Form("cust"))
s_depot = Trim(Request.Form("depot"))
s_user = Trim(Request.Form("user"))
s_maker = Trim(Request.Form("maker"))
s_memo = Trim(Request.Form("memo"))
s_billcode = Trim(Request.Form("billcode"))
i_rowcount = Trim(Request.Form("rowcount"))
sql = "update t_bill set adddate='"&s_adddate&"',custname='"&s_cust&"',depotname='"&s_depot&"',username='"&s_user&"' where billcode='"&s_billcode&"' and diaobo=false"
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
    sql = "insert into t_billdetail (billcode,goodscode,goodsname,goodsunit,units,price,number,money,DetailNote,inprice) values ('"&s_billcode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_price&"')"
    if s_goodscode<>"" then
    	conn.Execute(sql)
    end if
Next
else
s_billtype = "仓库调拨"
s_adddate = Trim(Request.Form("date"))
s_cust = Trim(Request.Form("cust"))
s_depot = Trim(Request.Form("depot"))
s_user = Trim(Request.Form("user"))
s_maker = Trim(Request.Form("maker"))
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
sql = "insert into t_bill (billcode,adddate,custname,depotname,UserName,Memo,billtype,inorout,flag,diaobo,maker) values ('"&s_billcode&"','"&s_adddate&"','"&s_cust&"','"&s_depot&"','"&s_user&"','"&s_memo&"','"&s_billtype&"','出库',-1,0,'"&s_maker&"')"
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
    sql = "insert into t_billdetail (billcode,goodscode,goodsname,goodsunit,units,price,number,money,DetailNote,inprice) values ('"&s_billcode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_price&"')"
    if s_goodscode<>"" then
    	conn.Execute(sql)
    end if
Next
end if
endconnection
 response.write "<script>alert('保存成功！');location.href='../bills/kc_depotbill.asp?type=db&bill=bill';</script>"
%>
