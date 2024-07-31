<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="update" /><spring:message code="DOC_DATA" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script type="text/javascript" src="js/pdf.js"></script>
<script type="text/javascript" src="js/pdf.worker.js"></script>
<script>
	//获取url中的入参
	var DOC_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.DOC_ID_ != undefined) ? DOC_ID_ = parameters.DOC_ID_ : 0;
	}

	var isUsingTemplatePlaceholders;

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'isUsingTemplatePlaceholders.do',
			async : false,//同步加载
			params : {
				'DOC_ID_' : DOC_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data != null) {
						isUsingTemplatePlaceholders = data.isUsingTemplatePlaceholders;
					}
				}
			}
		});

		var docDataStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'docDataStore',
			autoLoad : true,//true为自动加载
			loading : true,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'DOC_DATA_ID_', 'DOC_ID_', 'BOOKMARK_', 'DATA_TYPE_', 'VALUE_', 'ORDER_' ],
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
				width : 360,
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

		var pdfPanel = Ext.create('Ext.Panel', {
			id : 'pdfPanel',
			frame : true,
			autoScroll : true
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
				id : 'west',
				region : 'west',
				width : 750,
				layout : 'fit',//充满
				items : [ docDataFormPanel ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ pdfPanel ]
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

		_loadPdfDocFile();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _initDocDataForm() {//修改
		var docDataFormPanel = Ext.getCmp('docDataFormPanel');

		if (isUsingTemplatePlaceholders == '0') {
			Ext.getCmp('west').setHidden(true);
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

	function _loadPdfDocFile() {
		var pdfPanelRenderTargetId = Ext.getCmp('pdfPanel').getLayout().getRenderTarget().id;
		var pdfPanel = document.getElementById(pdfPanelRenderTargetId);
		pdfPanel.innerHTML = '';

		var pdfUrl = 'loadPdfDocFile.do?DOC_ID_=' + DOC_ID_;
		PDFJS.getDocument(pdfUrl).then(function getPdf(pdf) {
			for (var i = 0; i < pdf.numPages; i++) {
				_renderPage(pdf, i + 1);
			}
		});
	}

	function _renderPage(pdf, number) {
		pdf.getPage(number).then(function(page) {
			var scale = 1.5;
			var viewport = page.getViewport(scale);
			var canvas = document.createElement('canvas');
			var context = canvas.getContext('2d');
			canvas.id = 'canvas' + number;
			canvas.height = viewport.height;
			canvas.width = viewport.width;
			var pdfPanelRenderTargetId = Ext.getCmp('pdfPanel').getLayout().getRenderTarget().id;
			document.getElementById(pdfPanelRenderTargetId).appendChild(canvas);
			page.render({
				canvasContext : context,
				viewport : viewport
			});
		});
	}
</script>
</head>
<body>
</body>
</html>