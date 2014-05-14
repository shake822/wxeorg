<div align="left">
<% 
   Response.Write "在你的程序中一共使用了 " & Session.Contents.Count & _
             " 个Session变量<P>"
   Dim strName, iLoop
   For Each strName in Session.Contents
     '判断一个Session变量是否为数组
     If IsArray(Session(strName)) then
       '如果是数组，那么罗列出所有的数组元素内容
       For iLoop = LBound(Session(strName)) to UBound(Session(strName))
          Response.Write strName & "(" & iLoop & ") - " & _
               Session(strName)(iLoop) & "<BR>"
       Next
     Else
       '如果不是数组，那么直接显示
       Response.Write strName & " - " & Session.Contents(strName) & "<BR>"
     End If
   Next
%> 
</div>