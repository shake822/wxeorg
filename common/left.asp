<!-- #include file="../inc/conn.asp" -->
<html>
<head>
<title>SCM ITEM</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="Content-Type" content="noCache">
<link rel="stylesheet" href="Style/item.css" type="text/css">
<script language="JavaScript" src="../js/Ban.js"></script>
<script language="JavaScript" src="../js/bgColor.js"></script>
<script language="JavaScript" src="../js/showItem.js"></script>
<base target="main">
<style type="text/css">
<!--
body,td,tr {
	font-size:12px;
	line-height: 23px;
}
a:link {
	color: #000000;
	text-decoration: none;
}
a:visited {
	color: #000000;
	text-decoration: none;
}
a:hover {
	color: #000000;
	text-decoration: underline;
}
-->
</style>
</head>
<body leftMargin=0 topMargin=0 rightMargin=0>
<TABLE bgColor=#B0D3F9 border=0 cellPadding=0 cellSpacing=0 height="100%" width=150 >
  <TR>
    <TD valign=top align=center height=0> 

      <script>    
			outlookbar.otherclass="border=0 cellspacing='0' cellpadding='0' style='height:100%;width:100%;border-bottom:5pt solid #B0D3F9;'valign=middle align=center ";    
			function setCount(x){    
				if (document.all==null) return;    
				document.all("oCount").innerText=x    
			}    
		</script>
    </TD>
  </TR>

  <TR>
    <TD align=middle vAlign=top background="../img/listmenubg.jpg" id=outLookBarShow style="HEIGHT: 100%" name="outLookBarShow">
	<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td></td>
                          </tr>
                        </table>
<SCRIPT>
	function getCookie(name){
		var cname = name + "=";               
		var dc = document.cookie;
		if (dc.length > 0) {              
			begin = dc.indexOf(cname);
			if (begin != -1) {           
				begin += cname.length;
				end = dc.indexOf(";", begin);
				if (end == -1) end = dc.length;
				return unescape(dc.substring(begin, end));        }
		}
		return "";
	}

</SCRIPT>

<script>
<%
sql = "select * from t_user where username = '"& request.cookies("username") &"'"
set rs = Server.CreateObject("adodb.recordset")
rs.open sql, conn, 1, 1
strPower = rs("authority")
'response.write strPower
strSelectCD = instr(strPower,"SelectCD")
strGoodsBuyDetail = instr(strPower,"GoodsBuyDetail")
strGoodsBuyCount = instr(strPower,"GoodsBuyCount")
strCustBuyCount = instr(strPower,"CustBuyCount")
strCGFinish = instr(strPower,"CGFinish")
strcglist = instr(strPower,"cglist")
strSelectCG = instr(strPower,"SelectCG")
intCG = cint(strSelectCD) + cint(strGoodsBuyDetail) + cint(strGoodsBuyCount) + cint(strCustBuyCount) + cint(strCGFinish) + cint(strcglist) + cint(strSelectCG)
%>

<%
if intCG <> 0 then
%>
t=outlookbar.addtitle('采购管理');
<%
if strSelectCD > 0 then%>
outlookbar.additem('采购订货',t,'../Bills/selectplan.asp?type=CD');
<%end if
if strSelectCG > 0 then%>
outlookbar.additem('采购入库',t,'../Bills/selectbill.asp?type=CG');
outlookbar.additem('采购退货',t,'../Bills/selectbackbill.asp?type=CT');
<%end if
if strGoodsBuyDetail > 0 then%>
outlookbar.additem('采购明细表',t,'../report/goodsbuydetail.asp');
<%end if
if strGoodsBuyCount > 0 then%>
outlookbar.additem('货品采购汇总表',t,'../report/goodsbuycount.asp');
<%end if
if strCustBuyCount > 0 then%>
outlookbar.additem('供应商采购汇总表',t,'../report/custbuycount.asp');
<%end if
if strCGFinish > 0 then%>
outlookbar.additem('采购订单完成情况',t,'../report/orderdetail.asp?type=CD');
<%end if
if strcglist > 0 then%>
outlookbar.additem('采购单价一览',t,'../report/pricelist.asp?type=CG');
<%end if%>
<%
end if
%>

<%
strAddXD = instr(strPower,"AddXD")
strSelectXD = instr(strPower,"SelectXD")
strAddXS = instr(strPower,"AddXS")
strSelectXS = instr(strPower,"SelectXS")
strAddXT = instr(strPower,"AddXT")
strGoodsSaleDetail = instr(strPower,"GoodsSaleDetail")
strGoodsSaleCount = instr(strPower,"GoodsSaleCount")
strCustSaleCount = instr(strPower,"CustSaleCount")
strXSFinish = instr(strPower,"XSFinish")
strxslist = instr(strPower,"xslist")
intXS = cint(strAddXD) + cint(strSelectXD) + cint(strAddXS) + cint(strSelectXS) + cint(strAddXT) + cint(strGoodsSaleDetail) + cint(strGoodsSaleCount) + cint(strCustSaleCount) + cint(strXSFinish) + cint(strxslist)

if intXS <> 0 then
%>
t=outlookbar.addtitle('销售管理');
<%
if strSelectXD > 0 then%>
outlookbar.additem('销售订货',t,'../Bills/selectplan.asp?type=XD');
<%end if
if strSelectXS > 0 then%>
outlookbar.additem('销售出库',t,'../Bills/selectbill.asp?type=XS');
outlookbar.additem('销售退货',t,'../Bills/selectbackbill.asp?type=XT');
<%end if
if strGoodsSaleDetail > 0 then%>
outlookbar.additem('销售明细表',t,'../report/goodssaledetail.asp');
<%end if
if strGoodsSaleCount > 0 then%>
outlookbar.additem('货品销售汇总表',t,'../report/goodssalecount.asp');
<%end if
if strCustSaleCount > 0 then%>
outlookbar.additem('客户销售汇总表',t,'../report/custsalecount.asp');
<%end if
if strXSFinish > 0 then%>
outlookbar.additem('销售订单完成情况',t,'../report/orderdetail.asp?type=XD');
<%end if
if strxslist > 0 then%>
outlookbar.additem('销售单价一览',t,'../report/pricelist.asp?type=XS');
<%end if%>
<%
end if
%>

<%
strAddIn = instr(strPower,"AddIn")
strSelectIn = instr(strPower,"SelectIn")
strAddOut = instr(strPower,"AddOut")
strSelectOut = instr(strPower,"SelectOut")
strAddDB = instr(strPower,"AddDB")
strAddPD = instr(strPower,"AddPD")
strAddLL = instr(strPower,"AddLL")
strAddTL = instr(strPower,"AddTL")
strAddZZ = instr(strPower,"AddZZ")
strSelectProduct = instr(strPower,"SelectProduct")
strReportProduct = instr(strPower,"ReportProduct")
strBorrowDetail = instr(strPower,"BorrowDetail")
strGoodsBorrowCount = instr(strPower,"GoodsBorrowCount")
strDepartBorrowCount = instr(strPower,"DepartBorrowCount")
intDepot = cint(strAddIn) + cint(strSelectIn) + cint(strAddOut) + cint(strSelectOut) + cint(strAddDB) + cint(strAddPD) + cint(strAddLL) + cint(strAddTL) + cint(strAddZZ) + cint(strSelectProduct) + cint(strReportProduct) + cint(strBorrowDetail) + cint(strGoodsBorrowCount) + cint(strDepartBorrowCount)

if intDepot > 0 then
%>
t=outlookbar.addtitle('库存管理');
<%
if strSelectIn > 0 then%>
outlookbar.additem('其他入库',t,'../Bills/selectotherin.asp');
<%end if
if strSelectOut > 0 then%>
outlookbar.additem('其他出库',t,'../Bills/selectotherout.asp');
<%end if
if strAddDB > 0 then%>
outlookbar.additem('仓库调拨',t,'../Bills/selectdiaobo.asp');
<%end if
if strAddPD > 0 then%>
outlookbar.additem('库存盘点',t,'../Bills/selectpandian.asp');
<%end if
if strAddLL > 0 then%>
outlookbar.additem('部门领料',t,'../Bills/selectlingliao.asp');
<%end if
if strAddTL > 0 then%>
outlookbar.additem('部门退料',t,'../Bills/selecttuiliao.asp');
<%end if
if strBorrowDetail > 0 then%>
outlookbar.additem('领用明细表',t,'../report/GoodsBorrowDetail.asp');
<%end if
if strGoodsBorrowCount > 0 then%>
outlookbar.additem('货品领用汇总',t,'../report/GoodsBorrowCount.asp');
<%end if
if strDepartBorrowCount > 0 then%>
outlookbar.additem('部门领用汇总',t,'../report/DepartBorrowCount.asp');
<%end if%>
<%
end if
%>

<%
strAddFK = instr(strPower,"AddFK")
strBrowseFK = instr(strPower,"BrowseFK")
strAddSK = instr(strPower,"AddSK")
strBrowseSK = instr(strPower,"BrowseSK")
strAddSR = instr(strPower,"AddSR")
strBrowseSR = instr(strPower,"BrowseSR")
strAddZC = instr(strPower,"AddZC")
strBrowseZC = instr(strPower,"BrowseZC")
strDailyAccount = instr(strPower,"DailyAccount")
strTotalAccount = instr(strPower,"TotalAccount")
strBillFKCount = instr(strPower,"BillFKCount")
strCustFKCount = instr(strPower,"CustFKCount")
strBillSKCount = instr(strPower,"BillSKCount")
strCustSKCount = instr(strPower,"CustSKCount")
intCW = cint(strAddFK) + cint(strBrowseFK) + cint(strAddSK) + cint(strBrowseSK) + cint(strAddSR) + cint(strBrowseSR) + cint(strAddZC) + cint(strBrowseZC) + cint(strDailyAccount) + cint(strTotalAccount) + cint(strBillFKCount) + cint(strCustFKCount) + cint(strBillSKCount) + cint(strCustSKCount)

if intCW > 0 then
%>
t=outlookbar.addtitle('财务管理');
<%
if strBrowseFK > 0 then%>
outlookbar.additem('付款单',t,'../cash/cash.asp?type=FK');
<%end if
if strBrowseSK > 0 then%>
outlookbar.additem('收款单',t,'../cash/cash.asp?type=SK');
<%end if
if strBrowseSR > 0 then%>
outlookbar.additem('其他收入',t,'../cash/income.asp');
<%end if
if strBrowseZC > 0 then%>
outlookbar.additem('其他支出',t,'../cash/expend.asp');
<%end if
if strDailyAccount > 0 then%>
outlookbar.additem('帐户查询',t,'../report/account.asp');
<%end if
if strTotalAccount > 0 then%>
outlookbar.additem('帐户余额查询',t,'../report/Totalaccount.asp');
<%end if
if strBillFKCount > 0 then%>
outlookbar.additem('应付账款表-单据',t,'../report/cashcount_bill.asp?type=FK');
<%end if
if strCustFKCount > 0 then%>
outlookbar.additem('应付账款表-往来单位',t,'../report/cashcount_cust.asp?type=FK');
<%end if
if strBillSKCount > 0 then%>
outlookbar.additem('应收账款表-单据',t,'../report/cashcount_bill.asp?type=SK');
<%end if
if strCustSKCount > 0 then%>
outlookbar.additem('应收账款表-往来单位',t,'../report/cashcount_cust.asp?type=SK');
<%end if%>
<%
end if
%>

<%
strAddFP_cg = instr(strPower,"AddFP_cg")
strSelectFP_cg = instr(strPower,"SelectFP_cg")
strAddFP_xs = instr(strPower,"AddFP_sx")
strSelectFP_xs = instr(strPower,"SelectFP_xs")
strInvoicecg = instr(strPower,"invoicecg")
strInvoicexs = instr(strPower,"invoicexs")
intFP = cint(strAddFP_cg) + cint(strSelectFP_cg) + cint(strAddFP_xs) + cint(strSelectFP_xs) + cint(strInvoicecg) + cint(strInvoicexs)

if intFP > 0 then
%>
t=outlookbar.addtitle('发票管理');
<%
if strBrowseFK > 0 then%>
outlookbar.additem('采购收票',t,'../invoice/invoice.asp?type=cg');
<%end if
if strBrowseSK > 0 then%>
outlookbar.additem('销售开票',t,'../invoice/invoice.asp?type=xs');
<%end if
if strInvoicecg > 0 then%>
outlookbar.additem('采购收票报表',t,'../invoice/invoicedetail.asp?type=cg');
<%end if
if strInvoicexs > 0 then%>
outlookbar.additem('销售收票报表',t,'../invoice/invoicedetail.asp?type=xs');
<%end if%>
<%
end if
%>

<%
strAllBill = instr(strPower,"AllBill")
strDepotNum = instr(strPower,"DepotNum")
strDepotWarn = instr(strPower,"DepotWarn")
strEachDepot = instr(strPower,"EachDepot")
strDepotCount = instr(strPower,"DepotCount")
strDepotDetail = instr(strPower,"DepotDetail")
intDepot = cint(strAllBill) + cint(strDepotNum) + cint(strDepotWarn) + cint(strEachDepot) + cint(strDepotCount) + cint(strDepotDetail)

if intDepot > 0 then
%>
t=outlookbar.addtitle('库存和单据管理');
<%if strAllBill > 0 then%>
outlookbar.additem('单据查询',t,'../Report/allbill.asp');
outlookbar.additem('调整库存价格与数量',t,'../price/selectprice.asp');
<%end if
if strDepotNum > 0 then%>
outlookbar.additem('库存数量查询',t,'../Report/Viewdepot.asp');
<%end if
if strDepotWarn > 0 then%>
outlookbar.additem('库存报警',t,'../Report/depotwarn.asp');
<%end if
if strDepotCount > 0 then%>
outlookbar.additem('库存汇总',t,'../Report/depotcount.asp');
<%end if%>
<%
end if
%>

<%
strGain = instr(strPower,"Gain")
strSaleTop = instr(strPower,"SaleTop")
strJXC = instr(strPower,"JXC")
strOtherDetail = instr(strPower,"OtherDetail")
strMonthSale = instr(strPower,"MonthSale")
strAnalysis = instr(strPower,"Analysis")
intReport = cint(strGain) + cint(strSaleTop) + cint(strJXC) + cint(strOtherDetail) + cint(strMonthSale) + cint(strAnalysis)
if intReport > 0 then
%>
t=outlookbar.addtitle('其它报表');
<%if strOtherDetail > 0 then%>
outlookbar.additem('其他明细报表',t,'../report/otherdetail.asp');
<%end if
if strGain > 0 then%>
outlookbar.additem('利润分析',t,'../report/gain.asp');
<%end if
if strSaleTop > 0 then%>
outlookbar.additem('销售排行',t,'../report/saletop.asp');
<%end if
if strMonthSale > 0 then%>
outlookbar.additem('销售统计',t,'../report/sale_month.asp');
<%end if
if strAnalysis > 0 then%>
outlookbar.additem('图表分析',t,'../chart/Analysis.asp');
<%end if
if strJXC > 0 then%>
outlookbar.additem('进销存报表',t,'../Report/jxc.asp');
<%end if%>
<%
end if
%>

<%
strBrowseCustom = instr(strPower,"BrowseCustom")
strBrowseGoods = instr(strPower,"BrowseGoods")
strBrowseEmployee = instr(strPower,"BrowseEmployee")
strBrowseDepot = instr(strPower,"BrowseDepot")
strBrowseUnit = instr(strPower,"BrowseUnit")
strBrowseAccount = instr(strPower,"BrowseAccount")
strBrowseCompany = instr(strPower,"BrowseCompany")
strModel = instr(strPower,"Model")
strBrowseGoods1 = instr(strPower,"BrowseGoods1")
strBrowseDepartment = instr(strPower,"BrowseDepartment")
intBase = cint(strBrowseCustom) + cint(strBrowseGoods) + cint(strBrowseEmployee) + cint(strBrowseDepot) + cint(strBrowseUnit) + cint(strBrowseAccount) + cint(strBrowseCompany) + cint(strModel) + cint(strBrowseGoods1) + cint(BrowseDepartment)

if intBase > 0 then
%>
t=outlookbar.addtitle('基础资料');
<%if strBrowseCustom > 0 then%>
outlookbar.additem('往来单位资料',t,'custom.asp');
outlookbar.additem('往来单位分类',t,'edittree.asp?type=cust')
<%end if
if strBrowseGoods > 0 then%>
outlookbar.additem('货品资料',t,'goods.asp');
outlookbar.additem('货品分类',t,'edittree.asp?type=goods');
outlookbar.additem('Excel批量导入货品',t,'importgoods.asp');
<%end if
if strBrowseGoods1 > 0 then%>
outlookbar.additem('批量修改货品分类',t,'goods1.asp');
<%end if
if strBrowseEmployee > 0 then%>
outlookbar.additem('员工信息',t,'employee.asp');
<%end if
if strBrowseDepot > 0 then%>
outlookbar.additem('仓库资料',t,'depot.asp');
<%end if
if strBrowseDepartment > 0 then%>
outlookbar.additem('部门资料',t,'department.asp');
<%end if
if strBrowseUnit > 0 then%>
outlookbar.additem('计量单位',t,'units.asp');
<%end if
if strBrowseAccount > 0 then%>
outlookbar.additem('帐户信息',t,'account.asp');
<%end if
if strBrowseCompany > 0 then%>
outlookbar.additem('公司信息',t,'company.asp');
<%end if%>
<%
end if
%>

<%
strOperator = instr(strPower,"Operator")
strSys = instr(strPower,"SYS")
strCleanData = instr(strPower,"CleanData")
strReg = instr(strPower,"Reg")
%>
t=outlookbar.addtitle('系统管理');
<%if strOperator > 0 then%>
outlookbar.additem('操作员管理',t,'user.asp');
<%end if%>
<%
sql1 = "select * from t_softinfo"
Set rs1 = server.CreateObject("adodb.recordset")
rs1.Open sql1, conn, 1, 1
if rs1("regedit") = True then
Response.Write "outlookbar.additem('修改密码',t,'changepassword.asp');"
end if
close_rs(rs1)
%>
<%if strSys > 0 then%>
outlookbar.additem('系统设置',t,'sys.asp');
<%end if
if strCleanData > 0 then%>
outlookbar.additem('数据初始化',t,'Clear.asp');
//outlookbar.additem('数据结转',t,'TransformData.asp');
<%end if
if strReg > 0 then%>
outlookbar.additem('软件认证',t,'regedit.asp');
<%end if%>
outlookbar.additem('万年历',t,'calendar.htm');
outlookbar.show()
</SCRIPT>
</TD>
</TR>
</TABLE>
</body>
</HTML>
                                                                    
