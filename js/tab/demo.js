var tab = null;
$( function() {
	newTab1();
	newTab2();
});
function newTab1() {
	var tab = new TabView( {
		containerId :'tab_menu',
		pageid :'page',
		cid :'tab_po',
		position :"bottom"
	});
	tab.add( {
		id :'tab1_id_index1',
		title :"百度主页",
		url :"http://www.baidu.com",
		isClosed :true
	});
	tab.add( {
		id :'tab2_id_index2',
		title :"谷歌主页",
		url :"http://www.google.cn",
		isClosed :false
	});
	tab.add( {
		id :'tab3_id_index3',
		title :"我的主页",
		url :"http://blog.csdn.net/myloon",
		isClosed :false
	});
	tab.add( {
		id :'tab4_id_index4',
		title :"标签页面1",
		url :"tabs/tab1.html",
		isClosed :true
	});
	tab.add( {
		id :'tab5_id_index5',
		title :"标签页面2",
		url :"tabs/tab2.html",
		isClosed :true
	});
	tab.add( {
		id :'tab6_id_index6',
		title :"标签页面3",
		url :"tabs/tab3.html",
		isClosed :true
	});
	tab.add( {
		id :'tab7_id_index7',
		title :"标签页面4",
		url :"tabs/tab4.html",
		isClosed :true
	});
}
function newTab2() {
	var tab = new TabView( {
		containerId :'tab_menu2',
		pageid :'page2',
		cid :'tab_po2',
		position :"top"
	});
	tab.add( {
		id :'tab_id_index1',
		title :"百度主页",
		url :"http://www.baidu.com",
		isClosed :true
	});
	tab.add( {
		id :'tab_id_index2',
		title :"谷歌主页",
		url :"http://www.google.cn",
		isClosed :false
	});
	tab.add( {
		id :'tab_id_index3',
		title :"我的主页",
		url :"http://blog.csdn.net/myloon",
		isClosed :false
	});
	tab.add( {
		id :'tab_id_index4',
		title :"标签页面1",
		url :"tabs/tab1.html",
		isClosed :true
	});
	tab.add( {
		id :'tab_id_index5',
		title :"标签页面2",
		url :"tabs/tab2.html",
		isClosed :true
	});
	tab.add( {
		id :'tab_id_index6',
		title :"标签页面3",
		url :"tabs/tab3.html",
		isClosed :true
	});
	tab.add( {
		id :'tab_id_index7',
		title :"标签页面4",
		url :"tabs/tab4.html",
		isClosed :true
	});
}
