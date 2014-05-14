<!-- #include file="../inc/conn.asp" -->
<!-- #include file="../action/checkuser.asp" -->
<%
s_company = Request.Form("company")
s_contact = Request.Form("contact")
s_address = Request.Form("address")
s_fax     = Request.Form("fax")
s_tel     = Request.Form("tel")
s_email   = Request.Form("email")
s_zip     = Request.Form("zip")
sql = "select * from t_company"
Set rs = server.CreateObject("adodb.recordset")
rs.Open sql, conn, 1, 1
if rs.recordcount>0 then
	sql = "update t_company set company='"&s_company&"',contact='"&s_contact&"',address='"&s_address&"',fax='"&s_fax&"',tel='"&s_tel&"',email='"&s_email&"',zip='"&s_zip&"'"
else
	sql="insert into t_company(company,contact,address,fax,tel,email,zip) values ('"&s_company&"','"&s_contact&"','"&s_address&"','"&s_fax&"','"&s_tel&"','"&s_email&"','"&s_zip&"') "
end if
conn.Execute(sql)
endconnection
Response.Redirect("../common/company.asp")
%>