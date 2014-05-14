<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strAnalysis") %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<link rel="stylesheet" type="text/css" href="../ext/resources/css/ext-all.css">
<script type="text/javascript" src="../ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="../ext/ext-all.js"></script>
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
<title></title>
</head>

<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<table align="center"><tr><td>
<%
s_date1 = Year(Date()) & "-01-01"
s_date2 = formatdate(date)
%>
<form id="form1" name="sample" method="post" action="Analysis.asp">
  <table border="0" id="tbl_tittle">
    <tr>
      <td width="70" height="24" align="right">仓库名称：</td>
      <td width="150"><%call showdepot("depot","")%></td>
      <td width="70" align="right">单据类型：</td>
      <td width="150"><%call ShowCombo("dict_bill","name","billtype",request.Form("billtype"))%></td>
      <td rowspan="3"><input type="submit" name="Submit" value=" 查 询 " onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"   class="button"/></td>
    </tr>
    <tr>
      <td height="26" align="right">从&nbsp;日&nbsp;期：</td>
      <td><input type="text" name="date1" size="16"  value=<%
			If Request("date1") = "" Then
				Response.Write s_date1
			Else
				Response.Write Request("date1")
			End If%>><%showdate("date1")%></td>
      <td align="right">到&nbsp;日&nbsp;期：</td>
      <td><input type="text" name="date2" size="16"  value=<%
If Request("date2") = "" Then
    Response.Write Date()
Else
    Response.Write Request("date2")
End If

%>><%showdate("date2")%></td>
    </tr>
	<tr>
		<td align="right">货品编码：</td>
		<td><input type="text" name="goodscode" value="<%=request.Form("goodscode")%>" size="16"></td>
		<td width="70" align="right">货品类别：</td>
      <td width="150"><input type="hidden" name="typecode" id="typecode" value="<%=request.Form("typecode")%>">
      <input type="text" name="nodename" id="nodename" size="16" value=<%=Request.Form("nodename")%> ><a href="#" onClick="window.open ('../common/tree.asp?type=goods', 'newwindow', 'left=700,top=250,height=400, width=200,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no, status=yes')"><img border="0" src="../img/choose.gif" width="21" height="17"></a></td>
	</tr>
  </table>
</form>
<div align="center"><span class="style1">图表分析</span></div>
<%
sql_depot = "select depotname,RDepot from t_user where username='"&request.cookies("username")&"'"
Set rs_depot = conn.Execute(sql_depot)

if rs_depot("RDepot")=false then
   sql = "select depotname from t_depot where 1=1"
   set rs=conn.execute(sql)
    Do While rs.eof=False
	  s_depotpower = s_depotpower & "'" & rs("depotname") & "',"
	  rs.movenext
     loop 
sDepotname = " and depotname in (" & s_depotpower & "'a')" 
else
arr = split(rs_depot("depotname"),",")
if ubound(arr) <> -1 then
  for i = lbound(arr) to ubound(arr)-1
	s_depotpower = s_depotpower & "'" & arr(i) & "',"
  next
end if

  sDepotname = " and depotname in (" & s_depotpower & "'a')" 

end if

If Request.Form("date1")<>"" Then
    s_date1 = Request.Form("date1")
End If
If Request.Form("date2")<>"" Then
    s_date2 = Request.Form("date2")
End If
intTotal = datediff("m",s_date1,s_date2)
if Request.Form("depot") = "" then
	sDepotname = " and depotname in (" & s_depotpower & "'a')"
else
	sDepotname = " and depotname = '" & Request.Form("depot") & "'"
end if

if Request.Form("billtype") = "" then
	sBilltype = ""
else
	sBilltype = " and billtype = '" & Request.Form("billtype") & "'"
end if

if Request.Form("goodscode") = "" then
	sGoodscode = ""
else
	sGoodscode = " and goodscode = '" & Request.Form("goodscode") & "'"
end if

If Request.Form("typecode") = "" Then
    sGoodstype = ""
Else
    sGoodstype = " and code like '"&Request.Form("typecode")&"%'"
End If

sql = "select ifnull(sum(money),0) as tmon from s_billdetail where 1=1 " & sDepotname & sBilltype & sGoodscode & sGoodstype

%>
<script>
Ext.chart.Chart.CHART_URL = '../ext/resources/charts.swf';
Ext.onReady(function(){
    var store = new Ext.data.JsonStore({
        fields:['name', 'visits', 'views'],
        data: [
<%
for inti = 0 to intTotal
	sql = sql & " and month(adddate) = " & month(s_date1) + inti
	set rs = Server.CreateObject("adodb.recordset")
	rs.open sql,conn,1,1
	if inti <> intTotal then
	Response.Write "{name:'"& month(s_date1) + inti & "月" &"', visits: "& rs("tmon") &"},"
	else
	Response.Write "{name:'"& month(s_date1) + inti & "月" &"', visits: "& rs("tmon") &"}"
	end if
	sql = "select ifnull(sum(money),0) as tmon from s_billdetail where 1=1 " & sDepotname & sBilltype & sGoodscode & sGoodstype
next
%>
        ]
    });
    new Ext.Panel({
        title: '<%= Request.Form("billtype") %>图表分析',
        renderTo: 'container',
        width:600,
        height:400,
        layout:'fit',

        items: {
            xtype: 'linechart',
            store: store,
            xField: 'name',
            yField: 'visits',
			listeners: {
				itemclick: function(o){
					var rec = store.getAt(o.index);
					Ext.example.msg('Item Selected', 'You chose {0}.', rec.get('name'));
				}
			}
        }
    });
});
</script>
<div id="container">
    
</div>
</div>

</body>
</html>
