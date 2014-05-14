<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
Private function BoolToBit(bCheck)
 if bCheck then
   BoolToBit=1
 else
   BoolToBit=0
 end if
end function

s_pagerecord = Request("pagerecord")
s_dotnum     = Request("dotnum")
s_dotprice   = Request("dotprice")
s_dotmon     = Request("dotmon")
f_showphoto  = BoolToBit(Request("showphoto"))
f_fuchuku    = BoolToBit(Request("fuchuku"))
f_memoryprice= BoolToBit(Request("memoryprice"))
s_goodscode  = Request("goodscode")
f_autogoodscode = BoolToBit(Request.Form("autogoodscode"))
sql = "update t_softinfo set pagerecord="&s_pagerecord&",dotnum="&s_dotnum&",dotprice="&s_dotprice&",dotmon="&s_dotmon&",showphoto = "&f_showphoto&",fuchuku = "&f_fuchuku&",goodscode = '"& s_goodscode & "',memoryprice = "&f_memoryprice &",autogoodscode = " & f_autogoodscode 
conn.Execute(sql)
endconnection
response.redirect "../common/sys.asp"
%>
