function setHiddenCol1(oTable,iCol)
{
    for (i=0;i < oTable.rows.length ; i++)
    {
        oTable.rows[i].cells[iCol].style.display = oTable.rows[i].cells[iCol].style.display=="none"?"block":"none";
		oTable.rows[i].cells[5].style.display = oTable.rows[i].cells[5].style.display=="none"?"block":"none";
	}
}


function bar(){
  if ((event.keyCode == 13) && ($("#barcode").val()!="")){
	addrow();
	alert(escape($("#date").val()));
    $.post("../barcode.asp",{date:escape($("#date").val()),barcode:escape($("#barcode").val()),depot:escape($("#depot").val())},
	function(data)
	{ 
	   i=$("#rowcount").val();
	   str=data.split("|");
	   $("#goodscode"+i).val(str[0]);
	   $("#goodsname"+i).val(str[1]);
	   $("#goodsunit"+i).val(str[2]);
	   $("#units"+i).val(str[3]);
	   $("#number"+i).val("1");
	   $("#aveprice"+i).val(str[8]);
	   $("#fact_num"+i).val(str[7]);
	   $("#remark"+i).val(str[6]);
	   <%if request("type") = "CG" then%>
	     $("#price"+i).val(str[4]);
	   <%else%>
	     $("#price"+i).val(str[5]);
	   <%end if%>
	}
	);
	$("#barcode").val("");
  }
}