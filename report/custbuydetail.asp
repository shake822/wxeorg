<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
sql_power = "select * from t_power where code='0112' and user='"&request.cookies("username")&"'"
Set rs_power = conn.Execute(sql_power)
if rs_power("flag") = false then
%>
<script language=javascript>
alert("该操作员没有此权限！");
window.location='../common/main.asp'
</script>
<%end if%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script language="JavaScript" src="../js/exportexcel.js"></script>
<title>采购汇总表</title>
</head>

<body>
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<form id="form1" name="sample" method="post" action="custbuydetail.asp">
  <table width="100%" border="0" id="tbl_tittle">
    <tr>
      <td width="13%" height="24">仓库名称</td>
      <td width="22%">
      <%
      Response.Write "<select name=""depot"">"
	  Response.Write "<option value=""""></option>"
      sql_depot = "select depotname from t_user where username='"&request.cookies("username")&"'"
      Set rs_depot = conn.Execute(sql_depot)
      arr = split(rs_depot("depotname"),",")
      if ubound(arr) <> -1 then
        for i = lbound(arr) to ubound(arr)-1
          s_depotpower = s_depotpower & "'" & arr(i) & "',"
	    next
      end if
      sql_depot = "select * from t_depot where depotname in (" & s_depotpower & ")"
      set rs_s_depot = conn.execute(sql_depot)
      Do While rs_s_depot.EOF = False
        if Request.Form("depot") = rs_s_depot("depotname") then
	      Response.Write "<option value="&rs_s_depot("depotname")&" selected>"&rs_s_depot("depotname")&"</option>"
	    else
	      Response.Write "<option value="&rs_s_depot("depotname")&">"&rs_s_depot("depotname")&"</option>"
	    end if
	   rs_s_depot.movenext
      loop
      Response.Write "</select>"
	  close_rs(rs_depot)
	  close_rs(rs_s_depot)
	  %>
	  </td>
      <td width="8%">供应商</td>
      <td width="23%"><label>
      <input type="text" name="custname" id="cust" size="16" value=<%=Request.Form("custname")%> ><a href="#" onClick="JavaScript:window.open ('../common/selectcust.asp', 'newwindow', 'left=150,top=100,height=600, width=800, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></label></td>
      <td width="33%" rowspan="3"><input type="submit" name="Submit" value=" 查 询 " class="button" /></td>
    </tr>
    <tr>
      <td height="26">从日期</td>
      <td><label>
      <input type="text" name="date1" size="16" value=<%
If Request("date1") = "" Then
    Response.Write Year(Date()) & "-" & Month(Date()) & "-1"
Else
    Response.Write Request("date1")
End If

%>><%showdate("date1")%></label></td>
      <td>到日期</td>
      <td><input type="text" name="date2" size="16" value=<%
If Request("date2") = "" Then
    Response.Write Date()
Else
    Response.Write Request("date2")
End If

%>><%showdate("date2")%></td>
    </tr>
	<tr><td>货品名称</td><td><input type="text" name="goodsname" id="goodsname" size="16"></td>
	<td>经办人：</td><td><select name="user" id="user">
	<option value=""></option>
    <%
sql = "select * from t_Employee"
Set a = conn.Execute(sql)
Do While a.EOF = False
    s_name = a("name")
    If Request.Form("user") = a("name") Then
        Response.Write "<option value="&s_name&" selected>"&s_name&"</option>"
    Else
        Response.Write "<option value="&s_name&">"&s_name&"</option>"
    End If
    a.movenext
Loop
close_rs(a)
%>
	</select></td></tr>
  </table>
</form>
<div align="center"><span class="style1">供应商采购明细表</span></div>
<%
If Request.Form("date1")<>"" Then
    s_date1 = Request.Form("date1")
End If
If Request.Form("date2")<>"" Then
    s_date2 = Request.Form("date2")
End If
If Request.Form("depot") = "" Then
    s_depotname = " and depotname in ("&s_depotpower&")"
Else
    s_depotname = " and depotname='"&Request.Form("depot")&"'"
End If
If Request.Form("custname") = "" Then
    s_custname = ""
Else
    s_custname = " and t_bill.custname='"&Request.Form("custname")&"'"
End If
If Request.Form("goodsname") = "" Then
    s_goodsname = ""
Else
    s_goodsname = " and goodsname='"&Request.Form("goodsname")&"'"
End If
If Request.Form("user") = "" Then
    s_user = ""
Else
    s_user = " and username='"&Request.Form("user")&"'"
End If
sql = "select goodscode,goodsname,billtype,adddate,t_bill.custname as custname,price,number,money,goodsunit,username,discount,units,t_bill.billcode as billcode,depotname,memo from s_billdetail where flag<>0 and billtype like '采购%' and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname&s_custname&s_goodsname&s_user
call showpage(sql,"R_GoodsBuydetail",1)
endconnection
%>
</body>
</html>
