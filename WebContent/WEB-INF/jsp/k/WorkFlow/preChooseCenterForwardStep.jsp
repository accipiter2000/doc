<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="manage" /><spring:message code="TASK" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script type="text/javascript" src="js/jsonpath.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	//获取url中的入参
	var PROC_ID_ = null;
	var TASK_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.PROC_ID_ != undefined) ? PROC_ID_ = parameters.PROC_ID_ : 0;
		(parameters.TASK_ID_ != undefined) ? TASK_ID_ = parameters.TASK_ID_ : 0;
	}

	var runningProcDef;
	var currentJsonpath = '$';

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'getRunningProcDef.do',
			async : false,//同步加载
			params : {
				'PROC_ID_' : PROC_ID_,
				'TASK_ID_' : TASK_ID_,
				'drawOptional' : true
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						runningProcDef = data.runningProcDef;
					}
				}
			}
		});

		var runningProcDiagramPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'runningProcDiagramPanel',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				margin : '4'
			},

			dockedItems : [ {//所属按钮面板
				xtype : 'panel',
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
								html : '<spring:message code="update" /><spring:message code="DOC_DATA" /><br /><br /><spring:message code="help.updateDocData" />'
							});
						}
					}
				} ],
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
				items : [ runningProcDiagramPanel ]
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

		_switchToSubProc(currentJsonpath);

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _switchToSubProc(jsonpath) {//关闭窗口
		var subProcRunningProcDefList;
		if (jsonpath == '$') {
			subProcRunningProcDefList = new Array();
			subProcRunningProcDefList.push(runningProcDef);
		} else {
			subProcRunningProcDefList = jsonPath(runningProcDef, jsonpath)[0];
		}

		var subProcRunningProcDef;
		var html = '';
		for (var i = 0; i < subProcRunningProcDefList.length; i++) {
			subProcRunningProcDef = subProcRunningProcDefList[i];
			html += '<img src="data:image/png;base64,' + subProcRunningProcDef.runningDiagram + '" usemap="#subProcDiagram' + i + '" /><map id="subProcDiagram' + i + '" name="subProcDiagram' + i + '">';
			if (subProcRunningProcDef.nodeDefList) {
				var nodeDef;
				for (var j = 0; j < subProcRunningProcDef.nodeDefList.length; j++) {
					nodeDef = subProcRunningProcDef.nodeDefList[j];
					if (nodeDef.centerForwardStep != null) {
						html += '<area shape="' + nodeDef.shape.type + '" coords="' + nodeDef.shape.coords + '" href="javascript:_chooseCenterForwardStep(' + nodeDef.centerForwardStep + ')" />';
					}
				}
			}
			html += '</map>';
		}
		if (html != '') {
			Ext.getCmp('runningProcDiagramPanel').setHtml(html);
		}
	}

	function _chooseCenterForwardStep(centerForwardStep) {
		parent.returnValue = centerForwardStep;
		_close();
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>