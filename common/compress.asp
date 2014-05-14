<%
Sub CompactDB(strDBFileName)
  Set fso = CreateObject("Scripting.FileSystemObject")
  dim strOldDB
  strOldDB = server.MapPath(strDBFileName)
  dim strNewDB
  strNewDB = server.MapPath("../data/tempjxc.mdb")
  if fso.FileExists(strOldDB) then
    '压缩数据库
    Set Engine = Server.CreateObject("JRO.JetEngine")
    strPvd = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="
    Engine.CompactDatabase strPvd & strOldDB , strPvd & strNewDB
    set Engine = nothing
    '删除旧的数据库文件
    fso.DeleteFile strOldDB
    ' 将压缩好的数据库文件拷贝回来
    fso.MoveFile strNewDB, strOldDB
    response.write "数据库压缩完毕!"
  else
    response.write "找不到指定的数据库文件!"
  end if
  set FSO = nothing
end sub

call CompactDB("../data/jxc.mdb")
%>
<script>
alert("压缩成功！");
window.close();
</script>