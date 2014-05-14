var tab = null;
var max_tab = 6;
$(function() {
	// var h = $(document.body).height();
	// alert(h);
	// var w = $(document.body).width();
	// $(".page_iframe").height(h - 25);
	// $(".page_iframe").width(w);
	// $("#page").height(h - 25);
	// $("#page").width(w);
	tab = new TabView("tab_menu", "page", "tab_po");
	tab.init();
	tab.add({
		id : 'tab_id_index1',
		title : "主页",
		url : "custom/desktop.jsf",
		isClosed : false
	});
	tab.add({
		id : 'tab_id_index2',
		title : "主页dsa",
		url : "custom/desktop.jsf",
		isClosed : false
	});
	tab.add({
		id : 'tab_id_index3',
		title : "主房贷首付是页",
		url : "custom/desktop.jsf",
		isClosed : false
	});
 
	});

var tab_m = {
	index : 0,
	used_index : 0,
	tab : new HashMap(),
	nolock : true
};
function addTab(title, url, pid) {
	if (tab_m.nolock) {
		tab_m.nolock = false;
		pid = (pid == null || pid == "") ? "" : pid
		var size = tab.tabContainer.find(".tab_item").size();
		var id = 'tab_id_' + tab_m.index;
		var option = {
			id : 'tab_id_' + tab_m.index,
			title : title,
			url : url
		}
		// alert(url+pid);
		var tab_id = getMapKeyByValue(pid);
		$("#debug").append(tab_id + " : ");

		if (tab_id) {
			tab.activate(tab_id);
			// alert(pid+" = "+getMapKeyByValue(pid));

		} else {
			if (size < max_tab) {
				tab.add(option);
				tab_m.tab.put(id, pid);

			} else {

				if (tab_m.used_index >= (max_tab - 1)) {
					// alert("00=" + tab_m.used_index);
					tab_m.used_index = 0;
				}

				var uid = 'tab_id_' + tab_m.used_index;
				tab_m.tab.put(uid, pid);
				tab.update({
							id : uid,
							url : url,
							title : title
						});
				// $("#page_" + id).attr("", "");
				tab_m.used_index++;

			}
		}
		tab_m.index++;
		tab_m.nolock = true;
	}
}
function getMapKeyByValue(value) {
	var tabid = null;
	var s = tab_m.tab.keySet();
	if (s != null) {
		for (var i = 0; i < s.length; i++) {
			if (tab_m.tab.get(s[i]) == value) {
				tabid = s[i];
				break;
			} else {
				tabid = null;
			}

		}
	}

	return tabid;
}
/**
 * containerId tab 容器ID， pageId 页面 pageID cid tab ID option 可选参数
 */
function TabView(containerId, pageid, cid, option) {
	var tab_context = {
		current : null,
		current_index : 0,
		current_page : null
	};
	var op = option;

	this.id = cid;
	this.pid = pageid;
	this.tabs = null;
	this.tabContainer = null;

	var tabTemplate = '<span class="tab_item" id="{0}"> <span class="tab_begin"><table><tr>'
			+ '<td><span class="tab_title">{1}</span></td> <td><a href="#" class="tab_close"></a></td> </tr></table></span></span>';
	var tabContainerTemplate = '<div class="tab_ui" id="{0}"><div class="tab_hr"></div></div>';
	var page = '<iframe  id="{0}" frameborder="0" width="100%" height="100%" src="{1}"></iframe>';
	$("#" + containerId).append(tabContainerTemplate.replace("{0}", this.id));
	function initTab(el) {
		var theTab = $(el);
		var tab_begin = $(theTab).find(".tab_begin");
		if (tab_context.current == null || tab_context.current != this) {
			$(theTab).mouseover(function() {
						$(this).addClass("tab_item_mouseover");
						tab_begin.addClass("tab_begin_mouseover");
					}).mouseout(function() {
						$(this).removeClass("tab_item_mouseover");
						tab_begin.removeClass("tab_begin_mouseover");
					}).click(function() {
				if (tab_context.current != null) {
					$(tab_context.current).removeClass("tab_item_selected");
					$(tab_context.current).find(".tab_begin")
							.removeClass("tab_begin_selected");
					$(tab_context.current).find(".tab_close")
							.addClass("tab_close_noselected");
				}
				$(this).addClass("tab_item_selected");
				tab_begin.addClass("tab_begin_selected");

				tab_context.current = this;
				$(tab_context.current).find(".tab_close")
						.removeClass("tab_close_noselected");
				activate($(this).attr("id"), false);
			});
		}

		var tab_close = $(theTab).find(".tab_close").mouseover(function() {
					$(this).addClass("tab_close_mouseover");
				}).mouseout(function() {
					$(this).removeClass("tab_close_mouseover");
				}).click(function() {
					close(theTab.attr("id"));
				});
	}
	function activate(id, isAdd) {
		if (isAdd) {
			$("#" + id).trigger("click");
		}
		if (tab_context.current_page) {
			tab_context.current_page.hide();
		}
		tab_context.current_page = $("#page_" + id);
		tab_context.current_page.show();
	}
	function close(id) {
		var close_page = $("#page_" + id);
		var close_tab = $("#" + id);
		if ($(tab_context.current).attr("id") == close_tab.attr("id")) {
			var next = close_tab.next();
			if (next.attr("id")) {
				activate(next.attr("id"), true);
			} else {
				var pre = close_tab.prev();
				if (pre.attr("id")) {
					activate(pre.attr("id"), true);
				}
			}
		} else {

		}
		// close_page.find("iframe").remove();
		close_page.remove();
		close_tab.remove();
	}
	this.init = function() {
		this.tabContainer = $("#" + this.id);
		this.tabs = this.tabContainer.find(".tab_item");
		this.tabs.each(function() {
					initTab(this);
				});
	}
	this.add = function(option) {
		var op1 = {
			id : '',
			title : '',
			url : '',
			isClosed : true
		};
		$.extend(op1, option);
		if (op1.title.length > 10) {
			op1.title = op1.title.substring(0, 10);
		}
		if (op1.title.length < 4) {
			op1.title = "&nbsp;&nbsp;" + op1.title + "&nbsp;";
		}
		var pageHtml = page.replace("{0}", "page_" + op1.id).replace("{1}",
				op1.url);
		$("#" + this.pid).append(pageHtml);
		var html = tabTemplate.replace("{0}", op1.id).replace("{1}", op1.title);
		this.tabContainer.append(html);
		initTab($("#" + op1.id));
		if (!op1.isClosed) {
			$($("#" + op1.id)).find(".tab_close").hide();
		}

		this.init();
		this.activate(op1.id);
	}
	this.update = function(option) {
		var id = option.id;

		// alert(option.url);
		$("#" + id).find(".tab_title").html(option.title);
		$("#" + id).trigger("click");
		// $("#page_" + id).find("iframe").attr("src", option.url);

		$("#page_" + id).attr("src", option.url);
		// document.getElementById()
	}
	this.activate = function(id) {
		// $("#" + id).trigger("click");
		activate(id, true);
	}
	this.close = function(id) {
		close(id);
	}
}
Array.prototype.remove = function(s) {
	for (var i = 0; i < this.length; i++) {
		if (s == this[i])
			this.splice(i, 1);
	}
}

/**
 * HashMap构造函数
 */
function HashMap() {
	this.length = 0;
	this.prefix = "hashmap_20080918_";
}
/**
 * 向HashMap中添加键值对
 */
HashMap.prototype.put = function(key, value) {
	this[this.prefix + key] = value;
	this.length++;
}
/**
 * 从HashMap中获取value值
 */
HashMap.prototype.get = function(key) {
	return typeof this[this.prefix + key] == "undefined"
			? null
			: this[this.prefix + key];
}
/**
 * 从HashMap中获取所有key的集合，以数组形式返回
 */
HashMap.prototype.keySet = function() {
	var arrKeySet = new Array();
	var index = 0;
	for (var strKey in this) {
		if (strKey.substring(0, this.prefix.length) == this.prefix)
			arrKeySet[index++] = strKey.substring(this.prefix.length);
	}
	return arrKeySet.length == 0 ? null : arrKeySet;
}
/**
 * 从HashMap中获取value的集合，以数组形式返回
 */
HashMap.prototype.values = function() {
	var arrValues = new Array();
	var index = 0;
	for (var strKey in this) {
		if (strKey.substring(0, this.prefix.length) == this.prefix)
			arrValues[index++] = this[strKey];
	}
	return arrValues.length == 0 ? null : arrValues;
}
/**
 * 获取HashMap的value值数量
 */
HashMap.prototype.size = function() {
	return this.length;
}
/**
 * 删除指定的值
 */
HashMap.prototype.remove = function(key) {
	delete this[this.prefix + key];
	this.length--;
}
/**
 * 清空HashMap
 */
HashMap.prototype.clear = function() {
	for (var strKey in this) {
		if (strKey.substring(0, this.prefix.length) == this.prefix)
			delete this[strKey];
	}
	this.length = 0;
}
/**
 * 判断HashMap是否为空
 */
HashMap.prototype.isEmpty = function() {
	return this.length == 0;
}
/**
 * 判断HashMap是否存在某个key
 */
HashMap.prototype.containsKey = function(key) {
	for (var strKey in this) {
		if (strKey == this.prefix + key)
			return true;
	}
	return false;
}
/**
 * 判断HashMap是否存在某个value
 */
HashMap.prototype.containsValue = function(value) {
	for (var strKey in this) {
		if (this[strKey] == value)
			return true;
	}
	return false;
}
/**
 * 把一个HashMap的值加入到另一个HashMap中，参数必须是HashMap
 */
HashMap.prototype.putAll = function(map) {
	if (map == null)
		return;
	if (map.constructor != HashMap)
		return;
	var arrKey = map.keySet();
	var arrValue = map.values();
	for (var i in arrKey)
		this.put(arrKey[i], arrValue[i]);
}
// toString
HashMap.prototype.toString = function() {
	var str = "";
	for (var strKey in this) {
		if (strKey.substring(0, this.prefix.length) == this.prefix)
			str += strKey.substring(this.prefix.length) + " : " + this[strKey]
					+ "\r\n";
	}
	return str;
}