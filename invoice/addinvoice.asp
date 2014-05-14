<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../inc/config.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<title>发票管理</title>
<script type="text/javascript" src="../js/jQuery.js"></script>
<script language="JavaScript" src="../js/ShowHideDiv.js"></script>
<script>
function check_code(){
	if ($("#invoicecode").val() == "") {
		$("#check").attr("innerHTML","<li style='float:left;'><img src='../img/btn_false.gif'></li><li  style='float:left;width:auto'><strong><font color=#FF0000>不能为空</font></strong></li>"); 
	}else{
    $.post("addinvoice_ajax_code.asp",{invoicecode:escape($("#invoicecode").val())},
	function(data)
	{ 
       if (data == "True"){
		   $("#check").attr("innerHTML","<img src='../img/btn_true.gif'>"); 
		   }else{
		   $("#check").attr("innerHTML","<li style='float:left;width:auto'><img src='../img/btn_false.gif'></li><li style='float:left;width:auto'><strong><font color=#FF0000>发票号重复</font></strong></li>");
	   }
	}
	);
	}
}

function check(){
	if (document.getElementById("invoicecode").value==""){
		alert("请输入发票号！");
		document.getElementById("invoicecode").focus();
		return false; 
	}
}

</script>
</head>

<body style="padding:0px;margin:0px;">

<%
set rs = Server.CreateObject("adodb.recordset")
sql = "select * from t_invoice where invoicecode='"& Request.QueryString("invoicecode") &"'"
rs.open sql,conn,1,1

If Request.QueryString("add")<>"true" Then
	sAction = "addinvoiceaction.asp?add=false&type=" & rs("type")
	sid = rs("id")
	sInvoicecode = rs("invoicecode")
	sAdddate = rs("adddate")
	sCustname = rs("custname")
	sMoney = rs("money")
	sType = rs("type")
	sMaker = rs("maker")
	sMemo = rs("memo")
	sBillcode = rs("billcode")
	sCheckinvoicecode = ""
else
	sAction = "addinvoiceaction.asp?add=true&type=" & Request.QueryString("type")
	sInvoicecode = ""
	sAdddate = ""
	sCustname = ""
	sMoney = ""
	sType = Request.QueryString("type")
	sMaker = request.cookies("username")
	sMemo = ""
	sBillcode = ""
	sCheckinvoicecode = "<div id=""check"" ></div>"
end if

if sType = "KP" then
	sTitle = "收票单"
	sDate = "收票日期"
else
	sTitle = "开票单"
	sDate = "开票日期"
end if
%>

<form name="form1" method="post" onSubmit="return check();" action="<%=sAction%>">
<input type="hidden" name="id" value="<%=sid%>">
<br><div align="center"><span class="STYLE1"><%=sTitle%></span></div><br>
<table align="center"  border="0">
  <tr>
    <td align="center">发&nbsp;票&nbsp;号：</td>
    <td >
    	<input type="text" name="invoicecode" onBlur="check_code();" id="invoicecode" value="<%=sInvoicecode%>">
        </td>
   	<td><%=sCheckinvoicecode%></td>
  </tr>
  <tr>
    <td align="center"><%=sDate%>：</td>
    <td>
    	<input type="text" name="adddate" id="adddate" value="<%=sAdddate%>">
        <%showdate("adddate")%></td>
    <td></td>
  </tr>
  <tr>
    <td align="center">相关单据：</td>
    <td><input type="text" name="billcode" id="billcode" value="<%=sBillcode%>">
    <a href="#" onClick="JavaScript:window.open ('selectbill.asp?type=<%=Request.QueryString("type")%>', 'newwindow', 'left=150,top=100,height=600, width=800, toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
    <td></td>
  </tr>
  <tr>
    <td align="center">往来单位：</td>
    <td><input type="text" name="cust" id="cust" value="<%=sCustname%>">
    	<a href="../common/selectcust.asp?type=<%=Request.QueryString("type")%>" target="_blank"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
    <td></td>
  </tr>
  <tr>
    <td align="center">金&nbsp;&nbsp;&nbsp;&nbsp;额：</td>   
    <td><input type="text" name="money" id="money" value="<%=sMoney%>"></td>
    <td></td>
  </tr>
  <tr>
	<td align="center">经&nbsp;办&nbsp;人：</td>
    <td><input type="text" name="maker" id="maker" value="<%=sMaker%>"></td>
      <td></td>
  </tr>
  <tr>
    <td align="center">备&nbsp;&nbsp;&nbsp;&nbsp;注：</td>
    <td><input type="text" name="memo" id="memo" value="<%=sMemo%>"></td>
    <td></td>
  </tr>
</table><br>
<div align="center"><input name="submit" type="submit" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"   onClick="return check();" class="button" value=" 保 存 " >
                    <input name="submit" type="reset" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button" value=" 重 置 " ></div>
</form>
</body>

<%
endconnection
%>

</html>
