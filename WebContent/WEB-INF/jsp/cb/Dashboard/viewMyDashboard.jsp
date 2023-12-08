<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="view" /><spring:message code="DASHBOARD" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<style type="text/css">
.dashboardDiv {
	float: left;
}

.dashboardBorderDiv {
	width: calc(100% - 6px);
	height: calc(100% - 6px);
	box-shadow: 0px 0px 3px 1px rgba(0, 100, 0, 0.6);
	margin: 3px;
}

.dashboardHeaderDiv {
	width: 100%;
	height: 30px;
	line-height: 30px;
	position: relative;
	text-align: center;
	font-size: 16px;
	border-bottom: 1px solid #CCCCCC;
}

.dashboardCenterDiv {
	width: 100%;
	height: calc(100% - 31px);
}
</style>
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
<script>
	Ext.onReady(function() {
		var dashboardStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'dashboardStore',
			autoLoad : true,//true为自动加载
			loading : true,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'DASHBOARD_ID_', 'DASHBOARD_MODULE_ID_', 'POSI_EMP_ID_', 'DASHBOARD_MODULE_NAME_', 'URL_', 'WIDTH_', 'HEIGHT_', 'ORDER_' ],
			proxy : {
				url : 'selectMyDashboard.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {},
				reader : {
					type : 'json',
					root : 'dashboardList',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, records, successful, eOpts) {
					_init();//自动加载时必须调用
				}
			}
		});

		_init();
	});

	function _init() {//初始化加载
		for (var i = 0; i < Ext.data.StoreManager.getCount(); i++) {
			if (Ext.data.StoreManager.getAt(i).isLoading()) {
				return;
			}
		}

		var dashboardStore = Ext.data.StoreManager.lookup('dashboardStore');//组装子代码数据，过滤注入。
		var id;
		var name;
		var url;
		var width;
		var height;
		for (var i = 0; i < dashboardStore.getCount(); i++) {
			id = dashboardStore.getAt(i).get('DASHBOARD_ID_');
			name = dashboardStore.getAt(i).get('DASHBOARD_MODULE_NAME_');
			url = dashboardStore.getAt(i).get('URL_');
			width = dashboardStore.getAt(i).get('WIDTH_');
			height = dashboardStore.getAt(i).get('HEIGHT_');
			if (width.indexOf('%') == -1) {//判断是否为百分比类型宽度
				width += 'px';
			}
			height += 'px';

			//创建dashboardDiv，控制大小和布局
			var $dashboardDiv = $('<div id="' + id + '" class="dashboardDiv" style="width: ' + (width) + '; height: ' + height + ';" ></div>');
			$('body').append($dashboardDiv);

			//创建dashboardBorderDiv，控制dashboard外观展示
			var $dashboardBorderDiv = $('<div class="dashboardBorderDiv"></div>');
			$dashboardDiv.append($dashboardBorderDiv);

			//创建dashboardHeaderDiv，控制题头和折叠
			var $dashboardHeaderDiv = $('<div class="dashboardHeaderDiv"></div>');
			$dashboardHeaderDiv.text(name);
			$dashboardHeaderDiv.append($('<img style="position: absolute; top: 8px; right: 8px; cursor: pointer;" src="image/icon/fold.png" onclick="_toggleDashboard(\'' + id + '\')" />'));
			$dashboardBorderDiv.append($dashboardHeaderDiv);

			//创建 dashboardCenterDiv，控制展示iframe
			var $dashboardCenterDiv = $('<div class="dashboardCenterDiv"></div>');
			$dashboardCenterDiv.append($('<iframe src="' + url + '" style="width: 100%; height: 100%; border: 0px;"></iframe>'));
			$dashboardBorderDiv.append($dashboardCenterDiv);
		}
	}

	function _toggleDashboard(id) {//折叠
		var $dashboardDiv = $('#' + id);
		var $img = $dashboardDiv.find("div div img");

		if ($dashboardDiv.css('height') == '36px') {
			var dashboardStore = Ext.data.StoreManager.lookup('dashboardStore');//组装子代码数据，过滤注入。
			$dashboardDiv.css('height', dashboardStore.findRecord('DASHBOARD_ID_', new RegExp('^' + id + '$')).get('HEIGHT_') + 'px');
			$img.css("background-image", 'url("image/icon/fold.png")');
		} else {
			$dashboardDiv.css('height', '36px');
			$img.css("background-image", 'url("image/icon/expand.png")');
		}
	}
</script>
</head>
<body>
</body>
</html>