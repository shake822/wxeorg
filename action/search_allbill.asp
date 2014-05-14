<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!-- #include file="../inc/conn.asp" -->
<script>window.location.reload;</script> 
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
Function SetSmallInt(DataValue)
	if (DataValue<1) and (DataValue>0) then
	  if left(DataValue,1)<>"0" then
	    DataValue="0"&DataValue   
	  end if
	end if
	SetSmallInt = DataValue
End Function
key = request.QueryString("key")     
if (key <> "") then    
key = replace(key,"\","")    
key = replace(key,"¡¯","")    
key = replace(key,"or","")    
sel_sql = "select * from t_billdetail where billcode = '" & key & "'"    

dim keyword    
keyword = ""    
  
set rs=server.CreateObject("adodb.recordset")
rs.open sel_sql,conn,1,1  
set t=server.CreateObject("adodb.recordset")
sql= "select sum(number) as number,sum(price) as price,sum(Money) as money from t_billdetail where billcode = '" & key & "'" 
t.open sql,conn,1,1    
i=0
do while not rs.eof  
i=i+1  
keyword = keyword & "<tr align=center>"
keyword = keyword & "<td>" &i& "</td>"
keyword = keyword & "<td>" & rs("goodscode") & "</td>"
keyword = keyword & "<td>" & rs("goodsname") & "</td>"
keyword = keyword & "<td>" & rs("goodsunit") & "</td>"
keyword = keyword & "<td>" & rs("units") & "</td>"
keyword = keyword & "<td>" & SetSmallInt(rs("number")) & "</td>"
keyword = keyword & "<td>" & SetSmallInt(rs("price")) & "</td>"
keyword = keyword & "<td>" & SetSmallInt(rs("money")) & "</td>"
keyword = keyword & "<td>" & rs("detailnote") & "</td>"
keyword = keyword & "</tr>"  
rs.movenext    
loop
keyword = keyword & "<tr align=center>"
keyword = keyword & "<td><strong>ºÏ¼Æ</strong>:</td>"     
keyword = keyword & "<td>&nbsp;</td>"   
keyword = keyword & "<td>&nbsp;</td>"   
keyword = keyword & "<td>&nbsp;</td>"   
keyword = keyword & "<td>&nbsp;</td>"  
keyword = keyword & "<td>"&t("number")&"</td>"    
keyword = keyword & "<td>"&t("price")&"</td>"  
keyword = keyword & "<td>"&t("money")&"</td>"  
keyword = keyword & "<td>&nbsp;</td>"  
keyword = keyword & "</tr>"       
rs.close
t.close
set rs = nothing
response.Write(keyword)
end if    
%>  

