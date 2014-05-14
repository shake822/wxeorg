<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<!-- #include file="../inc/config.asp" -->
<% call CheckAuthority("strGain") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>利润分析</title>
</head>

<body style="background:#FFFFFF;padding:0px;margin:0px; text-align:center"  >
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ></div>
<div style="padding-left:10px">
<%
s_date1 = Year(Date()) & "-" & Month(Date()) & "-1"
s_date2 = formatdate(date)
%>
<form id="form1" name="sample" method="post" action="gain.asp">
  <table width="610" border="0" align="center" id="tbl_tittle">
    <tr>
      <td width="13%" height="24" align="center">仓库名称：</td>
      <td width="26%">
      <%call showdepot("depot",Request.Form("depot"))%>
	  </td>
      <td width="9%">&nbsp;</td>
      <td width="27%">&nbsp;</td>
      <td width="25%" rowspan="2"><input type="submit" onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  name="Submit" value=" 查 询 " class="button" /></td>
    </tr>
    <tr>
      <td height="26" align="right">从&nbsp;日&nbsp;期：</td>
      <td><label>
      <input type="text" name="date1" size="16"  value=<%
If Request("date1") = "" Then
    Response.Write s_date1
Else
    Response.Write Request("date1")
End If

%>><%showdate("date1")%></label></td>
      <td align="right">到&nbsp;日&nbsp;期：</td>
      <td><input type="text" name="date2" size="16"  value=<%
If Request("date2") = "" Then
    Response.Write Date()
Else
    Response.Write Request("date2")
End If

%>><%showdate("date2")%></td>
    </tr>
  </table>
</form>
<div align="center"><span class="style1">利润分析</span></div>
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
If Request.Form("depot") = "" Then
    s_depotname = " and depotname in ("&s_depotpower&"'a')"
Else
    s_depotname = " and depotname='"&Request.Form("depot")&"'"
End If
sql_cg = "select sum(number) as num,sum(money) as mon from s_billdetail where billtype='采购入库' and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname
Set rs_cg = server.CreateObject("adodb.recordset")
rs_cg.Open sql_cg, conn, 1
sql_cg_num = "select billcode from t_bill where billtype='采购入库' and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname
Set rs_cg_num = server.CreateObject("adodb.recordset")
rs_cg_num.Open sql_cg_num, conn, 1

sql_ct = "select sum(number) as num,sum(money) as mon from s_billdetail where billtype='采购退货' and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname
Set rs_ct = server.CreateObject("adodb.recordset")
rs_ct.Open sql_ct, conn, 1
sql_ct_num = "select billcode from t_bill where billtype='采购退货' and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname
Set rs_ct_num = server.CreateObject("adodb.recordset")
rs_ct_num.Open sql_ct_num, conn, 1

sql_xs = "select sum(number) as num,sum(money) as mon,sum(number*inprice) as chengben from s_billdetail where billtype='销售出库' and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname
Set rs_xs = server.CreateObject("adodb.recordset")
rs_xs.Open sql_xs, conn, 1
sql_xs_num = "select billcode from t_bill where billtype='销售出库' and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname&s_goodstype
Set rs_xs_num = server.CreateObject("adodb.recordset")
rs_xs_num.Open sql_xs_num, conn, 1

sql_xt = "select sum(number) as num,sum(money) as mon,sum(number*inprice) as chengben from s_billdetail where billtype='销售退货' and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname
Set rs_xt = server.CreateObject("adodb.recordset")
rs_xt.Open sql_xt, conn, 1
sql_xt_num = "select billcode from t_bill where billtype='销售退货' and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname
Set rs_xt_num = server.CreateObject("adodb.recordset")
rs_xt_num.Open sql_xt_num, conn, 1

sql_fk = "select sum(mon) as totalmoney,sum(y_mon) as ymon from ("
sql_fk = sql_fk + "select case when s3.t_tmon is null then s1.t_mon else s1.t_mon-s3.t_tmon end as mon,case when t_ymon is null then s4.t_mon else s2.t_ymon+s4.t_mon end as y_mon from "
sql_fk = sql_fk + "(select billcode,adddate,custname,sum(money) as t_mon from s_billdetail where billtype = '采购入库'and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname&" group by billcode,adddate,custname) as s1 left join (SELECT billcode,sum([money]) AS t_ymon FROM t_cash GROUP BY billcode) as s2 on s2.billcode=s1.billcode left join (select planbillcode,sum([money]) as t_tmon from s_billdetail group by planbillcode) as s3 on s3.planbillcode=s1.billcode left join (select billcode,pay as t_mon from t_bill where billtype = '采购入库') as s4 on s4.billcode=s1.billcode) as vb"

Set rs_fk = server.CreateObject("adodb.recordset")
rs_fk.Open sql_fk, conn, 1, 1

sql_sk = "select sum(mon) as totalmoney,sum(y_mon) as ymon from ("
sql_sk = sql_sk + "select case when s3.t_tmon is null then s1.t_mon else s1.t_mon-s3.t_tmon end as mon,case when t_ymon is null then s4.t_mon else s2.t_ymon+s4.t_mon end as y_mon from "
sql_sk = sql_sk + "(select billcode,adddate,custname,sum(money) as t_mon from s_billdetail where billtype = '销售出库'and (AddDate)<='"&s_date2&"' and (AddDate)>='"&s_date1&"'"&s_depotname&" group by billcode,adddate,custname) as s1 left join (SELECT billcode,sum([money]) AS t_ymon FROM t_cash GROUP BY billcode) as s2 on s2.billcode=s1.billcode left join (select planbillcode,sum([money]) as t_tmon from s_billdetail group by planbillcode) as s3 on s3.planbillcode=s1.billcode left join (select billcode,pay as t_mon from t_bill where billtype = '销售出库') as s4 on s4.billcode=s1.billcode) as vb"

Set rs_sk = server.CreateObject("adodb.recordset")
rs_sk.Open sql_sk, conn, 1
%>
<table width=600 align="center">
<tr><td><table width="100%" border="0">
      <tr id="tr_tittle">
        <td colspan="3" background="../img/tittle_bg.gif">&nbsp;采购统计</td>
        </tr>
      <tr>
        <td width="200">采购单数:<%=isnumber(rs_cg_num.recordcount)%></td>
        <td width="200">采购数量:<%=isnumber(rs_cg("num"))%></td>
        <td>采购金额:<%=isnumber(rs_cg("mon"))%></td>
      </tr>
      <tr>
        <td width="200">退货单数:<%=(rs_ct_num.recordcount)%></td>
        <td width="200">退货数量:<%=isnumber(rs_ct("num"))%></td>
        <td>退货金额:<%=isnumber(rs_ct("mon"))%></td>
      </tr>
      <tr>
        <td width="200">合计:</td>
        <td width="200">数量:<%=isnumber(rs_cg("num"))-isnumber(rs_ct("num"))%></td>
        <td>金额:<%=isnumber(rs_cg("mon"))-isnumber(rs_ct("mon"))%></td>
      </tr>
    </table></td></tr>
<tr><td><table width="100%" border="0">
  <tr id="tr_tittle">
    <td colspan="3" background="../img/tittle_bg.gif">&nbsp;销售统计</td>
  </tr>
  <tr>
    <td width="200">销售单数:<%=isnumber(rs_xs_num.recordcount)%></td>
    <td width="200">销售数量:<%=isnumber(rs_xs("num"))%></td>
    <td>销售金额:<%=isnumber(rs_xs("mon"))%></td>
  </tr>
  <tr>
    <td width="200">退货单数:<%=isnumber(rs_xt_num.recordcount)%></td>
    <td width="200">退货数量:<%=isnumber(rs_xt("num"))%></td>
    <td>退货金额:<%=isnumber(rs_xt("mon"))%></td>
  </tr>
  <tr>
    <td width="200">合计:</td>
    <td width="200">数量:<%=isnumber(rs_xs("num"))-isnumber(rs_xt("num"))%></td>
    <td>金额:<%=isnumber(rs_xs("mon"))-isnumber(rs_xt("mon"))%></td>
  </tr>
</table></td></tr>
<tr><td><table width="100%" border="0">
  <tr id="tr_tittle">
    <td colspan="3" background="../img/tittle_bg.gif">&nbsp;收付款</td>
  </tr>
  <tr>
    <td width="200"><strong>付款</strong></td>
    <td width="200">应付金额:<%=isnumber(rs_fk("totalmoney"))%></td>
    <td>实付金额:<%=isnumber(rs_fk("ymon"))%></td>
  </tr>
  <tr>
    <td width="200"><strong>收款</strong></td>
    <td width="200">应收金额:<%=isnumber(rs_sk("totalmoney"))%></td>
    <td>实收金额:<%=isnumber(rs_sk("ymon"))%></td>
  </tr>
</table>
</td></tr>
<tr><td><table width="100%" border="0">
  <tr id="tr_tittle">
    <td colspan="3" background="../img/tittle_bg.gif">&nbsp;利润分析</td>
  </tr>
  <tr>
    <td width="200"><strong>销售金额：<%=isnumber(rs_xs("mon"))-isnumber(rs_xt("mon"))%></strong></td>
    <td width="200"><strong>销售成本：<%=isnumber(rs_xs("chengben"))-isnumber(rs_xt("chengben"))%></strong></td>
    <td><strong>毛利润：<%=isnumber(rs_xs("mon"))-isnumber(rs_xt("mon"))-isnumber(rs_xs("chengben"))+isnumber(rs_xt("chengben"))%></strong></td>
  </tr>
</table>
</td></tr>
</table>
<%
close_rs(rs_cg_num)
close_rs(rs_cg)
close_rs(rs_ct_num)
close_rs(rs_ct)
close_rs(rs_xs_num)
close_rs(rs_xs)
close_rs(rs_xt_num)
close_rs(rs_xt)
close_rs(rs_fk)
close_rs(rs_sk)
endconnection
%>
</div>
</body>
</html>
