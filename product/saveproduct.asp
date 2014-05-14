<!-- #include file="../inc/conn.asp" -->
<%
if Request.QueryString("add")="false" then
s_billtype = "产品组装"
s_adddate = Trim(Request.Form("date"))
s_depot2 = Trim(Request.Form("depot2"))
s_depot1 = Trim(Request.Form("depot1"))
s_user = Trim(Request.Form("user"))
s_maker = Trim(Request.Form("maker"))
s_memo = Trim(Request.Form("memo"))
s_billcode = Trim(Request.Form("billcode"))
i_rowcount = Trim(Request.Form("rowcount"))
sql = "update t_bill set adddate='"&s_adddate&"',custname='"&s_depot2&"',depotname='"&s_depot1&"',username='"&s_user&"' where billcode='"&s_billcode&"r' and diaobo=true"
conn.Execute(sql)
sql = "update t_bill set adddate='"&s_adddate&"',custname='"&s_depot1&"',depotname='"&s_depot2&"',username='"&s_user&"' where billcode='"&s_billcode&"' and diaobo=false"
conn.Execute(sql)

sql = "delete from t_billdetail where billcode='"&s_billcode&"'"
conn.Execute(sql)

sGoodscode = Trim(Request.Form("totalgoodscode"))
sGoodsname = Trim(Request.Form("totalgoodsname"))
sGoodsunit = Trim(Request.Form("totalgoodsunit"))
sUnits = Trim(Request.Form("totalunits"))
fPrice = Trim(Request.Form("totalprice"))
fNumber = Trim(Request.Form("totalnumber"))
fMoney = Trim(Request.Form("totalmoney"))
sRemark = Trim(Request.Form("totalremark"))
fAvePrice = Trim(Request.Form("totalprice"))
sql = "insert into t_billdetail ([billcode],[goodscode],[goodsname],[goodsunit],[units],[price],[number],[money],[DetailNote],[inprice]) values ('"&s_billcode&"','"&sGoodscode&"','"&sGoodsname&"','"&sGoodsunit&"','"&sUnits&"',"&fPrice&","&fNumber&","&fMoney&",'"&sRemark&"',"&fAvePrice&")"
conn.Execute(sql)

sql = "delete from t_billdetail where billcode='"&s_billcode&"r'"
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
	s_inprice = Trim(Request.Form("aveprice"&i))
    sql = "insert into t_billdetail ([billcode],[goodscode],[goodsname],[goodsunit],[units],[price],[number],[money],[DetailNote],[inprice]) values ('"&s_billcode&"r','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_inprice&"')"
    conn.Execute(sql)
Next
else   '---------------------新增
s_billtype = "产品组装"
s_adddate = Trim(Request.Form("date"))
s_depot2 = Trim(Request.Form("depot2"))
s_depot1 = Trim(Request.Form("depot1"))
s_user = Trim(Request.Form("user"))
s_maker = Trim(Request.Form("maker"))
s_memo = Trim(Request.Form("memo"))
s_billcode = Trim(Request.Form("billcode"))
i_rowcount = Trim(Request.Form("rowcount"))
sql = "insert into t_bill (billcode,adddate,custname,depotname,UserName,Memo,billtype,inorout,flag,diaobo,maker) values ('"&s_billcode&"r','"&s_adddate&"','"&s_depot2&"','"&s_depot1&"','"&s_user&"','"&s_memo&"','"&s_billtype&"','出库',-1,1,'"&s_maker&"')"
conn.Execute(sql)
sql = "insert into t_bill (billcode,adddate,custname,depotname,UserName,Memo,billtype,inorout,flag,diaobo,maker) values ('"&s_billcode&"','"&s_adddate&"','"&s_depot1&"','"&s_depot2&"','"&s_user&"','"&s_memo&"','"&s_billtype&"','入库',1,0,'"&s_maker&"')"
conn.Execute(sql)
'产品入库
sGoodscode = Trim(Request.Form("totalgoodscode"))
sGoodsname = Trim(Request.Form("totalgoodsname"))
sGoodsunit = Trim(Request.Form("totalgoodsunit"))
sUnits = Trim(Request.Form("totalunits"))
fPrice = Trim(Request.Form("totalprice"))
fNumber = Trim(Request.Form("totalnumber"))
fMoney = Trim(Request.Form("totalmoney"))
sRemark = Trim(Request.Form("totalremark"))
fAvePrice = Trim(Request.Form("totalprice"))
sql = "insert into t_billdetail ([billcode],[goodscode],[goodsname],[goodsunit],[units],[price],[number],[money],[DetailNote],[inprice]) values ('"&s_billcode&"','"&sGoodscode&"','"&sGoodsname&"','"&sGoodsunit&"','"&sUnits&"',"&fPrice&","&fNumber&","&fMoney&",'"&sRemark&"',"&fAvePrice&")"

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
	s_inprice = Trim(Request.Form("aveprice"&i))
    sql = "insert into t_billdetail ([billcode],[goodscode],[goodsname],[goodsunit],[units],[price],[number],[money],[DetailNote],[inprice]) values ('"&s_billcode&"r','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"','"&s_inprice&"')"
    conn.Execute(sql)
Next
end if
endconnection
response.Redirect "../common/main.asp"
%>
