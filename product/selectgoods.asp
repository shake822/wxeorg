<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script language="JavaScript" src="../js/jquery.js"></script>
<script language="javascript" type="text/javascript">
$(document).ready(function() {
	$("#nodename").change(function() {
		if ($("#nodename").val()==""){
		$("#typecode").attr("value","");
		}
	});
});
function setHiddenCol(oTable,iCol)
{
    for (i=0;i < oTable.rows.length ; i++)
    {
        oTable.rows[i].cells[iCol].style.display = oTable.rows[i].cells[iCol].style.display=="none"?"block":"none";
		oTable.rows[i].cells[4].style.display = oTable.rows[i].cells[4].style.display=="none"?"block":"none";
    }
}


</script>
<title>选择商品</title>
</head>
<%
sql = "select * from t_user where username = '" & request.cookies("username") & "'"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
if rs("price")=0 then
  Response.Write "<body topmargin=""0"" onLoad=""setHiddenCol(tbl,8)"">"
else
  Response.Write "<body topmargin=""0"">"
end if
close_rs(rs)
%>
<table border="0">
<form name="form1" method="post" action="selectgoods.asp?adddate=<%=Request("adddate")%>&id=<%=request("id")%>">
<tr>
  <td id="td">货品编码</td>
  <td id="td"><input type="text" name="s_goodscode" size="16" value="<%=request.Form("s_goodscode")%>">&nbsp;&nbsp;</td>
  <td id="td">货品名称</td>
  <td id="td"><input type="text" name="s_goodsname" size="16" value="<%=request.Form("s_goodsname")%>">&nbsp;&nbsp;</td>
  <td>货品分类:</td>
  <td><input type="text" name="nodename" id="nodename" size="16" value=<%=Request.Form("nodename")%>><a href="#SelectDate" onClick="window.open ('../common/tree.asp?type=goods', 'newwindow1', 'height=400, width=200,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=no')"><img border="0" src="../img/choose.gif" width="21" height="17"></a><input type="hidden" name="typecode" id="typecode" value="<%=request.Form("typecode")%>" /></td>
  <td id="td"><input type="submit" name="select" value=" 查 询 "  class="button"></td>
  <td id="td"><input type="button" value="新增货品"  class="button" onClick="window.location.href='addgoods.asp?add=true&sel=true'" class="button"></td>
</tr>
</form>
</table>
<hr>
<%
if Request.QueryString("adddata") = "" then
	sDate = ""
else
	sDate = " and adddate<='"&Request.QueryString("adddate")&"'"
end if
if Request.Form("s_goodscode") = "" then
  s_goodscode = ""
else
  s_goodscode = " and goodscode like '%" & Request.Form("s_goodscode") & "%'"
end if 
if Request.Form("s_goodsname") = "" then
  s_goodsname = ""
else
  s_goodsname = " and InStr(1,LCase(goodsname),LCase('"&request("s_goodsname")&"'),0)<>0"
end if 
if Request.QueryString("depot") = "" then
  s_depot = ""
else
  s_depot = " and depotname = '"&request.QueryString("depot")&"'"
end if
if Request.Form("typecode") = "" then
  s_type = ""
else
  s_type = " and code like '" & request.Form("typecode")  & "%'"
end if
sql = "select s1.goodscode,goodsname,goodsunit,units,inprice,outprice,remark,t_num,avgprice from (select goodscode,goodsname,goodsunit,units,inprice,outprice,remark from t_goods where 1=1 "& s_goodscode & s_goodsname & s_type & ") as s1 left join (select goodscode,sum(number*flag) as t_num ,case when round(sum(number*flag),9)=0 then 0 else round(round(sum(inprice*number*flag),9)/round(sum(number*flag),9),9) end as avgprice from s_count where 1=1 " & sDate & s_depot & s_goodscode & s_goodsname & s_type & " group by goodscode) as s2 on s1.goodscode = s2.goodscode"
Call showpage(sql,"SelectGoods1",7)
endconnection
%>
</body>
</html>
