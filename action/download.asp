<%  
Response.Buffer = true 
Response.Clear 
dim url 
Dim fso,fl,flsize 
dim Dname 
Dim objStream,ContentType,flName,isre,url1

'这里根据具体情况而不同，反正最终目的是要取得文件路径 
'filename=request.QueryString("filename"）
url=server.MapPath("../backup/58games资料.doc")
'url 就是文件的绝对文件路径了

Set fso=Server.CreateObject("Scripting.FileSystemObject") 
Set fl=fso.getfile(url) 
flsize=fl.size 
flName=fl.name 
Set fl=Nothing 
Set fso=Nothing
Set  objStream  =  Server.CreateObject("ADODB.Stream")  
objStream.Open  
objStream.Type  =  1  
objStream.LoadFromFile  url  

Select  Case  lcase(Right(flName,  4))  
Case  ".asf"  
     ContentType  =  "video/x-ms-asf"  
Case  ".avi"  
     ContentType  =  "video/avi"  
Case  ".doc"  
     ContentType  =  "application/msword"  
Case  ".zip"  
     ContentType  =  "application/zip"  
Case  ".xls"  
     ContentType  =  "application/vnd.ms-excel"  
Case  ".gif"  
     ContentType  =  "image/gif"  
Case  ".jpg",  "jpeg"  
     ContentType  =  "image/jpeg"  
Case  ".wav"  
     ContentType  =  "audio/wav"  
Case  ".mp3"  
     ContentType  =  "audio/mpeg3"  
Case  ".mpg",  "mpeg"  
     ContentType  =  "video/mpeg"  
Case  ".rtf"  
     ContentType  =  "application/rtf"  
Case  ".htm",  "html"  
     ContentType  =  "text/html"  
Case  ".txt"  
     ContentType  =  "text/plain"  
Case  Else  
     ContentType  =  "application/octet-stream"  
End  Select  

Response.AddHeader  "Content-Disposition",  "attachment;  filename="  &  flName  
Response.AddHeader  "Content-Length",  flsize  
Response.Charset  =  "UTF-8"  
Response.ContentType  =  ContentType  
Response.BinaryWrite  objStream.Read  
Response.Flush  
response.Clear()  
objStream.Close  
Set  objStream  =  Nothing  
%>   