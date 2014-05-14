<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script>
function choose(str1){
window.open('addproduct.asp?billcode='+str1+'&depot1=<%=Request.QueryString("depot1")%>&depot2=<%=Request.QueryString("depot2")%>&username=<%=Request.QueryString("username")%>&adddate=<%=Request.QueryString("adddate")%>','main');
window.close();	
}
</script>
<title>选择模板</title>
</head>

<body>
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<form name="form1" method="post" action="selectmodel.asp">
<table align="center">
<tr>
      <td>产品名称：</td>
      <td><input type="text" name="goodsname" value="<%=request.Form("goodsname")%>" size="16"></td>
      <td>产品编码：</td>
      <td ><input type="text" name="goodscode" value="<%=request.Form("goodscode")%>" size="16"></td>
      <td><input type="submit" value=" 查 找 "  class="button"></td>
</tr>
</table>
</form>
<%
if request.Form("goodscode") = "" then
	sGoodsCode = ""
else
	sGoodsCode = " and totalgoodscode = '" & Request.Form("goodscode") & "'"
end if

if Request.Form("goodsname") = "" then
	sGoodsName = ""
else
	sGoodsName = " and totalgoodsname like '%" & Request.Form("goodsname") & "%'"
end if

sql = "select distinct '<input type=button value=选择此模板 class=button onClick=choose('''+billcode+''')>' as action,billcode,totalgoodscode,totalgoodsname,totalgoodsunit,totalunits,totalnumber from s_model where 1=1 " & sGoodsCode & sGoodsName
call showpage(sql,"selectmodel",1)
%>
</body>
</html>
