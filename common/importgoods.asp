<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<html>
<head>
<title>Excel货品导入</title>
</head>
<body style="background:#FFFFFF">
<div style="background:url(../images/main-02.gif); width:100%; height:20; padding-left:0" ><img src="../images/main-01.gif"></div>
<div style="padding-left:10px">
<script language="javascript">
function uploaddata(){
	if (document.upload.pic1.value=""){
		alert('请选择要上传的文件！');
		return;
	}
	var filename = document.upload.pic1.value;
	var kzName = filename.slice(filename.indexOf(".")).toLowerCase();
	if(kzName!=".xls"&&kzName!=".xlsx"){
		alert('只能上传后缀为xls|xlsx的Excel类型文件！');
		return;
	}
	document.upload.submit();
}
</script>
<link href="../style.css" rel="stylesheet" type="text/css" media="all" />
<font color="#FF0000">请您先下载模板，然后在模板中录入数据，<br>请不要修改excel和sheet的名称，然后直接上传即可，<br>如果出现提示“不可预料预期格式”，请您把excel另存一下，名称都不改，<br>然后再次上传，如果还有问题请与我们的客服联系.</font><br>
<table>
<tr>
<td colspan="2" valign="top">
<input type="button" class="button"  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" onClick="document.location='../Database/data.xls'" value="模板下载" >
</td>
</tr>
<tr>
<td width="350px" valign="top">
<form id="upload" name="upload" method="post"  action="importgoods_save.asp" enctype="multipart/form-data">
Excel上传：<input type="file" name="pic1"  class="button" size=32 >

<td valign="top">
<input type="button" class="button" value=" 上 传 "  onMouseOver="this.className='button_over';" onMouseOut="this.className='button';" onClick="uploaddata()">
</form>
</td>
</tr>
</table>
<p><b><font color="#ff0000">免费版不提供此功能 请联系小二科技购买商业版 http://www.hokilly.com/ 咨询QQ：15916190</font></b></p>
</div>
</body>
</html>