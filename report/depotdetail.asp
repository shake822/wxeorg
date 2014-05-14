<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strDepotDetail") %>
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
</script>
<title>库存明细</title>

</head>

<body leftmargin="0" topmargin="0">
<br>
<div align="left"><span class="style1">库存明细报表</span></div>
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<form id="form1" name="sample" method="post" action="depotdetail.asp?goodscode=<%=Request.QueryString("goodscode") %>">
  <table width="100%" border="0" id="tbl_tittle">
    <tr>
      <td width="70" align="right">仓库名称：</td>
      <td width="150">
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
      sql_depot = "select * from t_depot where depotname in (" & s_depotpower & "'a')"
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
      <td width="70" align="right">货品类别：</td>
      <td width="150"><label>
	  <input type="hidden" name="typecode" id="typecode" value="<%=request.Form("typecode")%>">
      <input type="text" name="nodename" id="nodename" size="16" value=<%=Request.Form("nodename")%> ><a href="#" onClick="window.open ('../common/tree.asp?type=goods', 'newwindow', 'height=400, width=200,left=600,top=200,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=yes')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></label></td>
      <td rowspan="3"><input type="submit" name="Submit" value=" 查 询 " class="button" /></td>
    </tr>
    <tr>
      <td height="26" width="70" align="right">从&nbsp;日&nbsp;期：</td>
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
End If

%>><%showdate("date2")%></td>
    </tr>
  </table>
  <hr>
</form>
<%
If Request.Form("date1")<>"" Then
    s_date1 = Request.Form("date1")
End If
If Request.Form("date2")<>"" Then
    s_date2 = Request.Form("date2")
End If
If Request.Form("depot") = "" Then
   s_depotname = " and depotname in (" & s_depotpower & "'a')"
Else
    s_depotname = " and depotname = '"&Request.Form("depot")&"'"
End If

sql = "select top 1000000 adddate,billcode,billtype,custname,case when flag=1 then number else 0 end as inqty,case when flag=-1 then number else 0 end as outqty,price,money,maker,depotname,username from s_billdetail where flag <> 0 and goodscode = '"& Request.QueryString("goodscode") &"'"&s_depotname&" and adddate between '"&s_date1&"' and '"&s_date2&"'order by adddate"

call showpage(sql,"rgoodsdepot1",1)

endconnection
%>
</body>
</html>
