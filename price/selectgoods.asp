<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../inc/config.asp" -->
<%
  choosetype = request("choosetype")
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>选择商品</title>
<script>
function CreateReturnValue(closeWindow,i)
　　 {
　　 var goodscode=window.opener.document.getElementById("goodscode");
     var goodsname=window.opener.document.getElementById("goodsname");
　　 goodscode.value=document.getElementById('tbl').rows[i].cells[1].innerHTML;
     goodsname.value=document.getElementById('tbl').rows[i].cells[2].innerHTML;
　　 if (closeWindow)
　　 {
　　 window.opener=null;
　　 window.close();
　　 }
　　 }
</script>
</head>

<body>
<table align="center">
<tr><td>
<table align="left">
<form name="form1" method="post" action="selectgoods.asp?id=<%response.write request("id")%>">
<tr>
   <td>货品编码</td>
   <td><input type="text" name="s_goodscode" size="16" value="<%=request.Form("s_goodscode")%>"></td>
   <td>货品名称</td>
   <td><input type="text" name="s_goodsname" size="16" value="<%=request.Form("s_goodsname")%>"></td>
   <td><input type="submit" name="select" value=" 查 询 " onClick="" class="button"></td>
</tr>
</form>
</table>
</td></tr>
<tr><td>
	<%

If request("s_goodscode")<>"" Then
    If request("s_goodsname")<>"" Then
        sql = "select * from t_goods where goodscode='"&request("s_goodscode")&"'and goodsname='"&request("s_goodsname")&"'"
    Else
        sql = "select * from t_goods where goodscode='"&request("s_goodscode")&"'"
    End If
Else
    If request("s_goodsname")<>"" Then
        sql = "select * from t_goods where goodsname='"&request("s_goodsname")&"'"
    Else
        sql = "select * from t_goods"
    End If
End If
call showpage(sql,"choosegoods",2)
%>
</td></tr></table>
</body>
</html>
