<!-- #include file="../inc/conn.asp" -->
<%
sqlmemoryprice = "select * from T_SoftInfo"
set rsmemoryprice = server.CreateObject("adodb.recordset")
rsmemoryprice.open sqlmemoryprice,conn,1,1
f_memoryprice = rsmemoryprice("memoryprice")

%>
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<link rel="StyleSheet" href="dtree.css" type="text/css" />
<script language="JavaScript" src="../js/jquery.js"></script>
<script language="JavaScript" src="../js/ShowHideDiv.js"></script>
<script type="text/javascript" src="../js/dtree.js"></script>
<script language="javascript" type="text/javascript">
$(document).ready(function() {
	$("#nodename").change(function() {
		if ($("#nodename").val()==""){
		$("#typecode").attr("value","");
		}
	});
});

function clicknode(nodename,nodecode){
	if (document.getElementById("nodename")!=null){
		document.getElementById("nodename").value = String(nodename);	
	}
	if (document.getElementById("typecode")!=null){
		document.getElementById("typecode").value = String(nodecode);	
	}	
	closeProc();
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
function newgoods(){
openwin('addgoods.asp?add=true',600,500);
}
</script>
<title>选择商品</title>
</head>
<%
  Response.Write "<body topmargin=""0"" style=""padding:0px;margin:0px;"" onmousemove=""movediv(event)"" onmouseup=""obj=0"">"
%>

<table align="center" border="0">
<form name="form1" method="post" action="selectgoods.asp?adddate=<%=Request("adddate")%>&id=<%=request("id")%>&depot=<%=request.QueryString("depot")%>&type=<%=request.QueryString("type")%>&cust=<%=request.QueryString("cust")%>">
<tr>
  <td id="td">货品编码</td>
  <td id="td"><input type="text" id="goodscode" name="s_goodscode" size="16" value="<%=request.Form("s_goodscode")%>">&nbsp;&nbsp;</td>
  <td id="td">货品名称</td>
  <td id="td"><input type="text" name="s_goodsname" size="16" value="<%=request.Form("s_goodsname")%>">&nbsp;&nbsp;</td>
  <td>货品分类:</td>
  <td><input type="text" name="nodename" id="nodename" size="16" value=<%=Request.Form("nodename")%>><a href="#" onClick="showProc()"><img border="0" src="../img/choose.gif" width="21" height="17"></a><input type="hidden" name="typecode" id="typecode" value="<%=request.Form("typecode")%>" /></td>
  <td width="85" valign="top" id="td"><input type="submit" name="select" value=" 查 询 "  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  class="button"></td>
  <td width="85" valign="top" id="td"><input type="button" value="新增货品"  class="button" onClick="newgoods()" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" ></td>
</tr>
</form>
</table>
<%
sqlTemp = "select goodstype,RGoodstype from t_user where username = '" & request.cookies("username") & "'"
set rsTemp = Server.CreateObject("adodb.recordset")
rsTemp.open sqlTemp,conn,1,1
if rsTemp("RGoodsType") = True then
arr = split(rsTemp("goodstype"),",")
if ubound(arr) <> -1 then
for i = lbound(arr) to ubound(arr)-1 
sql_goodstype = sql_goodstype & " or (code like '"& arr(i) &"%')"
next
sql_goodstype = right(sql_goodstype,len(sql_goodstype)-4)
sql_goodstype = " and (" & sql_goodstype & ")"
end if
end if

if (request.cookies("username") <> "admin") and rsTemp("RGoodstype") then  				 '非admin用户没有开启商品类别
  
else
  sql_goodstype = ""
end if

sqltemp = "select * from dict_bill where billtype = '" & Request.QueryString("type") & "'"
call OpenDataSet(sqltemp,rstemp)
if rstemp.recordcount > 0 then
	sType = rstemp("name")
else
	sType = ""
end if

if Request.QueryString("adddate") = "" then
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
  s_goodsname = " and goodsname like '%"&request("s_goodsname")&"%'"
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

sql = "select goods.goodscode,goodsname,goodsunit,units,inprice,outprice,remark,avgprice,memoryprice,t_num from ((select * from t_goods where 1=1"&s_goodscode&s_goodsname&s_type&") as goods left join (select (case when sum(qty) is null or sum(qty) = 0 then 0 else sum(qty*price)/sum(qty) end) as avgprice,sum(qty) as t_num,goodscode from t_stock where 1=1"&s_depot&" group by goodscode) as depot on goods.goodscode = depot.goodscode left join (select goodscode,price as memoryprice from t_memoryprice where custname = '" & Request.QueryString("cust") & "' and billtype = '" & sType & "') as mm on mm.goodscode = goods.goodscode) order by goods.GoodsID desc"


Call showpage(sql,"SelectGoods",2)
%>
<div id="message_box" style="position:absolute;left:48%;top:3%;width:250px;height:400px;filter:dropshadow(color=#666666,offx=3,offy=3,positive=2);z-index:1000;visibility:hidden">
   <div id= "message" style="border:#036 solid; border-width:1 1 3 1;width:95%; height:95%; background:#fff; color:#036; font-size:12px; line-height:150%;">
    <!-- DIV弹出状态行：标题、关闭按钮 -->
    <div style="background:#7DC6F0;height:5%;font-family:宋体; font-size:13px; padding:3 5 0 5; color:#00385E" onMouseDown="drag(message_box);return false">
     <span style="display:inline;width:100%;position:absolute;font-weight:bold">单击选择类别</span>
     <span onClick="closeProc();" style="float:right;display:inline;cursor:pointer;font-size:150%">×</span>
    </div>
<script language="JavaScript">
	d = new dTree('d');
	<%
    Response.Write "d.add(0,-1,'货品分类','edittree.asp?type=goods&name="&s_name&"&id="&i_id&"&pid=0');"
		sql_gtype = "select * from t_tree where type='goods'"
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
<%endconnection%>
</body>
</html>
