<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
sBillCode=unescape(request("bill"))

sql = "select custname,pay from t_bill where billcode = '"& sBillCode &"'"
set rscust = Server.CreateObject("adodb.recordset")
rscust.open sql, conn, 1, 1
sql = "select sum(money) as billamt from t_billdetail where billcode = '"& sBillCode &"'"
set rsbill = Server.CreateObject("adodb.recordset")
rsbill.open sql, conn, 1, 1
sql = "select sum(money) as backamt from t_billdetail where billcode in (select billcode from t_bill where planbillcode = '"& sBillCode &"')"
set rsback = Server.CreateObject("adodb.recordset")
rsback.open sql, conn, 1, 1
sql = "select sum(money) as payamt from t_cash where billcode = '"& sBillCode &"'"
set rscash = Server.CreateObject("adodb.recordset")
rscash.open sql, conn, 1, 1
If rscust.eof Then
	response.write "|0"
	response.end	
Else
	if IsNumeric(rsback("backamt")) then
		backamt = rsback("backamt")
	else
		backamt = 0
	end if
	if IsNumeric(rscash("payamt")) then
		payamt = rscash("payamt")
	else
		payamt = 0
	end if
	response.write rscust("custname")&"|"&rsbill("billamt") - backamt - payamt - rscust("pay")
	response.end
End If
rscust.close
set rscust = nothing
rsbill.close
set rsbill = nothing
rsback.close
set rsback = nothing
rscash.close
set rscash = nothing
'Response.Write s_account
%>