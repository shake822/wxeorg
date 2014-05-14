<!-- #include file="../inc/conn.asp" -->
<!-- #include file="checkuser.asp" -->
<%
on error resume next
conn.BeginTrans

s_custname = Request("custname")
s_contact = Request("contact")
s_address = Request("address")
s_zip = Request("zip")
s_fax = Request("fax")
s_email = Request("email")
s_custtype = Request("nodename")
s_code = Request("typecode")
s_mobile = Request("mobile")
s_bankname = Request("bankname")
s_bankaccount = Request("bankaccount")
s_taxcode = Request("taxcode")
s_fr = Request("fr")
s_url = Request("url")
s_tel = Request("tel")
s_memo = Request("memo")
s_startmoneyf = Request.Form("startmoneyf")
s_startmoneys = Request.Form("startmoneys")
s_userlist = Request("userlist")
If Request.QueryString("add") = "true" Then
     sql_check = "select count(*) as c from t_custom where CustName='"&s_custname&"'"
	 set rs_check = server.CreateObject("adodb.recordset")
	 rs_check.Open sql_check, conn, 1, 1
	if CInt(rs_check("c")) > 0 then
      Response.Write("<script language=javascript>alert('往来单位名称有重复!');history.go(-1);</script>")
	  Response.End()
	end if
	close_rs(rs_check)
sql = "insert into t_custom (custname,contact,address,zip,fax,email,tel,memo,custtype,code,mobile,bankname,bankaccount,taxcode,fr,url,startmoneyf,startmoneys) values ('"&s_custname&"','"&s_contact&"','"&s_address&"','"&s_zip&"','"&s_fax&"','"&s_email&"','"&s_tel&"','"&s_memo&"','"&s_custtype&"','"&s_code&"','"&s_mobile&"','"&s_bankname&"','"&s_bankaccount&"','"&s_taxcode&"','"&s_fr&"','"&s_url&"',"&s_startmoneyf&","&s_startmoneys&")"
	ck="true"
	cust=""
Else
    sql = "update t_custom set custname='"&s_custname&"',contact='"&s_contact&"',address='"&s_address&"',zip='"&s_zip&"',fax='"&s_fax&"',email='"&s_email&"',tel='"&s_tel&"',memo='"&s_memo&"',custtype='"&s_custtype&"',code='"&s_code&"',mobile='"&s_mobile&"',bankname='"&s_bankname&"',bankaccount='"&s_bankaccount&"',taxcode='"&s_taxcode&"',fr='"&s_fr&"',url='"&s_url&"',startmoneyf="&s_startmoneyf&",startmoneys="&s_startmoneys&" where custid="&Request("custid")
	ck="false"
	cust=s_custname
End If

conn.Execute(sql)

if err <> 0 then
Response.Write("<script>alert('保存失败!');location.href='../common/addcust.asp?add="&ck&"&custname="&cust&"';</script>")
	conn.rollbacktrans
	response.Write err.description
else

	Response.Write("<script>alert('保存成功！');location.href='../common/addcust.asp?add="&ck&"&custname="&cust&"';</script>")
	conn.CommitTrans
end if
endconnection
%>
<script language=javascript>

</script>