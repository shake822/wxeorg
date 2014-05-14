<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<% call CheckAuthority("strSYS") %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="stylesheet" href="../style.css" type="text/css">
<title>系统设置</title>
<script>
function goods()
{
	window.open ('../common/edittree.asp?type=goods', 'newwindow', 'height=500, width=650,left=100,top=100,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}


function depot()
{
	window.open ('../common/depot.asp', 'newwindow', 'height=400, width=700,left=120,top=180,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}

function units()
{
	window.open ('../common/units.asp', 'newwindow', 'height=400, width=300,left=300,top=180,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}

function cashtype()
{
	window.open ('../common/cashtype.asp', 'newwindow', 'height=400, width=300,left=300,top=180,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}

function record()
{
	window.open ('../common/record.asp', 'newwindow', 'top=200,left=150,height=400, width=700,toolbar=no,menubar=no, scrollbars=yes, resizable=no,location=no, status=no')
}
</script>
</head>

<body bgcolor="#f7f7f7">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<br>
<div align="center"><span class="style1">系统设置</span><br>
<table width="760" border="0" >
<tr valign="top"><td><fieldset style="padding-bottom:5px"><legend>显示设置</legend>
  <form name="form1" method="post" action="../action/editsys.asp">
    <table width="200" border="0" align="center">
      <tr>
        <td width="100" align="left" colspan="3">显示记录条数</td>
		<%
		sql = "select * from T_SoftInfo"
		Set rs = conn.Execute(sql)
		%>
        <td colspan="3"><input type="text" name="pagerecord" size="2" value="<%=rs("pagerecord")%>"></td>
      </tr>
      <tr>
        <td colspan="6">显示小数点位数</td>
      </tr>
      <tr>
        <td align="right">数量</td>
        <td><input type="text" name="dotnum" size="2" value="<%=rs("dotnum")%>"></td>
        <td align="right">单价</td>
        <td><input type="text" name="dotprice" size="2" value="<%=rs("dotprice")%>"></td>
        <td align="right">金额</td>
        <td><input type="text" name="dotmon" size="2" value="<%=rs("dotmon")%>"></td>
      </tr>
	  <tr>
	    <td colspan="4">货品资料列表中显示图片</td>
	    <td colspan="2">
		  <%
		  if rs("showphoto")=false then
		    s_false = "selected"
		  else
		    s_true = "selected"
		  end if
		  %>
		  <select name="showphoto"><option value="true" <%=s_true%>>是</option>
		                           <option value="false" <%=s_false%>>否</option></select>
		</td>
	  </tr>
	  <tr>
	    <td colspan="4">是否允许负出库</td>
	    <td colspan="2">
		  <%
		  if rs("fuchuku")=false then
		    ss_false = "selected"
		  else
		    ss_true = "selected"
		  end if
		  %>
		  <select name="fuchuku"><option value="true" <%=ss_true%>>是</option>
		                           <option value="false" <%=ss_false%>>否</option></select>
		</td>
	  </tr>
	  <tr>
	    <td colspan="4">是否采用记忆价</td>
	    <td colspan="2">
		  <%
		  if rs("memoryprice")=false then
		    sss_false = "selected"
		  else
		    sss_true = "selected"
		  end if
		  %>
		  <select name="memoryprice"><option value="true" <%=sss_true%>>是</option>
		                           <option value="false" <%=sss_false%>>否</option></select>
		</td>
	  </tr>
	  <tr>
	    <td colspan="4">是否采用自动编码</td>
	    <td colspan="2">
		  <%
		  if rs("autogoodscode")=false then
		    ssss_false = "selected"
		  else
		    ssss_true = "selected"
		  end if
		  %>
		  <select name="autogoodscode"><option value="true" <%=ssss_true%>>是</option>
		                           <option value="false" <%=ssss_false%>>否</option></select>
		</td>
	  </tr>
      <tr>
      	<td colspan="4">货品编码</td>
        <td colspan="2"><input type="text" name="goodscode" value="<%=rs("goodscode")%>" size="4"></td>
       </tr>
    </table>
      <div align="center"><input type="submit" name="Submit"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value=" 提 交 " class="button"></div>
  </form>
</fieldset>
</td>
<td><fieldset style="padding-bottom:5px"><legend>信息设置</legend>
<table align="center" border="0" height="135" width="100%">
<tr>
  <td align="center"><input type="button" onClick="goods();"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="分类管理"  class="button"></td>
  <td></td>
</tr>
<tr>
  <td align="center"><input type="button" onClick="depot();"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value="仓库管理"  class="button"></td>
  <td align="center"><input type="button" onClick="units();"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="计量单位管理"  class="button"></td>
</tr>
<tr>
  <td align="center"><input type="button" onClick="cashtype();"   onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" value="支付方式"  class="button"></td>
  <td align="center"><input type="button" onClick="record();"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';"  value="查看登陆日志"  class="button"></td>
</tr>
</table>
</fieldset></td>
</tr>
</div>
<%
close_rs(rs)
endconnection
%>
</div>
</body>
</html>
