Ext.onReady(function(){
	var myData = [
		['供应商','XX供应商'],
		['客户','XX经销商'],
		['','test']
		];
	var store = new Ext.data.SimpleStore({fields : [
		{name:'CustType'},
		{name:'CustName'}
		],
	data:myData
	});
	var grid = new Ext.grid.GridPanel({
		store:store,
		cloumns:[
			{header:'单位类别',dataIndex:'CustType'},
			{header:'公司名称',dataIndex:'CustName'}
		],
		title:'Test'
	});
	grid.render(document.body);
});