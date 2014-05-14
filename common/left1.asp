<%
mypath="../"
%>
<!-- #include file="../inc/conn.asp" -->
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
%>
<%
strGain = instr(strPower,"Gain")
strSaleTop = instr(strPower,"SaleTop")
strJXC = instr(strPower,"JXC")
strOtherDetail = instr(strPower,"OtherDetail")
strMonthSale = instr(strPower,"MonthSale")
strAnalysis = instr(strPower,"Analysis")
intReport = cint(strGain) + cint(strSaleTop) + cint(strJXC) + cint(strOtherDetail) + cint(strMonthSale) + cint(strAnalysis)
%>
<%
strAllBill = instr(strPower,"AllBill")
strDepotNum = instr(strPower,"DepotNum")
strDepotWarn = instr(strPower,"DepotWarn")
strEachDepot = instr(strPower,"EachDepot")
strDepotCount = instr(strPower,"DepotCount")
strDepotDetail = instr(strPower,"DepotDetail")
intDepot = cint(strAllBill) + cint(strDepotNum) + cint(strDepotWarn) + cint(strEachDepot) + cint(strDepotCount) + cint(strDepotDetail)
%>
<%
strAddFP_cg = instr(strPower,"AddFP_cg")
strSelectFP_cg = instr(strPower,"SelectFP_cg")
strAddFP_xs = instr(strPower,"AddFP_sx")
strSelectFP_xs = instr(strPower,"SelectFP_xs")
strInvoicecg = instr(strPower,"invoicecg")
strInvoicexs = instr(strPower,"invoicexs")
intFP = cint(strAddFP_cg) + cint(strSelectFP_cg) + cint(strAddFP_xs) + cint(strSelectFP_xs) + cint(strInvoicecg) + cint(strInvoicexs)

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
%>
<%strAddIn = instr(strPower,"AddIn")
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
%>
<html>
<head>
<title>小二科技</title>
<meta http-equiv='Content-Type' content='text/html; charset=GB2312;'>
<link rel="stylesheet" href="../skin.css"  type="text/css">


</head>
<body topmargin=0 leftmargin=0 style="background:#FFFFFF">
<table border=0 width=132 height=100% cellpadding=0 cellspacing=0>
 <tr>
     <td width=131 valign=top background="../images/left-02.gif">
	      <table border=0 width=100% cellpadding=0 cellspacing=0>
	        <tr>
		        <td><img src="../images/left-01.gif"></td>
		    </tr>
	    <tr>
		   <td height=10></td>
		</tr>
	  </table>
	  <table border=0 width=100% cellpadding=0 cellspacing=0>
	    <tr>
		  <td>
		  <table border=0 width=100% cellpadding=0 cellspacing=0>
		  <tr>  
		  <% if intCG <> 0 then%>
		  <td height=34  align=left background='../images/menu-01.gif'>	  &nbsp;&nbsp;&nbsp;&nbsp;<img src='../images/icon-base.png' align=absmiddle width=25>&nbsp;&nbsp;<a href='#' id="cg" name="cg" onClick="javascript:window.parent.main.location.href='../main/cg.asp';"><font color='#FFFFFF' style='font-size:14px;'>采购管理</font></a> 
		   </td>
		   <%end if%>
		  </tr>
		  <tr> 
		<%if intXS <> 0 then%>
		  <td height=1 align=center></td></tr><tr>  <td height=34 align=left background='../images/menu-01.gif'>	  &nbsp;&nbsp;&nbsp;&nbsp;<img src='../images/icon-buy.png' align=absmiddle width=25>&nbsp;&nbsp;<a href='#' onClick="javascript:window.parent.main.location.href='../main/xs.asp';"><font color='#FFFFFF' style='font-size:14px;'>销售管理</font></a>  </td>
		  <%end if%>
		 
		  </tr>
		  
		  <tr>  
		 <%if intDepot > 0 then%>
		  <td height=1 align=center></td></tr><tr>  <td height=34 align=left background='../images/menu-01.gif'>	  &nbsp;&nbsp;&nbsp;&nbsp;<img src='../images/icon-sell.png' align=absmiddle width=25>&nbsp;&nbsp;<a href='#' onClick="javascript:window.parent.main.location.href='../main/kc.asp';"><font color='#FFFFFF' style='font-size:14px;'>库存管理</font></a>  </td>
		  <%end if%>
		
		  </tr>
		  <tr><td height=1 align=center></td></tr>
		  
		  <tr>  
		 <% if intCW > 0 then%>
		  <td height=34 align=left background='../images/menu-01.gif'>	  &nbsp;&nbsp;&nbsp;&nbsp;<img src='../images/icon-sale.png' align=absmiddle width=25>&nbsp;&nbsp;<a href='#' onClick="javascript:window.parent.main.location.href='../main/cw.asp';"><font color='#FFFFFF' style='font-size:14px;'>财务管理</font></a>  </td>
		  <%end if%>
		  </tr>
		  
		  <tr>  <td height=1 align=center></td></tr><tr>  
		  <%if intFP > 0 then%>
		  <td height=34 align=left background='../images/menu-01.gif'>	  &nbsp;&nbsp;&nbsp;&nbsp;<img src='../images/icon-depot.png' align=absmiddle width=25>&nbsp;&nbsp;<a href='#' onClick="javascript:window.parent.main.location.href='../main/fb.asp';"><font color='#FFFFFF' style='font-size:14px;'>发票管理</font></a>  </td><%end if%>
		  </tr>
		  
		  <tr>  <td height=1 align=center></td></tr>
		  <tr> 
		 <% if intDepot > 0 then%>
		  <td height=34 align=left background='../images/menu-01.gif'>&nbsp;&nbsp;&nbsp;&nbsp;<img src='../images/icon-self.png' align=absmiddle width=25>&nbsp;&nbsp;<a href='#' onClick="javascript:window.parent.main.location.href='../main/dj.asp';"><font color='#FFFFFF' style='font-size:14px;'>单据管理</font></a>  </td>
		 <%end if%>
		  </tr>
		  
		  <tr>  
		  <%if intReport > 0 then%>
		  <td height=1 align=center></td></tr><tr>  <td height=34 align=left background='../images/menu-01.gif'>	  &nbsp;&nbsp;&nbsp;&nbsp;<img src='../images/icon-join.png' align=absmiddle width=25>&nbsp;&nbsp;<a href='#' onClick="javascript:window.parent.main.location.href='../main/bb.asp';"><font color='#FFFFFF' style='font-size:14px;'>报表中心</font></a>  </td>
		  <%end if%>
		  </tr>
		  
		  <tr>  <td height=1 align=center></td></tr>
		  <%if intBase > 0 then%>
		  <tr>  <td height=34 align=left background='../images/menu-01.gif'>	  &nbsp;&nbsp;&nbsp;&nbsp;<img src='../images/icon-fund.png' align=absmiddle width=25>&nbsp;&nbsp;<a href='#' onClick="javascript:window.parent.main.location.href='../main/jc.asp';"><font color='#FFFFFF' style='font-size:14px;'>基础资料</font></a>  </td></tr>
		  
		  <%end if%>
		  <tr>  <td height=34 align=left background='../images/menu-01.gif'>	  &nbsp;&nbsp;&nbsp;&nbsp;<img src='../images/icon-system.png' align=absmiddle width=25>&nbsp;&nbsp;<a href='#' onClick="javascript:window.parent.main.location.href='../main/xt.asp';"><font color='#FFFFFF' style='font-size:14px;'>系统管理</font></a>  </td></tr><tr>  <td height=1 align=center></td></tr></table>		  
		  </td>
		</tr>
	  </table>
	</td>
	<td valign=top>
       <table border=0 width=100% height=100% cellpadding=0 cellspacing=0>
	   </table>
    </td>
</tr>
	</table>
 
</body>
</html>
