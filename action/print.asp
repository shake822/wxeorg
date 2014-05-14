<!--      #include      file="../inc/conn.asp"      -->      <!--       #include
file="../action/checkuser.asp" --> <!-- #include file="../inc/connExcel.asp" -->


<html>     <head>     <meta     http-equiv="Content-Type"    content="text/html;
charset=gb2312"      />      <META      http-equiv=Pragma      content=no-cache>
<title>单据打印</title> </head>

<body>
<%
 sql_sys = "select * from T_SoftInfo"
 set rs_sys = conn.Execute(sql_sys) '调用系统参数表


Function rmb(num)

num = FormatNumber(num, 2)
Dim numList 
Dim rmbList 
Dim numLen
Dim numChar
Dim numstr
Dim n 
Dim n1, n2 
Dim hz
numList = "零壹贰叁肆伍陆柒捌玖"
rmbList = "分角元拾佰仟万拾佰仟亿拾佰仟万"

If num > 9999999999999.99 Then
    rmb = "超出范围的人民币值"
    Exit Function
End If

numstr = CStr(num * 100)
numLen = Len(numstr)
n = 1
Do While n <= numLen
    numChar = CInt(Mid(numstr, n, 1))
    n1 = Mid(numList, numChar + 1, 1)
    n2 = Mid(rmbList, numLen - n + 1, 1)
    If Not n1 = "零" Then
        hz = hz + CStr(n1) + CStr(n2)
    Else
        If n2 = "亿" Or n2 = "万" Or n2 = "元" Or n1 = "零" Then
            Do While Right(hz, 1) = "零"
            hz = Left(hz, Len(hz) - 1)
            Loop
        End If
        If (n2 = "亿" Or (n2 = "万" And Right(hz, 1) <> "亿") Or n2 = "元") Then
            hz = hz + CStr(n2)
        Else
            If Left(Right(hz, 2), 1) = "零" Or Right(hz, 1) <> "亿" Then
                hz = hz + n1
            End If
        End If
    End If
    n = n + 1
Loop
Do While Right(hz, 1) = "零"
    hz = Left(hz, Len(hz) - 1)
Loop
If Right(hz, 1) = "元" Then
    hz = hz + "整"
End If
rmb = hz
End Function


Function SetSmallInt(DataValue)
	if (DataValue<1) and (DataValue>0) then
	  if left(DataValue,1)<>"0" then
	    DataValue="0"&DataValue   
	  end if
	end if
	SetSmallInt = DataValue
End Function

sql_company = "select * from t_company"
Set rs_company = server.CreateObject("adodb.recordset")
rs_company.Open sql_company, conn, 1, 1

if request("billcode") <> "" then
sql = "select * from t_bill where billcode='"&request("billcode")&"'"
else
sql = "select * from t_bill where billcode='"&request.QueryString("billcode")&"'"
end if
Set rs_bill = server.CreateObject("adodb.recordset")
rs_bill.Open sql, conn, 1, 1

sqlBillType = "select * from dict_bill where name ='"&rs_bill("billtype")&"'"
set rsBillType = Server.CreateObject("adodb.recordset")
rsBillType.open sqlBillType, conn, 1, 1
%>

<TABLE border=0 cellSpacing=0 cellPadding=0 width=100% align=center>
<TBODY>
<TR>
<TD height=47 vAlign=top align=middle>
<TABLE border=0 cellSpacing=0 cellPadding=0 width=100% bgColor=white align=center height=57>
<TBODY>
<TR>
<TD style="BORDER-BOTTOM: #000000 1px solid;" rowspan="4"></TD>
<TD width="100%" align=middle><SPAN style="FONT-FAMILY: '宋体'; FONT-SIZE: 16px"><FONT style="FONT-FAMILY: 楷体_GB2312; FONT-SIZE: 24px"><STRONG style="FONT-FAMILY: 楷体_GB2312"><%=rs_company("company")%></STRONG></FONT></SPAN></TD>
</TR>
<TR>
<TD width="100%" align=middle><SPAN style="FONT-FAMILY: '宋体'; FONT-SIZE: 12px"><%=rs_company("address")%>&nbsp;&nbsp;邮编:<%=rs_company("zip")%></SPAN></TD>
</TR>
<TR>
<TD width="100%" align=middle><SPAN style="FONT-FAMILY: '宋体'; FONT-SIZE: 12px">电话:<%=rs_company("tel")%>&nbsp;&nbsp;传真:<%=rs_company("fax")%>&nbsp;&nbsp;<%=rs_company("email")%></SPAN></TD>
</TR>
<TR>
<TD style="BORDER-BOTTOM: #000000 1px solid;" width="100%" align=middle><SPAN style="FONT-FAMILY: '宋体'; FONT-SIZE: 16px"><FONT style="FONT-FAMILY: 楷体_GB2312; FONT-SIZE: 24px"><STRONG style="FONT-FAMILY: 楷体_GB2312"><%=rsBillType("caption")%></STRONG></FONT></SPAN></TD>
</TR>
</TBODY>
</TABLE>
<TABLE border=0 cellSpacing=0 cellPadding=0 width=100% align=center height=30>
<TBODY>
<TR>
<TD style="BORDER-LEFT: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" height=30 vAlign=top width="100%" align=middle>
<TABLE style="FONT-FAMILY: 宋体; FONT-SIZE: 12px" border=0 cellSpacing=0 cellPadding=0 width="100%" align=center>
<TBODY>
<TR>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" height=25 width="16%" align=right>
单&nbsp;&nbsp;&nbsp;&nbsp;号:
</TD>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-TOP: #000000 1px solid" width="33%" align=left>&nbsp;
 
</TD>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" width="19%" align=right>
<%=rsBillType("f_ck")%>:
</TD>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" width="32%" align=left>&nbsp;
 
</TD>
</TR>
<TR>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" height=25 width="16%" align=right>
制单日期:
</TD>
<TD style="BORDER-BOTTOM: #000000 1px solid" align=left>&nbsp;
 
</TD>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" align=right>
<%=rsBillType("f_dw")%>:
</TD>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" align=left>&nbsp;
 
</TD>
</TR>
<TR>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" height=25 width="16%" align=right>
制&nbsp;单&nbsp;人:
</TD>
<TD style="BORDER-BOTTOM: #000000 1px solid" align=left>&nbsp;
 
</TD>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" align=right>
经&nbsp;办&nbsp;人:
</TD>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" align=left>&nbsp;
 
</TD></TR>
<TR>
<TD style="BORDER-BOTTOM: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" height=25 colSpan=4 align=left>&nbsp;&nbsp;供需双方经过协商达成如下商品交易：</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<TABLE border=0 cellSpacing=0 cellPadding=0 width=100% align=center>
<TBODY>
<TR>
<TD height=0 vAlign=top align=middle>
<TABLE style="BORDER-LEFT: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" border=0 cellSpacing=0 cellPadding=0 width=100% bgColor=white align=center>
<TBODY>
<TR>
<TD height=0 vAlign=top align=middle><!--GridView-->
<TABLE style="WIDTH: 100%; BORDER-COLLAPSE: collapse" id=GridView2 border=1 rules=all cellSpacing=0 borderColor=#000000 align="center">
<TBODY>
<TR style="HEIGHT: 25px; FONT-SIZE: 12px" align=left>
<TH width="4%" align="center">序号</TH>
<TH width="10%" align="center">货品编码</TH>
<TH width="15%" align="center">货品名称</TH>
<TH width="10%" align="center">货品规格</TH>
<TH width="6%" align="center">单位</TH>
<TH width="10%" align="center">数量</TH>
<TH width="10%" align="center">单价</TH>
<TH width="10%" align="center">金额</TH>
<TH width="25%" align="center">备注</TH>
<%
sql = "select * from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_detail = server.CreateObject("adodb.recordset")
rs_detail.Open sql, conn, 1, 1
For i = 1 To rs_detail.recordcount
%>
<TR style="HEIGHT: 25px; FONT-SIZE: 12px" align=left>
<TD align="center">&nbsp; </TD>
<TD>&nbsp; </TD>
<TD>&nbsp; </TD>
<TD>&nbsp; </TD>
<TD>&nbsp; </TD>
<TD align="right">&nbsp; </TD>
<TD align="right">&nbsp; </TD>
<TD align="right">&nbsp; </TD>
<TD>&nbsp; </TD>
</TR>
<%
rs_detail.movenext
Next
sql = "select sum(number) as num,sum(money) as mon from t_billdetail where billcode='"&request("billcode")&"'"
Set rs_count = server.CreateObject("adodb.recordset")
rs_count.Open sql, conn, 1, 1
%>
</TBODY></TABLE><!--GridView-->
<TABLE style="BORDER-BOTTOM: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-RIGHT: #000000 1px solid" border=0 cellSpacing=0 cellPadding=0 width="100%" align=center>
<TBODY>
<TR id=chkPrintSate>
<TD style="BORDER-BOTTOM: #000000 1px solid" height=26 align=left>&nbsp;<SPAN style="FONT-SIZE: 14px" id=SmA>共有：<b><font color="#ff0000">  </font></b>笔明细记录，数量合计：   金额合计：  </SPAN></TD>
</TR>
<TR id=chkPrintSate>
<TD style="BORDER-BOTTOM: #000000 1px solid" height=26 align=left>&nbsp;<SPAN style="FONT-SIZE: 14px" id=SmA>人民币(大写)：</SPAN></TD>
</TR>
<TR id=chkPrintSate>
<TD style="BORDER-BOTTOM: #000000 1px solid" height=26 align=left><SPAN style="FONT-SIZE: 16px"><b><font color="#ff0000">免费版不提供此功能 请联系红金羚软件购买商业版 http://www.hokilly.com/ 咨询QQ：15916190</font></b></SPAN></TD>
</TR>
</TBODY>
</TABLE>
</TD>
</TR>
</TBODY>
</TABLE>
</TD>
</TR>
</TBODY>
</TABLE>
</body>
</html>
