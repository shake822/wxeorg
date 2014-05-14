<%
backup_path = server.mappath("../backup/"&request.QueryString("filename"))
Dim objFSO '声明一个名称为 objFSO 的变量以存放对象实例    
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")    
If objFSO.FileExists(backup_path) Then    
    objFSO.DeleteFile backup_path,True  %>  
    <script>alert("已经成功地对文件"+"<%response.Write request.QueryString("filename")%>"+"进行了删除");
    		window.location='../common/backup.asp'</script>    
<%Else%>    
	<script>alert("<%=request.QueryString("filename")%>"+"不存在，无法进行删除");
    		window.location='../common/backup.asp'</script> 
<%End If    
Set objFSO = Nothing '释放 FileSystemObject 对象实例内存空间 
%>