<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<%
sBillCode = Request.Form("billcode")
sAdddate = Request.Form("date")
sGoodscode = Request.Form("goodscode")
sDepotname = Request.Form("depot")
sOldqty = Request.Form("oldqty")
sOldprice = Request.Form("oldprice")
sNewqty = Request.Form("newqty")
sNewprice = Request.Form("newprice")
sDetailnote = Request.Form("detailnote")
sUsername = Request.Form("username")
sMaker = Request.Form("maker")

if Request.Form("add") = "" then
	sql = "insert into t_price (billcode,adddate,goodscode,depotname,oldqty,oldprice,newqty,newprice,detailnote,username,maker) "
	sql = sql + "values ('"&sBillCode&"','"&sAdddate&"','"&sGoodscode&"','"&sDepotname&"',"&sOldqty&","&sOldprice&","&sNewqty&","&sNewprice&",'"&sDetailnote&"','"&sUsername&"','"&sMaker&"')"
else
	sql = "update t_price set adddate = '"&sAdddate&"',goodscode = '"&sGoodscode&"',depotname='"&sDepotname&"',newqty="&sNewqty&",newprice="&sNewprice&",detailnote='"&sDetailnote&"',username='"&sUsername&"' where billcode='"&sBillCode&"'"
end if

conn.Execute(sql)
endconnection
%>
<script>window.close();</script>