// JavaScript Document
function locking(){   
	document.all.ly.style.display="block";   
	document.all.ly.style.width=document.body.clientWidth;   
	document.all.ly.style.height=document.body.clientHeight;   
	document.all.Layer2.style.display='block';  
}   
function Lock_CheckForm(theForm){   
	document.all.ly.style.display='none';document.all.Layer2.style.display='none';
	return false;   
} 