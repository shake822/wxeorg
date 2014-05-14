<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
if Request.QueryString("type") = "fk" then
  call CheckAuthority("strBrowseFK")
else
  call CheckAuthority("strBrowseSK")
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>开票查询</title>
<SCRIPT   language="javascript">
function delall(){
	var iCount = 0;
	var index = "";
	$("._del").each(
		function(i)
		{
			chk = $(this)
			if(chk.attr("checked") == true){
				iCount = iCount + 1;
			}
		}
	);
	if(confirm('确定要删除选择的'+iCount+'条货品的资料吗?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this)
				if(chk.attr("checked") == true){
					index = chk.attr("id");
					index = index.substring(2);
					$("#tr" + index).remove();
					$.post("../select/delallinvoice.asp",{invoicecode:escape(chk.val())},
					function(data)
					{ 
					}
					);
				}
			}
		)//遍历结束
	}
}function edit(str){
openwin('addinvoice.asp?add=false&invoicecode='+str,600,400);	
}
function NewBill(str){
openwin('addinvoice.asp?add=true&type='+str,600,400);
}
</script>
<script language="JavaScript" src="../js/ShowHideDiv.js"></script>
</head>

<body style=""padding:0px;margin:0px; bgcolor="#FFFFFF"""  onmousemove="movediv(event)" onmouseup="obj=0">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<%
sDate1 = Year(Date()) & "-" & Month(Date()) & "-1"
sDate2 = Date()
%>
<br>
<div align="left"><span class="STYLE1">
<%
If Request.QueryString("type") = "KP" Then
    Response.Write "采购收票查询"
	btnName = "新增收票单"
Else
    Response.Write "销售开票查询"
	btnName = "新增开票单"
End If
%></span></div>
<table align="left">
<tr><td>
<form name="form1" method="post" action="invoice.asp?type=<%=Request.QueryString("type")%>">
<table border="0">
<tr>
    <td align="right">从&nbsp;日&nbsp;期：</td>
    <td><input type="text" name="date1" size="16" value=<%
    If Request("date1") = "" Then
        Response.Write Year(Date()) & "-" & Month(Date()) & "-1"
    Else
        Response.Write Request("date1")
    End If%>><%showdate("date1")%></td>
    <td align="right">到&nbsp;日&nbsp;期：</td>
    <td><input type="text" name="date2" size="16" value=<%
    If Request("date2") = "" Then
        Response.Write Date()
    Else
        Response.Write Request("date2")
    End If%>><%showdate("date2")%></td> 
  <td width="85" ><input class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  type="submit" value="&nbsp;查&nbsp;&nbsp;找&nbsp;">
  	</td>
<td width="85">
 <input type="button"onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"   value="更多条件" class="button" onClick="show_hide_div()">
                  </td>
</tr>
<tr>
  <td align="right">发&nbsp;票&nbsp;号：</td>
  <td><input type="text" name="cashcode" value="<%=request.Form("invoicecode")%>" size="16"></td>
  <td align="right">往来单位：</td>
  <td><input type="text" name="custname" value="<%=request.Form("custname")%>" size="16"></td>
</tr>
</table>
<div id="mdiv"style="position:absolute; visibility:hidden;top:178px; left:260px;background:#E9F0F8; border:1px solid #AFB799; font-family:verdana; font-size:12px;color=#111;" >
<table width="220px" border="0" cellpadding="0" cellspacing="0" style="border:0 solid #e7e3e7;border-collapse:collapse;">
    <tr height="20" onMouseDown="finddiv(event,mdiv)" style="cursor:move;z-index:100">
        <td colspan="2" background="../img/listbar_bg.jpg" width="220px" class="bg">
            &nbsp;<font color="#FFFFFF">更多条件</font>
        </td>
	<tr>
		<td width="30%">&nbsp;出入库单：</td>
		<td><input type="text" name="billcode" value="<%=request("billcode")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;经&nbsp;办&nbsp;人：</td>
		<td><input type="text" name="maker" value="<%=request("maker")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
		<td><input type="text" name="memo" value="<%=request("memo")%>" size="16"></td>
	</tr>
	<tr>
		<td>&nbsp;金&nbsp;&nbsp;&nbsp;&nbsp;额：</td>
		<td><input type="text" name="money" value="<%=request("money")%>" size="16"></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="submit" class="button" value="&nbsp;查&nbsp;询&nbsp;">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			   <input type="button" id="_close" class="button" value="&nbsp;关&nbsp;闭&nbsp;" onClick="show_hide_div()"></td>
</tr>
</table>
</div>
<hr>

<table>
<tr>
<td valign="top">
<input type="button" value="<%=btnName%>" class="button" onClick="NewBill('<% = Request.QueryString("type")%>','')">
<input type="button" class="button" value="删除" onClick="delall();">
</td>
</tr>

<tr>
<td valign="top"  style="margin-top:10px">


</form>
<div style="margin-top:0px">
<%
if Request.Form("date1") <> "" then
	sDate1 = Request.Form("date1")
end if

if Request.Form("date2") <> "" then
	sDate2 = Request.Form("date2")
end if

if Request.Form("cashcode") = "" then
	sCashcode = ""
else
	sCashcode = " and invoicecode = '" & Request.Form("cashcode") & "'"
end if


sql_cust = "select custname,RDepot from t_user where username='"&request.cookies("username")&"'"
Set rs_cust = conn.Execute(sql_cust)
temp_cust=""
sql = "select custname from t_custom where 1=1"
set rs=conn.execute(sql)
 Do While rs.eof=False
 s_cust = s_cust & "'" & rs("custname") & "',"
  rs.movenext
  loop 
 temp_cust =  s_cust 
if Request.Form("custname") = "" then
	sCustname = " and custname in ("&temp_cust&"'a')"
else
	sCustname = " and custname like '%" & Request.Form("custname") & "%'"
end if

if Request.Form("billcode") = "" then
	sBillcode = ""
else
	sBillcode = " and billcode = '" & Request.Form("billcode") & "'"
end if

if Request.Form("maker") = "" then
	sMaker = ""
else
	sMaker = " and maker = '" & Request.Form("maker") & "'"
end if

if Request.Form("memo") = "" then
	sMemo = ""
else
	sMemo = " and memo = '" & Request.Form("memo") & "'"
end if

if Request.Form("money") = "" then
	sMoney = ""
else
	sMoney = " and money = " & Request.Form("money")
end if


sql = "select '<a href=# onClick=edit('''+invoicecode+''')>'+invoicecode+'</a>' as ainvoicecode,* from t_invoice where AddDate<='"&sDate2&"' and AddDate>='"&sDate1&"' and type='"&Request.QueryString("type")&"'"&sCashcode&sCustname&sBillcode&sMaker&sMemo&sMoney

call showpage(sql,"invoice",1)
%>
</div>
</td></tr></table>
</div>
</body>
</html>
