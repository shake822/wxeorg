<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>   
<!-- #include file="../inc/conn.asp" -->
<%
Response.ContentType = "text/html"
Response.Charset = "gb2312"
key=unescape(request("key"))
Function SetSmallInt(DataValue)
	if (DataValue<1) and (DataValue>0) then
	  if left(DataValue,1)<>"0" then
	    DataValue="0"&DataValue   
	  end if
	end if
	SetSmallInt = DataValue
End Function
sql = "select * from t_billdetail where billcode = '" & key & "'"
dim keyword    
keyword = ""    
  
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1  
If rs.eof Then
Else
keyword = keyword & "<tr align=center>"
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
End If
rs.close
conn.close
Response.Write keyword
response.end 
%>