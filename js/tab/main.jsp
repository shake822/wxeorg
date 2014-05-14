<%@ page language="java" contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<script type="text/javascript" src="../jquery.js"></script>
<script type="text/javascript" src="main.js"></script>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	border: 0;
}

html,body {
	overflow: auto;
	font-size: 12px;
	text-decoration: none;
	height: 100%;
	width: 100%;
}

#page {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: expression(parentNode.parentNode.offsetHeight-25)
		;
}

.page_iframe {
	width: 100%;
	height: 100%;
}

#tab_menu {
	position: absolute;
	left: 0;
	padding: 0px;
	width: 100%;
	height: 60px;
	bottom: 90px;
	border: solid 1px #cccccc;
}

.tab_ui {
	width: 100%;
	height: 40px;
	margin: 0px;
	padding: 0px;
	font-size: 12px;
	white-space: nowrap;
	overflow: hidden;
}

.tab_hr {
	width: 100%;
	height: 2px;
	background-color: #8CAEEE;
	position: relative;
	top: 2px;
	z-index: -10;
	font-size: 0px;
	display: block;
}

.tab_item {
	margin-left: 2px;
	height: 40px;
	padding-left: 4px;
	background-image: url(imgs/tab_left.gif);
	background-repeat: no-repeat;
	background-position: 0px 0px;
	cursor: hand;
	cursor: pointer;
	font-weight: bold;
	display: inline;
	border: solid 1px #cccccc;
	z-index: 100;
}

.tab_item_mouseover {
	background-position: 0px -22px;
}

.tab_item_selected {
	background-position: 0px -44px;
}

.tab_begin {
	cursor: hand;
	background-image: url(imgs/tab_right.gif);
	background-repeat: no-repeat;
	background-position: right -0px;
}

.tab_begin_mouseover {
	background-position: right -22px;
}

.tab_begin_selected {
	background-position: right -44px;
}

.tab_begin table {
	cursor: hand;
	display: inline;
}

.tab_title {
	cursor: hand;
	display: inline;
	padding-right: 4px;
}

.tab_close {
	display: block;
	width: 16px;
	height: 16px;
	font-size: 9px;
	margin-right: 4px;
	margin-top: 0px;
	background-color: #00CC66;
	background-image: url(imgs/tab_close.gif);
	background-repeat: no-repeat;
	cursor: hand;
	background-color: #00CC66;
}

.tab_close_mouseover {
	background-position: 0px -16px;
}

.tab_close_selected {
	background-position: 0px 0px;
}

.tab_close_noselected {
	background-position: 0px -32px;
}
</style>
</head>


<body>
<div id="page"></div>
<div id="tab_menu"></div>

</body>

</html>