<!-- #include file="../inc/conn.asp" -->
<%
  table=trim(request.QueryString("table"))
  numi=trim(request.Form("totalMenus"))
  id=trim(request.QueryString("id"))
  sub2=trim(request.QueryString("sub"))
  sub1=trim(request.Form("sub"))
  if table<>"" then
   tablename=table
  end if
 
	 action="selectunit.asp"
	 
 Dim moveflag   

  id=request.QueryString("id")
moveflag = Request.Form("moveflag") 
if sub1="" and sub2="" then
   conn.begintrans
   set t=server.createobject("adodb.recordset")
   q1="select max(c_ChildNum) as cid,max(c_select) as code from Dict_Units where 1=1 "
   t.open q1,conn,1,1
   num=""
   if  t("cid")<>""  then
   num=t("cid")
   else
   num=1
   end if
   if len(num)=1 then
     strcode=0
	 else
	 strcode=""
   end if
 
q1="delete from Dict_Units where 1=1 "
conn.execute q1
for i=0 to numi+1
   q3="insert into Dict_Units(c_Depth,Name,c_ChildNum,c_select)values('"&i+1&"','"&request.Form("departname"&i)&"','"&i&"','"&strcode&""&i+1&"')"
   
     if request.Form("departname"&i)<>"" then
		conn.execute q3
	  end if	
next

if err.number=0 then
     conn.commitTrans
	 conn.close
     response.Write "<script>document.location.href='selectunit.asp'</script>"
     else
	 conn.rollbackTrans
     end if
 end if



%>   
<html>   
<head>   
<title></title>
<link href="../style/unit.css" rel="stylesheet" type="text/css" media="all" />
<link href="../style/btn.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript" src="../select/jquery.js"></script>
<script language="javascript">   

function moveMenu(menuid,menuordernum,movetype){   
   var num,prenum,premenuid,nextnum,nextmenuid,maxnum;    
  document.getElementById("movetype").value = movetype;      
   num = parseInt(menuordernum);      
   if(movetype=="up"){            
       if(num==1){   
            
       }else{
           prenum = document.getElementById("menuorder_"+(num-1)).value;   
           premenuid = document.getElementById("menuid_"+(num-1)).value;   
            document.getElementById("premenuid").value = premenuid;   
            document.getElementById("premenuordernum").value = prenum;   
            document.getElementById("nowmenuid").value = menuid;   
           document.getElementById("nowmenuordernum").value=menuordernum;  
			$.post("../select/test.asp",{nowid:escape(menuordernum)},
			function(data)
			{ 
				strtemp1 = $("#tbox_"+menuordernum).val();
				strtemp2 = $("#tbox_"+prenum).val();
				$("#tbox_"+menuordernum).val(strtemp2);
				$("#tbox_"+prenum).val(strtemp1);	
				strid1= $("#menuid_"+menuordernum).val();
				strid2= $("#menuid_"+prenum).val();	
				$("#menuid_"+menuordernum).val(strid1);
				$("#menuid_"+prenum).val(strid2);
				
			});	
			 
        }  
		

		 
  }else{   
       maxnum = parseInt(document.getElementById("totalMenus").value);   
     if(num>=maxnum){   
            
        }else{   
           nextnum = document.getElementById("menuorder_"+(num+1)).value;   
            nextmenuid = document.getElementById("menuid_"+(num+1)).value;   
           document.getElementById("nextmenuid").value = nextmenuid;   
           document.getElementById("nextmenuordernum").value = nextnum;   
            document.getElementById("nowmenuid").value = menuid;   
          document.getElementById("nowmenuordernum").value = menuordernum;
		     
          $.post("../select/test.asp",{nowid:escape(menuordernum)},
			function(data)
			{ 
				strtemp1 = $("#tbox_"+menuordernum).val();
				strtemp2 = $("#tbox_"+nextnum).val();
				$("#tbox_"+menuordernum).val(strtemp2);
				$("#tbox_"+nextnum).val(strtemp1);	
				strid1= $("#menuid_"+menuordernum).val();
				strid2= $("#menuid_"+nextnum).val();	
				$("#menuid_"+menuordernum).val(strid1);
				$("#menuid_"+nextnum).val(strid2);
				
			});	  
       }   
   }   
}   
function getvalue()
{

  i= parseInt(document.getElementById("totalMenus").value);
  j=parseInt(i)+1
 
name=document.getElementById("tbox_"+j).value;

     window.opener.addoption(name) 
	  document.getElementById("form2").submit(); 
   
 
}
function getid(id,cid)
{

 if(id!="")
{ 
		document.all.Table5.deleteRow(id);
				  for(k=0;k<document.all.Table5.rows.length-1;k++){
				  document.all.Table5.rows[k+1].cells[0].innerText=(k+1);
				}
				  $.post("../select/del.asp",{cid:escape(cid)},
						function(data)
						{ 
					
								
						});	 
			
			}
}


</script>
</head>   
<body>  
<form action="<%=action%>" method="post" name="form2" id="form2" >  
          <div id="cgshrk">
            <table class="td_table"   cellspacing="1" cellpadding="0" align="center" rules="all"  width="400" ID="Table5">   
			              <tr>
						   <td colspan="3">
						 <button type="submit" class='button' onClick="getvalue()"><img src="../images/baocun.png" border='0' align='absmiddle'>&nbsp;保存</button>
						 <button type="submit" class='button'  onClick="javascript:window.close()" ><img src="../images/guanbi.png" border='0' align='absmiddle'>&nbsp;关闭</button>&nbsp;
						      
						   </td>
						  </tr>
                          <%
						    set rs=server.createobject("adodb.recordset")  
						    sql = "select * from Dict_Units  where 1=1 order by c_Depth asc" 
							
						    rs.Open sql, conn, 1, 1 
                            i=0  
                            Response.write "<input type=""hidden"" name=""totalMenus"" id=""totalMenus"" value="""&rs.recordcount&""">"  
                                  for j=0 to rs.recordcount 
								  %>
                           
                                  <tr height=25>   
                                      <td align="center" width="30"><%=i+1%><input type="hidden" name="menuorder_<%=i+1%>" id="menuorder_<%=i+1%>" value="<%=i+1%>">
								            <input type="hidden" name="menuid_<%=i+1%>" id="menuid_<%=i+1%>" value="<%=rs("c_ChildNum")%>"></td>   
                                         
									  <td align="left"><input type="text" name="departname<%=i+1%>" value="<%=rs("Name")%>"  id="tbox_<%=i+1%>"/></td>   
                                      
									  <td align="center">   
									  <% if j <> rs.recordcount then %>
			<button type='button' class='button' onClick="moveMenu('<%=rs("c_ChildNum")%>','<%=i+1%>','up')"><img src="../images/shangyi.png" border='0' align='absmiddle'>&nbsp;上移</button>&nbsp;
			<button type='button' class='button' onClick="moveMenu('<%=rs("c_ChildNum")%>','<%=i+1%>','down')"><img src="../images/xiayi.png" border='0' align='absmiddle'>&nbsp;下移</button>&nbsp;
			<button type='button' class='button' onClick="getid(<%=i+1%>,<%=rs("c_ChildNum")%>)"><img src="../images/shanchu.png" border='0' align='absmiddle'>&nbsp;删除</button>  
									<% end if %>
                                       </td>   
                                  </tr>   
                           <% i=i+1  
                              rs.movenext   
                             next  
                           %>   
                       </table>
					   </div>   
					   <%   
                       rs.close   
                       set rs=nothing   
                        %>   


  <input type="hidden" name="sub" id="sub" >   
<input type="hidden" name="moveflag" id="moveflag" value="1">   
<input type="hidden" name="movetype" id="movetype">   
<input type="hidden" name="premenuid" id="premenuid">   
<input type="hidden" name="premenuordernum" id="premenuordernum">   
<input type="hidden" name="nowmenuid" id="nowmenuid">   
<input type="hidden" name="nowmenuordernum" id="nowmenuordernum">   
<input type="hidden" name="nextmenuid" id="nextmenuid">   
<input type="hidden" name="nextmenuordernum" id="nextmenuordernum">  
<input type="hidden" name="hidd" value="<%=tablename%>" /> 
</form>

</body>   
</html>   
   
<%   
  
   
if err.number <> 0 then    
    logError err.number,forerr(err.source&":"&err.description)   
  err.clear   
    Response.end   
end if   
  
Conn.Close   
set Conn = nothing   
%>
<script>
window.close()
</script>