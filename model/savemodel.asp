<!-- #include file="../inc/conn.asp" -->
<%
If Request("add") = "false" Then
	sTotalGoodsCode = Request.Form("totalgoodscode")
	fTotalNumber = Request.Form("totalnumber")
	sBillCode = Request.Form("billcode")
	iRowCount = Request.Form("rowcount")
	sMemo = Request.Form("memo")
    sql = "update t_modeltotal set goodscode='"&sTotalGoodsCode&"',[number]="&fTotalNumber&",memo='"&sMemo&"' where billcode='"&sBillCode&"'"
    conn.Execute(sql)
    sql = "delete from t_modeldetail where billcode='"&sBillCode&"'"
    conn.Execute(sql)
    For i = 1 To iRowCount
        s_goodscode = Trim(Request.Form("goodscode"&i))
        s_goodsname = Trim(Request.Form("goodsname"&i))
        s_goodsunit = Trim(Request.Form("goodsunit"&i))
        s_units = Trim(Request.Form("units"&i))
        s_price = Trim(Request.Form("price"&i))
        s_number = Trim(Request.Form("number"&i))
        s_money = Trim(Request.Form("money"&i))
        s_remark = Trim(Request.Form("remark"&i))
        sql = "insert into t_modeldetail ([billcode],[goodscode],[goodsname],[goodsunit],[units],[price],[number],[money],[DetailNote]) values ('"&sBillCode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"')"
        on error resume next
        conn.Execute sql,recaffected
        if err <> 0 then
          Response.Write("No update permissions!")
        else
          Response.Write("<h3>" & recaffected & " record added</h3>")
        end if
    Next
Else
	sTotalGoodsCode = Request.Form("totalgoodscode")
	fTotalNumber = Request.Form("totalnumber")
	sBillCode = Request.Form("billcode")
	iRowCount = Request.Form("rowcount")
	sMemo = Request.Form("memo")
    sql = "insert into t_modeltotal ([billcode],[goodscode],[number],[memo]) values ('"&sBillCode&"','"&sTotalGoodsCode&"',"&fTotalNumber&",'"&sMemo&"')"
    conn.Execute(sql)
    For i = 1 To iRowCount
        s_goodscode = Trim(Request.Form("goodscode"&i))
        s_goodsname = Trim(Request.Form("goodsname"&i))
        s_goodsunit = Trim(Request.Form("goodsunit"&i))
        s_units = Trim(Request.Form("units"&i))
        s_price = Trim(Request.Form("price"&i))
        s_number = Trim(Request.Form("number"&i))
        s_money = Trim(Request.Form("money"&i))
        s_remark = Trim(Request.Form("remark"&i))
        sql = "insert into t_modeldetail ([billcode],[goodscode],[goodsname],[goodsunit],[units],[price],[number],[money],[DetailNote]) values ('"&sBillCode&"','"&s_goodscode&"','"&s_goodsname&"','"&s_goodsunit&"','"&s_units&"','"&s_price&"','"&s_number&"','"&s_money&"','"&s_remark&"')"
        on error resume next
        conn.Execute sql,recaffected
        if err <> 0 then
          Response.Write("No update permissions!")
        else
          Response.Write("<h3>" & recaffected & " record added</h3>")
        end if
    Next
End If
endconnection
Response.Redirect "../common/model.asp"
%>
