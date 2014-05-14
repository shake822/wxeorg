<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title></title>
<SCRIPT   language="javascript">
function del(str,check){
if(check==1){
alert('审核过的单据不允许删除！');
return false;
}
if(!confirm('确定要删除该单据吗?')){
return false
}else{
window.location.href='../action/delbill.asp?billcode='+str
}
}
function NewBill(str){
openwin('addbill.asp?type='+str,900,600)
}
function NewBackBill(str,billcode,check){
if(check==0){
alert('未审核的单据不允许退货！');
return false;
}
openwin('backbill.asp?type='+str+'&planbillcode='+billcode,900,600)
}
function EditBill(str){
openwin('editbill.asp?billcode='+str,900,600);
}
function delall(){
	var iCount = 0;
	var index = 0;
	var iSucceed = 0;
	var errMsg = "";
	$("._del").each(
		function(i)
		{
			chk = $(this)
			if(chk.attr("checked") == true){
				iCount = iCount + 1;
			}
		}
	);
	if(confirm('确定要删除选择的'+iCount+'条单据吗?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this)
				if(chk.attr("checked") == true){
					$.post("../select/delallbill.asp",{billcode:escape(chk.val())},
					function(data)
					{ 
						index = index + 1;
						if(data == "True"){
							iSucceed = iSucceed + 1;
						}else{
							errMsg = errMsg + data + "\n";
						}
						if(index == iCount){
							alert("成功删除"+iSucceed+"张单据!");
							if(iCount != iSucceed){
								alert("未成功删除单据：\n" + errMsg);
							}
							window.location.reload();
						}
					}
					);
				}
			}
		)//遍历结束
	}
}
function checkall(){
	var iCount = 0;
	var index = 0;
	var iSucceed = 0;
	var errMsg = "";
	$("._del").each(
		function(i)
		{
			chk = $(this)
			if(chk.attr("checked") == true){
				iCount = iCount + 1;
			}
		}
	);
	if(confirm('确定要审核共'+iCount+'张单据吗?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this);
				if(chk.attr("checked") == true){
					code = chk.val();
					$.post("../select/checkbill.asp",{billcode:escape(chk.val())},
					function(data)
					{ 
						index = index + 1;
						if(data == "True"){
							iSucceed = iSucceed + 1;
						}else{
							errMsg = errMsg + data + "\n";
						}
						if(index == iCount){
							alert("成功审核"+iSucceed+"张单据!");
							if(iCount != iSucceed){
								alert("未成功单据：\n" + errMsg);
							}
							window.location.reload();
						}
					}
					);
				}
			}
		)//遍历结束
	}
}
function uncheckall(){
	var iCount = 0;
	var index = 0;
	var iSucceed = 0;
	var errMsg = "";
	$("._del").each(
		function(i)
		{
			chk = $(this)
			if(chk.attr("checked") == true){
				iCount = iCount + 1;
			}
		}
	);
	if(confirm('确定要反审共'+iCount+'张单据吗?')){
		$("._del").each( 
			function(i)
			{
				chk = $(this)
				if(chk.attr("checked") == true){
					$.post("../select/uncheckbill.asp",{billcode:escape(chk.val())},
					function(data)
					{
						index = index + 1;
						if(data == "True"){
							iSucceed = iSucceed + 1;
						}else{
							errMsg = errMsg + data + "\n";
						}
						if(index == iCount){
							alert("成功反审"+iSucceed+"张单据!");
							if(iCount != iSucceed){
								alert("未成功单据：\n" + errMsg);
							}
							window.location.reload();
						}
					}
					);
				}
			}
		)//遍历结束
	}
}
</SCRIPT>
<script language="JavaScript" src="../js/ShowHideDiv.js"></script>
</head>

<body style=""padding:0px;margin:0px; bgcolor="#FFFFFF""" onmousemove="movediv(event)" onmouseup="obj=0">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div><br>
<div style="padding-left:10px">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<% if Request.QueryString("type")="CT" then%>
<p align="left"><span class="STYLE1">采购退货单查询</span></p>
<%
ElseIf Request.QueryString("type") = "XT" Then
%>
<p align="left"><span class="STYLE1">销售退货单查询</span></p>
<%end if%>
<table align="left"><tr><td>
<form name="form1" method="post" action="selectbackbill.asp?type=<%=request("type")%>">
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
供应商/客户：<input type="text" name="cust" id="cust" value="<%=request("cust")%>"><a href="#" onClick="JavaScript:window.open ('../common/selectcust.asp', 'newwindow', 'height=600, width=800,top=100,left=150, toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
<td align="center">
<input type="submit" value=" 查 找 "  class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" >
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" value="更多条件" class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  onClick="show_hide_div()">
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
		<td colspan="2" align="center"><input type="submit" class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value="&nbsp;查&nbsp;询&nbsp;">
			   <input type="button" id="_close" class="button" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"   value="&nbsp;关&nbsp;闭&nbsp;" onClick="show_hide_div()"></td>
</tr>
</form>
</table>
</div>
<hr>
<table >
<tr>
<td valign="top">
	<input type="button" class="button" value="删除" onClick="delall();">
	<input type="button" class="button" value="审核" onClick="checkall();">
	<input type="button" class="button" value="反审" onClick="uncheckall();">
</td>
</tr>
<tr>
<td valign="top"  style="margin-top:10px">
<div>
<%
sql_depot = "select depotname,RDepot from t_user where username='"&request.cookies("username")&"'"
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
sql_cust = "select custname,RCust from t_user where username='"&request.cookies("username")&"'"
Set rs_cust = conn.Execute(sql_cust)
arr = split(rs_cust("custname"),",")
temp_cust = ""
if ubound(arr) <> -1 then
  for i = lbound(arr) to ubound(arr)-1
    temp_cust = temp_cust & "'" & arr(i) & "',"
  next
end if
if Request("cust") = "" then
  s_cust = ""
else
  s_cust = " and custname = '"&request.Form("cust")&"'"
end if
if Request.Form("billcode") = "" then
	sBillcode = ""
else
	sBillcode = " and billcode = '" & Request.Form("billcode") & "'"
end if
if Request.Form("goodscode") = "" then
	sGoodscode = ""
else
	sGoodscode = " and billcode in (select billcode from t_billdetail where goodscode = '" & Request.Form("goodscode") & "')"
end if
if Request.Form("goodsname") = "" then
	sGoodsname = ""
else
	sGoodsname = " and billcode in (select billcode from t_billdetail where goodsname like '%" & Request.Form("goodsname") & "%')"
end if
if Request.Form("goodsunit") = "" then
	sGoodsunit = ""
else
	sGoodsunit = " and billcode in (select billcode from t_billdetail where goodsunit = '" & Request.Form("goodsunit") & "')"
end if
If Request.Form("date1")<>"" Then
    s_date1 = Request.Form("date1")
End If
If Request.Form("date2")<>"" Then
    s_date2 = Request.Form("date2")
End If
if Request.QueryString("type") = "CT" then
	sql = "select distinct '<a href=# onClick=EditBill('''+billcode+''')>'+billcode+'</a>' as abillcode,"
	sql = sql + "billcode,adddate,custname,depotname,username,memo,case when [check]=1 then '已审核' else '未审核' end as state,checkman,planbillcode "
	sql = sql + "from t_bill where AddDate<='"&s_date2&"' and AddDate>='"&s_date1&"' and billtype = '采购退货'"&s_cust&sBillcode&sGoodscode&sGoodsname&sGoodsunit&sDepotname&" order by adddate desc,billcode desc"
ElseIf Request.QueryString("type") = "XT" Then
	sql = "select distinct '<a href=# onClick=EditBill('''+billcode+''')>'+billcode+'</a>' as abillcode,"
	sql = sql + "billcode,adddate,custname,depotname,username,memo,case when [check]=1 then '已审核' else '未审核' end as state,checkman,planbillcode "
	sql = sql + "from t_bill where AddDate<='"&s_date2&"' and AddDate>='"&s_date1&"' and billtype = '销售退货'"&s_cust&sBillcode&sGoodscode&sGoodsname&sGoodsunit&sDepotname&" order by adddate desc,billcode desc"
end if
call showpage(sql,"selectback",3)
%>
<div id="search_suggest" class="billdetail" style="display: none; position:absolute;"></div>
</div>
</td>
</tr>
</table>
</body>
</html></table>
</body>
</html>