<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
If Request("type") = "fk" Then
    call CheckAuthority("strBrowseFK")
Else
    call CheckAuthority("strBrowseSK")
End If
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>无标题文档</title>
</head>

<body><br><br><br>
<div align="center"><span class="STYLE1">
<%
If Request("type") = "fk" Then
    Response.Write("付款单登记")
Else
    Response.Write("收款单登记")
End If
%>
</span></div>
<div align="center"><span class="STYLE1">
<%
sql = "select * from t_cash where id="&Request("id")
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
Response.Write rs("cashcode")
Response.Write "<INPUT type=hidden name=""billcode"" value="&rs("cashcode")&">"
%></span></div><br>
<table align="center" id="tbl" border-collapse:collapse width="600" border="1" cellpadding="2" cellspacing="0" bordercolorlight="#000000" bordercolordark="#FFFFFF">
          <tr>
            <td width="70" align="right"><%
If Request("type") = "fk" Then
    Response.Write("付款日期:")
Else
    Response.Write("收款日期:")
End If
%></td>
            <td width="230"><%=rs("adddate")%></td>
            <td width="70" align="right">
			<%If Request("type") = "fk" Then
    Response.Write("采购单号:")
Else
    Response.Write("销售单号:")
End If

%></td>
            <td width="230"><%=rs("billcode")%></td>
          </tr>
          <tr>
            <td align="right"><%If Request("type") = "fk" Then
    Response.Write("供&nbsp;应&nbsp;商:")
Else
    Response.Write("客&nbsp;&nbsp;&nbsp;&nbsp;户:")
End If

%></td>
            <td><%=rs("custname")%>&nbsp;</td>
			<td align="right">帐&nbsp;&nbsp;&nbsp;&nbsp;户:</td>
			<td><%=rs("account")%>&nbsp;</td>
          </tr>
   
          <tr>
            <td align="right">支付方式:</td>
            <td><%=rs("type")%>&nbsp;</td>
            <td align="right">实付金额:</td>
            <td><%=rs("money")%>&nbsp;</td>
          </tr>
         
          <tr>
            <td align="right">业&nbsp;务&nbsp;员:</td>
            <td><%=rs("user")%>&nbsp;</td>
            <td align="right">经办部门:</td>
            <td><%=rs("depart")%>&nbsp;</td>
          </tr>
		   <tr>
            <td align="right">备&nbsp;&nbsp;&nbsp;&nbsp;注:</td>
            <td><%=rs("memo")%>&nbsp;</td>
			<td align="right">制单人:</td>
            <td><%=rs("username")%>&nbsp;</td>
          </tr>
      </table>
      <%
	  close_rs(rs)
	  endconnection
	  %>
</body>
</html>
