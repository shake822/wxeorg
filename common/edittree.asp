<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<html>
<head>
<title>
<%
If request("type") = "goods" Then
Response.Write("货品分类")
End If
%>
<%
If request("type") = "cust" Then
Response.Write("往来单位分类")
End If
%>
</title>
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<link rel="stylesheet" href="../style.css" type="text/css">
<script type="text/javascript" src="../js/dtree.js"></script>
<script type="text/javascript">
function CreateAddValue(){
	document.getElementById('name1').value=document.getElementById('addname').value;
	document.getElementById('name2').value=document.getElementById('addname').value;
	document.getElementById('name3').value=document.getElementById('addname').value;
}

function CreateEditValue(){
	document.getElementById('name1').value=document.getElementById('editname').value;
	document.getElementById('name2').value=document.getElementById('editname').value;
	document.getElementById('name3').value=document.getElementById('editname').value;
}


function addtreeSub(){
	
	var rtype;
	if (document.getElementById("pid").value==""){
	  alert("请选择一个节点！"); 
		return;
	}
	if (document.getElementById('addname').value=="") {
	  alert("请输入节点名称！");
		return;
	}
	
	
	var obj = document.getElementsByName("type1");
  for(var i=0;i<obj.length;i++)
  {
    if(obj[i].checked){
     	rtype= obj[i].value;
    }
  }
	if(rtype=="2"){
		document.addtree1.name1.value=document.getElementById('addname').value;
		document.addtree1.submit();
	}else{
		document.addtree2.name2.value=document.getElementById('addname').value;
		document.addtree2.submit();
	}
}

function EditTreeSub(){
	if (document.getElementById("pid").value==""){
	  alert("请选择一个节点！"); 
		return;
	}
	if (document.getElementById('editname').value=="") {
	  alert("请输入新节点名称！");
		return;
	}
	document.edittree.name3.value=document.getElementById('editname').value;
	document.edittree.submit();
}

function deltreeSub(){	
	if (document.getElementById("pid").value==""){
	  alert("请选择一个节点！"); 
		return;
	}
	document.deltree.submit();
}

</script>
</head>
<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<fieldset style="width:auto;">
<legend>类别管理</legend>
<br>
<div style="padding-top:4px;">
	<input class="button" type="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="货品分类" onClick="location.href='edittree.asp?type=goods'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;<input class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" type="button" value="往来单位分类" onClick="location.href='edittree.asp?type=cust'">
</div>
<br>
<div style="float:left;width:360px;height:400px;overflow:auto;border:1px solid #000000;">
<script type='text/javascript'>
<!--
	d = new dTree('d');
	<%if request("type")="goods" then%>
	<%end if
		if request("type")="cust" then
      Response.Write "d.add(0,-1,'往来单位分类','edittree.asp?type="&request("type")&"&name="&s_name&"&id="&i_id&"&pid=0');"
		end if
		if request("type")="goods" then
      Response.Write "d.add(0,-1,'货品分类','edittree.asp?type="&request("type")&"&name="&s_name&"&id="&i_id&"&pid=0');"
		end if
		sql="select * from t_tree where type='"&request("type")&"' order by code"
		set rs=conn.execute(sql)
		sql1="select count(*) as rcount from t_tree where type='"&request("type")&"'"
		set rs1=conn.execute(sql1)
		If rs1("rcount") = 0 then  '--------只有根节点时，禁用下级选项---------
		   disabled="disabled"
		Else
		   disabled = ""
		End If
		do while rs.eof=false
		  i_id=rs("id")
			i_pid=rs("pid")
			s_name=rs("name")
			s_url=rs("url")
			s_code=rs("code")
		  Response.Write "d.add("&i_id&","&i_pid&",'"&s_name&"','edittree.asp?type="&request("type")&"&name="&s_name&"&id="&i_id&"&pid="&i_pid&"&code="&s_code&"','','','','','','"&s_code&"');"
		  rs.movenext
		loop
		close_rs(rs)
		endconnection
		%>
document.write(d);
//-->
</script>
</div>
<div style="float:left;width:220px;height:400px;border-top:1px solid #000000;border-bottom:1px solid #000000;border-right:1px solid #000000;over-flow:auto;text-align:center;">
<form name="form" method="post" action="basic_save.asp?tablename=<%=tablename%>" onSubmit="return validate_form()">
原始名称：<br><input type="text" name="treecodename" size="12" readonly value="<%=Request("code")&Request("name")%>"><br><hr>
<div style="text-align:left;margin-left:10pt;font:14px bold">新增</div>
输入节点名称：<br>
<input type="hidden" name="tablename" value="<%=tablename%>">
<input type="hidden" name="treecode" size="12" value="<%=treecode%>">
<input type="hidden" name="catetype" value="添加">
<input type="hidden" name="treename" size="12" value="<%=treename%>">
<input type="text" id="addname" onPropertyChange="CreateAddValue()" size="12"><br>
<input type="radio" name="type1" id="type1" value="1" checked>同级
<input type="radio" name="type1" id="type1" value="2" <%=disabled %>>下级<br>
<input class="button" type="button" name="submit" value="保存" onClick="addtreeSub()">
</form><br><hr>

<div style="text-align:left;margin-left:10pt;font:14px bold">编辑</div>
输入新名称：<br>
<input type="text" name="editname" onPropertyChange="CreateEditValue()" size="12"><br>
<input class="button" type="button" name="save" value="保存" onClick="EditTreeSub()">
<br>
<hr>
<div style="text-align:left;margin-left:10pt;font:14px bold">删除</div>
<form name="deltree" method="post" action="../action/deltree.asp?type=<%=request("type")%>&pid=<%=request("id")%>">
<input class="button" type="button"  value="删除" onClick="deltreeSub()">
</form>
</div>
</fieldset>

<input type="hidden" name="pid" id="pid" value="<%=request.QueryString("pid")%>">
<form name="addtree1" method="post" action="../action/edittree.asp?type=<%=request("type")%>&pid=<%=request("id")%>">
	<input type="hidden" name="name1" id="name1">
	<input type="hidden" name="code1" id="code1">
</form>

<form name="addtree2" method="post"  onSubmit="return checkvalue();" action="../action/edittree.asp?type=<%=request("type")%>&pid=<%=request("pid")%>">
	<input type="hidden" name="name2" id="name2">
	<input type="hidden" name="code2" id="code2">
</form>


<form name="edittree" method="post"  onSubmit="return checkvalue();" action="../action/edittree2.asp?type=<%=request("type")%>&id=<%=request("id")%>">
<input type="hidden" name="name3" id="name3">
<input type="hidden" name="code3" id="code3">
<input type="hidden" value="编辑节点" class="button">
</form>
</div>
</body>
</html>
