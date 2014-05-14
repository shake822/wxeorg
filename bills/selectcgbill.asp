<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script language="JavaScript" src="../js/ShowHideDiv.js"></script>
<script>
function choosebill(str1){
	window.open('lingliaobill.asp?billcode='+str1+'&choosebill=true','main');
	window.close();	
}
</script>
<title>采购单选择</title>
</head>
<body style=""padding:0px;margin:0px;"" onmousemove="movediv(event)" onmouseup="obj=0">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<p align="center"><span class="STYLE1">采购单选择</span></p>
<table align="center"><tr><td>
<form name="form1" method="post" action="selectcgbill.asp">
<table border="0">
<tr>
<td align="center">从日期：</td>
      <td><input type="text" name="date1" size="16"  value=<%
			If Request("date1") = "" Then
				Response.Write s_date1
			Else
				Response.Write Request("date1")
			End If%>><%showdate("date1")%></td>
      <td align="center">到日期：</td>
      <td><input type="text" name="date2" size="16"  value=<%
If Request("date2") = "" Then
    Response.Write Date()
Else
    Response.Write Request("date2")
End If
%>><%showdate("date2")%></td>
<td align="center">
供应商/客户：<input type="text" name="cust" id="cust" value="<%=request("cust")%>"><a href="../common/selectcust.asp" target="_blank"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
<td align="center">
<input type="submit" value=" 查 找 "  class="button">
<input type="button" value="更多条件" class="button" onClick="show_hide_div()">
</td></tr></table>
<div id="mdiv"style="position:absolute; visibility:hidden;top:178px; left:260px;background:#E9F0F8; border:1px solid #AFB799; font-family:verdana; font-size:12px;color=#111;" >
<table width="220px" border="0" cellpadding="0" cellspacing="0" style="border:0 solid #e7e3e7;border-collapse:collapse;">
    <tr height="20" onMouseDown="finddiv(event,mdiv)" style="cursor:move;z-index:100">
        <td colspan="2" background="../img/listbar_bg.jpg" width="220px" class="bg">
            &nbsp;<font color="#FFFFFF">更多条件</font>
        </td>
	<tr>
		<td width="30%">&nbsp;单&nbsp;&nbsp;&nbsp;&nbsp;号：</td>
		<td><input type="text" name="billcode" value="<%=request("billcode")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;货品名称：</td>
		<td><input type="text" name="goodscode" value="<%=request("goodscode")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;货品编码：</td>
		<td><input type="text" name="goodsname" value="<%=request("goodsname")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;货品规格：</td>
		<td><input type="text" name="goodsunit" value="<%=request("goodsunit")%>" size="16"></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="submit" class="button" value="&nbsp;查&nbsp;询&nbsp;">
			   <input type="button" id="_close" class="button" value="&nbsp;关&nbsp;闭&nbsp;" onClick="show_hide_div()"></td>
</tr>
</table>
</div>
</form>
<%
sql_depot = "select depotname from t_user where username='"&request.cookies("username")&"'"
Set rs_depot = conn.Execute(sql_depot)
arr = split(rs_depot("depotname"),",")
if ubound(arr) <> -1 then
  for i = lbound(arr) to ubound(arr)-1
	s_depotpower = s_depotpower & "'" & arr(i) & "',"
  next
end if
if (request.cookies("username") <> "admin") and rs_depot("RDepot") then  '非admin用户没有开启往来单位资料
  sDepotname = " and depotname in (" & s_depotpower & "'a')" 
else
  sDepotname = ""
end if

sql_cust = "select custname from t_user where username='"&request.cookies("username")&"'"
Set rs_cust = conn.Execute(sql_cust)
arr = split(rs_cust("custname"),",")
temp_cust = ""
if ubound(arr) <> -1 then
  for i = lbound(arr) to ubound(arr)-1
    temp_cust = temp_cust & "'" & arr(i) & "',"
  next
end if
if Request("cust") = "" then
  s_cust = " and custname in ("&temp_cust&"'a')"
else
  s_cust = " and custname = '"&request("cust")&"'"
end if
if Request.Form("billcode") = "" then
	sBillcode = ""
else
	sBillcode = " and billcode = '" & Request.Form("billcode") & "'"
end if
if Request.Form("goodscode") = "" then
	sGoodscode = ""
else
	sGoodscode = " and goodscode = '" & Request.Form("goodscode") & "'"
end if
if Request.Form("goodsname") = "" then
	sGoodsname = ""
else
	sGoodsname = " and goodsname like '%" & Request.Form("goodsname") & "%'"
end if
if Request.Form("goodsunit") = "" then
	sGoodsunit = ""
else
	sGoodsunit = " and goodsunit = '" & Request.Form("goodsunit") & "'"
end if
If Request.Form("date1")<>"" Then
    s_date1 = Request.Form("date1")
End If
If Request.Form("date2")<>"" Then
    s_date2 = Request.Form("date2")
End If

sql = "select distinct billcode,adddate,custname,depotname,username,memo from s_billdetail where AddDate<='"&s_date2&"' and AddDate>='"&s_date1&"' and billtype='采购入库'"&s_cust&sBillcode&sGoodscode&sGoodsname&sGoodsunit&sDepotname&" order by adddate desc,billcode desc"
set rs = server.createobject("adodb.recordset")
rs.open sql, conn, 1, 1

sql_sys = "select * from T_SoftInfo"
	Set rs_sys = conn.Execute(sql_sys) 
    rs.pagesize = rs_sys("pagerecord")
    If request("page")<>"" Then
        epage = CInt(request("page"))
        If epage<1 Then epage = 1
        If epage>rs.pagecount Then epage = rs.pagecount
    Else
        epage = 1
    End If
    If Not rs.EOF Then rs.absolutepage = epage
%>
<table style="font-size:12px;" width="780" id="sqd" align="center" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#FFFFEE">
<tr align="center">
	<th width=4%>操作</th>
  <th width=15%>单据编号</th>
  <th width=10%>日期</th>
  <th width=10%>往来单位</th>
  <th width=10%>仓库</th>
  <th width=10%>经办人</th>
  <th width=15%>备注</th>
</tr>
<%if rs.eof=false then 
For i = 0 To rs.pagesize -1
    If rs.bof Or rs.EOF Then Exit For
%>
<tr align="center" onClick="choosebill('<%=rs("billcode")%>');">
  <td><a href="javascript:choosebill('<%=rs("billcode")%>');">选择</a></td>
  <td><%=rs("billcode")%></td>
  <td><%=rs("adddate")%></td>
  <td><%=rs("custname")%></td>
  <td><%=rs("depotname")%></td>
  <td><%=rs("username")%></td>
  <td><%=rs("memo")%></td>
</tr>
<%rs.movenext
next
end if
%>
<%
 Set mypage=new xdownpage '创建对象 
 mypage.getconn=conn '得到数据库连接 
 mypage.getsql=sql
 mypage.pagesize=rs_sys("pagerecord") '设置每一页的记录条数据为5条 
 set rs=mypage.getrs() '返回Recordset 
 
 Response.Write "<table align=""center"" width='780px' border=0>"
 Response.Write "<tr>"
 Response.Write "<th colspan=6 align=""left"">"
 mypage.showpage()  '显示分页信息，这个方法可以，在set rs=mypage.getrs()以后任意位置调用，可以调用多次 
 'Response.Write "<label class=""button1""><input type=""submit"" value=""Excel""></label>"
 Response.Write "</th></tr></table>"
 Response.Write "</form>"
 endconnection
%>
<div id="search_suggest" class="billdetail" style="display: none; position:absolute;"></div>
</body>
</html>
