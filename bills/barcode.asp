<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
s_date  = unescape(request("date"))
s_depot = unescape(request("depot"))
s_barcode = unescape(request("barcode"))
sql = "select s1.goodscode,goodsname,goodsunit,units,inprice,outprice,remark,t_num,avgprice from (select goodscode,goodsname,goodsunit,units,inprice,outprice,remark,barcode from t_goods where 1=1 and barcode = '" & s_barcode & "') as s1 left join (select goodscode,sum(number*flag) as t_num ,case when round(sum(number*flag),9)=0 then 0 else round(round(sum(inprice*number*flag),9)/round(sum(number*flag),9),9) end as avgprice from s_count where adddate<='"&s_date&"' and depotname='" & s_depot & "' group by goodscode) as s2 on s1.goodscode = s2.goodscode"
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1
If rs.eof Then
Else
	s_goodscode = rs("goodscode")
	s_goodsname = rs("goodsname")
	s_goodsunit = rs("goodsunit")
	s_units     = rs("units")
	s_inprice   = rs("inprice")
	s_outprice  = rs("outprice")
	s_remark    = rs("remark")
	s_t_num     = rs("t_num")
	s_avgprice  = rs("avgprice")
	response.write s_goodscode&"|"&s_goodsname&"|"&s_goodsunit&"|"&s_units&"|"&s_inprice&"|"&s_outprice&"|"&s_remark&"|"&s_t_num&"|"&s_avgprice
	response.end
End If
rs.close
%>
