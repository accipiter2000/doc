<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="view" /><spring:message code="DOC" /></title>
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

	var doc;//被修改对象
	var sessionId;

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'loadDoc.do',
			async : false,//同步加载
			params : {
				'DOC_ID_' : DOC_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						doc = data.doc;
					} else {
						doc = new Object();
					}
				}
			}
		});

		Ext.Ajax.request({//加载被修改对象
			url : 'getSessionId.do',
			async : false,//同步加载
			params : {},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						sessionId = data.sessionId;
					}
				}
			}
		});

		var buttonPanel = Ext.create('Ext.Panel', {//按钮
			id : 'buttonPanel',
			layout : 'column',
			defaults : {
				labelAlign : 'right',
				margin : '2'
			},
			items : [ {
				xtype : 'button',
				text : '<spring:message code="close" />',
				icon : 'image/icon/close.png',
				handler : _close
			}, {
				xtype : 'box',
				style : 'position: absolute; top: 6px; right: 6px;',
				autoEl : {
					tag : 'img',
					src : 'image/icon/help.png'
				},
				listeners : {
					'render' : function(cmp, eOpts) {
						Ext.create('Ext.tip.ToolTip', {
							target : cmp.getEl(),
							dismissDelay : 60000,
							html : '<spring:message code="manage" /><spring:message code="ORGANIZATION" /><br /><br /><spring:message code="help.manageOrganization" />'
						});
					}
				}
			} ]
		});

		var tabPanel = Ext.create('Ext.tab.Panel', {//tab
			id : 'tabPanel',
			items : [ {
				title : '<spring:message code="DOC" />',
				layout : 'fit',
				html : '<iframe src="viewDocBasicInfo.do?DOC_ID_=' + DOC_ID_ + '&token=' + (localStorage.token != null ? localStorage.token : '') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
			}, {
				title : '<spring:message code="DOC_DATA" />',
				layout : 'fit',
				html : '<iframe src="viewDocData.do?DOC_ID_=' + DOC_ID_ + '&token=' + (localStorage.token != null ? localStorage.token : '') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
			}, {
				id : 'docFile',
				title : '<spring:message code="DOC.DOC_FILE_" />',
				layout : 'fit'
			}, {
				title : '<spring:message code="RIDER" />',
				layout : 'fit',
				html : '<iframe src="viewDocRider.do?DOC_ID_=' + DOC_ID_ + '&hideButtonPanel=true&token=' + (localStorage.token != null ? localStorage.token : '') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
			}, {
				title : '<spring:message code="APPROVAL_MEMO" />',
				layout : 'fit',
				hidden : (doc.PROC_ID_) ? false : true,
				html : '<iframe src="viewApprovalMemo.do?PROC_ID_=' + doc.PROC_ID_ + '&hideButtonPanel=true&token=' + (localStorage.token != null ? localStorage.token : '') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
			}, {
				title : '<spring:message code="PROC_DIAGRAM" />',
				layout : 'fit',
				hidden : (doc.PROC_ID_) ? false : true,
				html : '<iframe src="viewRunningProcDiagram.do?PROC_ID_=' + doc.PROC_ID_ + '&hideButtonPanel=true&token=' + (localStorage.token != null ? localStorage.token : '') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
			} ],
			listeners : {
				beforetabchange : function(tabs, newTab, oldTab) {
					if (newTab.id == 'docFile') {
						var url = 'office://word$open$' + document.getElementById('base').href + 'loadDocFile.do;jsessionid=' + sessionId + '?DOC_ID_=' + DOC_ID_;
						window.open(url);
						return false;
					}
				}
			}
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
				region : 'north',
				items : [ buttonPanel ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ tabPanel ]
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

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>