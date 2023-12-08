<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="update" /><spring:message code="DOC_DATA" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var DOC_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.DOC_ID_ != undefined) ? DOC_ID_ = parameters.DOC_ID_ : 0;
	}

	var isUsingTemplate;

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'isUsingTemplate.do',
			async : false,//同步加载
			params : {
				'DOC_ID_' : DOC_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data != null) {
						isUsingTemplate = data.isUsingTemplate;
					}
				}
			}
		});

		var docDataStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'docDataStore',
			autoLoad : true,//true为自动加载
			loading : true,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'DOC_DATA_ID_', 'DOC_ID_', 'BOOKMARK_', 'VALUE_' ],
			proxy : {
				url : 'selectDocData.do',
				type : 'ajax',
				async : true,
				actionMethods : {
					read : 'POST'
				},
				extraParams : {
					'DOC_ID_' : DOC_ID_
				},
				reader : {
					type : 'json',
					root : 'docDataList',
					totalProperty : 'total'
				}
			},
			listeners : {
				'load' : function(store, records, successful, eOpts) {
					_init();//自动加载时必须调用
				}
			}
		});

		var docDataFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'docDataFormPanel',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 720,
				margin : '4',
				readOnly : true
			},
			items : [],
			dockedItems : [ {//所属按钮面板
				xtype : 'panel',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					margin : '2'
				},
				dock : 'top',
			} ]
		});

		Ext.create('Ext.container.Viewport', {//整体布局
			layout : {
				type : 'border',//border布局
				regionWeights : {//四个角的归属
					west : -1,
					north : 1,
					south : 1,
					east : -1
				}
			},
			padding : '1 1 1 1',
			defaults : {
				border : false,
				frame : true
			},
			items : [ {
				region : 'center',
				layout : 'fit',//充满
				items : [ docDataFormPanel ]
			} ]
		});

		_init();
	});

	function _init() {//初始化。页面和所有自动加载数据全部加载完成后调用。
		for (var i = 0; i < Ext.data.StoreManager.getCount(); i++) {//检查是否所有自动加载数据已经全部加载完成
			if (Ext.data.StoreManager.getAt(i).isLoading()) {
				return;
			}
		}

		_initDocDataForm();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _initDocDataForm() {//修改
		var docDataFormPanel = Ext.getCmp('docDataFormPanel');

		if (!isUsingTemplate) {
			docDataFormPanel.setHtml('<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;"><spring:message code="notUsingTemplate" /></div>');
			return;
		}

		var docDataStore = Ext.data.StoreManager.lookup('docDataStore');
		var docData;
		var field;
		for (var i = 0; i < docDataStore.getCount(); i++) {
			docData = docDataStore.getAt(i);
			docDataFormPanel.add({
				xtype : 'textfield',
				name : docData.get('BOOKMARK_'),
				fieldLabel : docData.get('BOOKMARK_'),
				value : docData.get('VALUE_')
			});
		}
	}
</script>
</head>
<body>
</body>
</html>