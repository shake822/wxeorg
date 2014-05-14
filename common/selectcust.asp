<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<title>选择往来单位</title>
<script language="JavaScript" src="../js/ShowHideDiv.js"></script>
<script type="text/javascript" src="../js/dtree.js"></script>
<SCRIPT language="javascript">
function clicknode(nodename,nodecode){
	if (document.getElementById("nodename")!=null){
		document.getElementById("nodename").value = String(nodename);	
	}
	if (document.getElementById("typecode")!=null){
		document.getElementById("typecode").value = String(nodecode);	
	}	
	closeProc();
}

function change(){
	var oObj = event.srcElement;
	if(oObj.tagName.toLowerCase() == "td"){
		var oTr = oObj.parentNode;
		for(var i=1;i<document.all.tbl.rows.length;i++){
			document.all.tbl.rows[i].style.backgroundColor = "";
			document.all.tbl.rows[i].tag   =   false;
		}
		oTr.style.backgroundColor   =   "#CCCCFF";   oTr.tag   =   true;
	}
}

function out(){
	var oObj = event.srcElement;
	if(oObj.tagName.toLowerCase() == "td") {
		var oTr = oObj.parentNode;
		if(!oTr.tag) oTr.style.backgroundColor = "";
	}
}

function over(){
	var oObj = event.srcElement;
	if(oObj.tagName.toLowerCase() == "td"){
		var   oTr   =   oObj.parentNode;
		if(!oTr.tag)   oTr.style.backgroundColor   =   "#E1E9FD";
	}
}

function CreateReturnValue(closeWindow,i){
　var custname=window.opener.document.getElementById("cust");
  custname.value=document.getElementById('tbl').rows[i].cells[0].innerHTML;
　if(closeWindow){
　　window.opener=null;
　　window.close();
　}
}

function showProc(){
  message_box.style.visibility='visible';
  //创建灰色背景层
  procbg = document.createElement("div"); 
  procbg.setAttribute("id","mybg"); 
  procbg.style.background = "#f7f7f7"; 
  procbg.style.width = "100%"; 
  procbg.style.height = "100%"; 
  procbg.style.position = "absolute"; 
  procbg.style.top = "0"; 
  procbg.style.left = "0"; 
  procbg.style.zIndex = "500"; 
  procbg.style.opacity = "0.3"; 
  procbg.style.filter = "Alpha(opacity=30)"; 
  //背景层加入页面
  document.body.appendChild(procbg);
  document.body.style.overflow = "hidden";
}
//拖动
function drag(obj){  
     var s = obj.style;  
     var b = document.body;   
  var x = event.clientX + b.scrollLeft - s.pixelLeft;   
  var y = event.clientY + b.scrollTop - s.pixelTop; 
 
  var m = function(){  
   if(event.button == 1){  
    s.pixelLeft = event.clientX + b.scrollLeft - x;   
    s.pixelTop = event.clientY + b.scrollTop - y;   
   }else {
    document.detachEvent("onmousemove", m);
   }  
  }  
  document.attachEvent("onmousemove", m);
  if(!this.z) 
   this.z = 999;   
  s.zIndex = ++this.z;   
  event.cancelBubble = true;   
}
 
function closeProc(){
  message_box.style.visibility= "hidden";
  procbg.style.visibility = "hidden";
}
function newcust(){
	openwin('addcust.asp?add=true',650,600);
}
</script>
</head>
<body topmargin="0" style=""padding:0px;margin:0px;"" onmousemove="movediv(event)" onmouseup="obj=0">
<div align="center"><span class="style1"></span></div>
<div id="message_box" style="position:absolute;left:55%;top:3%;width:250px;height:400px;filter:dropshadow(color=#666666,offx=3,offy=3,positive=2);z-index:1000;visibility:hidden">
   <div id= "message" style="border:#036 solid; border-width:1 1 3 1;width:95%; height:95%; background:#fff; color:#036; font-size:12px; line-height:150%;">
    <!-- DIV弹出状态行：标题、关闭按钮 -->
    <div style="background:#7DC6F0;height:5%;font-family:宋体; font-size:13px; padding:3 5 0 5; color:#00385E" onMouseDown="drag(message_box);return false">
     <span style="display:inline;width:100%;position:absolute;font-size:120%">单击选择类别</span>
     <span onClick="closeProc();" style="float:right;display:inline;cursor:pointer;font-size:150%">×</span>
    </div>
<script language="JavaScript">
	d = new dTree('d');
	<%
    Response.Write "d.add(0,-1,'往来单位分类','edittree.asp?type=cust&name="&s_name&"&id="&i_id&"&pid=0');"
		sql_gtype = "select * from t_tree where type='cust'"
		set rs_gtype = conn.Execute(sql_gtype)
		do while rs_gtype.eof=false
		  i_id=rs_gtype("id")
			i_pid=rs_gtype("pid")
			s_name=rs_gtype("name")
			s_url=rs_gtype("url")
			s_code=rs_gtype("code")
		  Response.Write "d.add("&i_id&","&i_pid&",'"&s_name&"',""javascript:clicknode('"&s_name&"','"&s_code&"')"",'','','','','','"&s_code&"');"
		  rs_gtype.movenext
		loop
		close_rs(rs_gtype)
		%>
	document.write(d);
</script>
</div><!-- message -->
</div><!-- message_box -->
<table>
<form name="form1" method="post" action="selectcust.asp">
<tr>
  <td align="right">往来单位名称</td>
  <td><input type="text" name="s_custname" size="16" value="<%=request.Form("s_custname")%>"></td>
  <td align="right">往来单位分类</td>
  <td><input type="text" name="nodename" id="nodename" size="16" value="<%=request.Form("nodename")%>"><input type="hidden" name="typecode" value="<%=request.Form("typecode")%>"><a href="#" onClick="showProc()"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
  <td width="65" valign="top"><input type="submit" name="select" value=" 查 询 "  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button"></td>
   <td id="td" width="85" valign="top"><input type="button" value="新增往来单位"  class="button" onClick="newcust()" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" ></td>
</tr>
</form>
</table>
<hr>
<table width="100%" id="tbl">
<tr align="center" height="20px">
  <th width="18%">名称</th>
  <th width="15%">类别</th>
  <th width="15%">联系人</th>
  <th width="15%">电话</th>
  <th width="27%">地址</th>
  <th width="10%">选择</th>
</tr>
<%
sql_cust = "select custname,RDepot from t_user where username='"&request.cookies("username")&"'"
Set rs_cust = conn.Execute(sql_cust)
temp_cust=""
sql = "select custname from t_custom where 1=1"
set rs=conn.execute(sql)
 Do While rs.eof=False
 s_cust = s_cust & "'" & rs("custname") & "',"
  rs.movenext
  loop 
 s_cust = " "
close_rs(rs_cust)

If request("typecode")<>"" Then
    If request("s_custname")<>"" Then
        sql = "select * from t_custom where code like '"&request("typecode")&"%' and custname like '%"&request("s_custname")&"%'"&s_cust&" order by CustID desc"
    Else
        sql = "select * from t_custom where code like '"&request("typecode")&"%'"&s_cust&" order by CustID desc"
    End If
Else
    If request("s_custname")<>"" Then
        sql = "select * from t_custom where custname like '%"&request("s_custname")&"%'"&s_cust&" order by CustID desc"
    Else
        sql = "select * from t_custom where 1=1"&s_cust&" order by CustID desc"
    End If
End If

Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 3
rs.pagesize = 15
If request("page")<>"" Then
    epage = CInt(request("page"))
    If epage<1 Then epage = 1
    If epage>rs.pagecount Then epage = rs.pagecount
Else
    epage = 1
End If
If Not rs.EOF Then rs.absolutepage = epage
For i = 0 To rs.pagesize -1
    If rs.bof Or rs.EOF Then Exit For
    s_code = rs("CustCode")
    s_name = rs("CustName")
    If rs("Contact") = "" Then
        s_unit = "&nbsp;"
    Else
        s_unit = rs("Contact")
    End If
    If rs("Tel") = "" Then
        s_remark = "&nbsp;"
    Else
        s_remark = rs("Tel")
    End If
		s_custtype = rs("CustType")
    Response.Write "<tr onMouseOver=""over()"" onClick=""change()"" onMouseOut=""out()"" onDblClick = ""CreateReturnValue(true,"&i + 1&");"" align=""center""><td>"&rs("CustName")&"</td><td>"&rs("CustType")&"</td><td>"&rs("Contact")&"</td><td>"&rs("Tel")&"</td><td>"&rs("address")&"</td><td><img border=0 src='../images/chuliwb.png' style=cursor:pointer width=54 height=15 onDblClick=""CreateReturnValue(true,"&i&")""  onclick=""CreateReturnValue(true,"&i + 1&")""></td></tr>"
    rs.movenext()
	
Next
%>
</table>
<%
 Set mypage=new xdownpage '创建对象 
 mypage.getconn=conn '得到数据库连接 
 mypage.getsql=sql
 mypage.pagesize=15 '设置每一页的记录条数据为5条 
 set rs=mypage.getrs() '返回Recordset 
 
 Response.Write "<table align=""center"" width='100%' border=0>"
 Response.Write "<tr>"
 Response.Write "<th colspan=5 align=""left"">"
 mypage.showpage()  '显示分页信息，这个方法可以，在set rs=mypage.getrs()以后任意位置调用，可以调用多次 
 'Response.Write "<label class=""button1""><input type=""submit"" value=""Excel""></label>"
 Response.Write "</th></tr></table>"
 Response.Write "</form>"
 close_rs(rs)
 endconnection
%>

</body>
</html>