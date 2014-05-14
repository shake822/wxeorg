<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
on error resume next
conn.BeginTrans

s_goodsid = Trim(Request.Form("goodsid"))
s_goodscode = Trim(Request.Form("goodscode"))
s_goodsname = Trim(Request.Form("goodsname"))
s_goodsunit = Trim(Request.Form("goodsunit"))
s_units = Trim(Request.Form("units"))
s_inprice = Trim(Request.Form("inprice"))
s_outprice = Trim(Request.Form("outprice"))
s_barcode = Trim(Request.Form("barcode"))
s_depotup = Trim(Request.Form("depotup"))
s_depotdown = Trim(Request.Form("depotdown"))
s_remark = Trim(Request.Form("remark"))
s_goodstype = Trim(Request.Form("goodstype"))
s_typecode = Trim(Request.Form("typecode"))
s_img = Trim(Request.Form("img"))
if s_inprice="" then s_inprice = "0" end if
if s_outprice="" then s_outprice = "0" end If
if s_depotup="" then s_depotup = "0" end if
if s_depotdown="" then s_depotdown = "0" end if

If Request.QueryString("type") = "edit" Then
	ck="false"
	gcode=s_goodscode
Else
	ck="true"
	gcode=""
	sql_check = "select count(*) as c from t_goods where goodscode='"&s_goodscode&"'"
	set rs_check = server.CreateObject("adodb.recordset")
	rs_check.Open sql_check, conn, 1, 1
	if CInt(rs_check("c")) > 0 then
		Response.Write("<script language=javascript>alert('货品编码有重复!');history.go(-1);</script>")
		Response.End()
	end if
	close_rs(rs_check)
	s_goodsid = "0"
End If

sql = "select * from t_goods where goodsid = " & s_goodsid
set rs = Server.CreateObject("adodb.recordset")  
rs.Open sql, conn, 1, 3
if ck = "true" then 
	rs.addnew 
end if
rs("goodscode") = s_goodscode
rs("goodsname") = s_goodsname
rs("goodsunit") = s_goodsunit
rs("units") = s_units
rs("inprice") = s_inprice
rs("outprice") = s_outprice
rs("barcode") = s_barcode
rs("depotup") = s_depotup
rs("depotdown") = s_depotdown
rs("remark") = s_remark
rs("goodstype") = s_goodstype
rs("code") = s_typecode
rs("img") = s_img
rs.update
rs.close
set rs = nothing
sql = "update t_billdetail set goodscode='"&s_goodscode&"',goodsname='"&s_goodsname&"',goodsunit='"&s_goodsunit&"',units='"&s_units&"' where goodscode='"& s_goodscode & "'"
conn.Execute(sql)
if err <> 0 then
	Response.Write("<script>alert('保存失败!');location.href='../common/addgoods.asp?add="&ck&"&goodscode="&gcode&"';</script>")
	conn.rollbacktrans
else
	Response.Write("<script>alert('保存成功！');location.href='../common/addgoods.asp?add="&ck&"&goodscode="&gcode&"';</script>")
	conn.CommitTrans
end if
endconnection
%>
<script language=javascript>


</script>
