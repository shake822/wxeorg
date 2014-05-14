<!-- #include file="../inc/conn.asp" -->
<%
connstr="DBQ="&Server.Mappath("../Database/JXC.mdb")&";DRIVER={Microsoft Access Driver (*.mdb)};" 
set conn1=Server.CreateObject("adodb.connection") 
conn1.Open connstr
sql = "select * from t_temp_goods  "
Set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn1, 1, 1


sql = "select * from t_goods where goodsid=0"
set rs_sql = server.createobject("adodb.recordset")
rs_sql.open sql, conn, 1, 3
Response.Write rs_sql.recordcount

s_num = rs.recordcount
for i=0 to rs.recordcount - 1
	if rs.bof or rs.eof then exit for
	rs_sql.addnew
	Response.Write i
	rs_sql("goodscode")=rs("货品编码")
	rs_sql("goodsunit")=rs("货品规格")
	rs_sql("goodsname")=rs("货品名称")
	rs_sql("units")=rs("单位")
	rs_sql("goodstype")=rs("货品类别")
	rs_sql("inprice")=rs("入库价")
	rs_sql("outprice")=rs("出库价")
	rs_sql("barcode")=rs("条形码")
	rs_sql("depotup")=rs("库存上限")
	rs_sql("depotdown")=rs("库存下限")
	rs_sql("remark")=rs("备注")
	rs.movenext
next
Response.End()
rs_sql.update
rs_sql.close
rs.close
conn1.close : set conn1=nothing
sql = "update v_goodstype set code=treecode"
conn.execute(sql)
endconnection
response.write "<script language=javascript>alert('成功导入"&s_number&"行货品资料！');</script>"
'response.Redirect "../common/importgoods.asp"
%>