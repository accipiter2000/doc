<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="insert" /><spring:message code="PROC_DEF" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var NODE_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.NODE_ID_ != undefined) ? NODE_ID_ = parameters.NODE_ID_ : 0;
	}

	var branch;
	var adjustProcDef;

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'loadBranch.do',
			async : false,//同步加载
			params : {
				'NODE_ID_' : NODE_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						branch = data.branch;
					}
				}
			}
		});

		if (branch.ADJUST_SUB_PROC_DEF_ID_ != null) {
			Ext.Ajax.request({//加载被修改对象
				url : 'loadAdjustProcDef.do',
				async : false,//同步加载
				params : {
					'ADJUST_PROC_DEF_ID_' : branch.ADJUST_SUB_PROC_DEF_ID_
				},
				callback : function(options, success, response) {
					if (success) {
						var data = Ext.decode(response.responseText);
						if (data.success) {
							adjustProcDef = data.adjustProcDef;
						}
					}
				}
			});
		} else {
			Ext.Ajax.request({//加载被修改对象
				url : 'loadProcDef.do',
				async : false,//同步加载
				params : {
					'PROC_DEF_ID_' : branch.SUB_PROC_DEF_ID_
				},
				callback : function(options, success, response) {
					if (success) {
						var data = Ext.decode(response.responseText);
						if (data.success) {
							adjustProcDef = data.procDef;
						}
					}
				}
			});
		}

		var procDefFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'procDefFormPanel',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 360,
				margin : '4'
			},
			items : [ {
				xtype : 'hiddenfield',
				name : 'BRANCH_ID_',
				value : branch.NODE_ID_
			}, {
				xtype : 'textareafield',
				name : 'PROC_DEF_MODEL_',
				fieldLabel : '<spring:message code="PROC_DEF.PROC_DEF_MODEL_" />',
				width : '92%',
				height : 400
			}, {
				xtype : 'filefield',
				name : 'PROC_DEF_DIAGRAM_FILE_',
				fieldLabel : '<spring:message code="PROC_DEF.PROC_DEF_DIAGRAM_FILE_" />',
				buttonText : '<spring:message code="pleaseChoose" />',
				width : '92%',
				allowBlank : true
			} ],
			dockedItems : [ {//所属按钮面板
				xtype : 'panel',
				layout : 'column',
				defaults : {
					labelAlign : 'right',
					margin : '2'
				},
				items : [ {
					xtype : 'button',
					text : '<spring:message code="save" />',
					icon : 'image/icon/save.png',
					handler : _adjustBranchProcDef
				}, {
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
								html : '<spring:message code="insert" /><spring:message code="PROC_DEF" /><br /><br /><spring:message code="help.insertProcDef" />'
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
			defaults : {
				border : false,
				frame : true
			},
			items : [ {
				region : 'center',
				layout : 'fit',//充满
				items : [ procDefFormPanel ]
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

		var form = Ext.getCmp('procDefFormPanel').getForm();//设置初始值，初始验证。
		form.findField('PROC_DEF_MODEL_').setValue(adjustProcDef.PROC_DEF_MODEL_);
		form.isValid();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _adjustBranchProcDef() {//新增
		Ext.getCmp('procDefFormPanel').getForm().submit({//提交表单
			url : 'adjustBranchProcDef.do',
			submitEmptyText : false,
			waitMsg : '<spring:message code="processing" />',
			success : function(form, action) {
				var data = action.result;

				_close();
			},
			failure : function(form, action) {
				switch (action.failureType) {
					case Ext.form.action.Action.CLIENT_INVALID:
						Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.inputRequired" />', Ext.MessageBox.ERROR);
						break;
					case Ext.form.action.Action.SERVER_INVALID:
						Ext.MessageBox.alert('<spring:message code="error" />', action.result.message, Ext.MessageBox.ERROR);
						break;
					case Ext.form.action.Action.CONNECT_FAILURE:
						Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
				}
			}
		});
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>