<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<title>
<%If request("type") = "goods" Then
Response.Write("货品分类")
End If
%>
<%If request("type") = "cust" Then
Response.Write("往来单位分类")
End If
%>
</title>
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<script type="text/javascript" src="../js/dtree.js"></script>
<script>
function CreateReturnValue(closeWindow)
{
	var nodecode=window.opener.document.getElementById("nodename");
	var typecode=window.opener.document.getElementById("typecode");
	//var goodstype=window.opener.document.getElementById("goodstype");
	nodecode.value=document.getElementById('tree').value; 
	typecode.value=document.getElementById('code').value; 
	//goodstype.value=document.getElementById('tree').value; 
	window.close();
	if (closeWindow==true)
	{
	    alert("1");
		//window.opener=null;
		window.close();
	}
}
</script>
</head>
<%if request("code") <> "" then%>
<body onLoad="CreateReturnValue('true')" >
<%else%>
<body>
<%end if%>
<input type="hidden" name="tree" id="tree" value="<%=request("name")%>">
<input type="hidden" name="code" id="code" value="<%=request("code")%>">
<div class="dtree">
	<p><a href="javascript: d.openAll();">全部展开</a> | <a href="javascript: d.closeAll();">全部收起</a></p>

	<script type='text/javascript'>
		<!--

		d = new dTree('d');
		<%if request("type")="goods" then%>
		<%end if
		  if request("type")="cust" then
		    Response.Write "d.add(0,-1,'往来单位分类','#');"
           'Response.Write "d.add(0,-1,'往来单位分类','edittree.asp?type="&request("type")&"&name="&s_name&"&id="&i_id&"&pid=0');"
		  end if
		  if request("type")="goods" then
		   Response.Write "d.add(0,-1,'货品分类','#');"
           'Response.Write "d.add(0,-1,'货品分类','edittree.asp?type="&request("type")&"&name="&s_name&"&id="&i_id&"&pid=0');"
		  end if
		  sql="select * from t_tree where type='"&request("type")&"'"
		  set rs=conn.execute(sql)
		  do while rs.eof=false
		    i_id=rs("id")
			i_pid=rs("pid")
			s_name=rs("name")
			s_url=rs("url")
			s_code=rs("code")
		    Response.Write "d.add("&i_id&","&i_pid&",'"&s_name&"','tree.asp?type="&request("type")&"&name="&s_name&"&code="&s_code&"');"
		    rs.movenext
		  loop
		  close_rs(rs)
		  endconnection
		%>

document.write(d);

//-->
</script>
</div>

</body>

</html>
