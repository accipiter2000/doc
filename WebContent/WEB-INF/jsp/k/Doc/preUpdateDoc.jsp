<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="update" /><spring:message code="DOC" /></title>
<link rel="stylesheet" type="text/css" href="<%=((java.util.Map) session.getAttribute("operator")).get("CSS_HREF_")%>" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	var win;//父窗口对象，由子窗口调用
	var returnValue;//父窗口对象，由子窗口调用

	//获取url中的入参
	var DOC_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.DOC_ID_ != undefined) ? DOC_ID_ = parameters.DOC_ID_ : 0;
	}

	var doc;//被修改对象

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		if (DOC_ID_ != null && DOC_ID_ != '') {
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
						}
					}
				}
			});
		}

		var docFormPanel = Ext.create('Ext.form.Panel', {//表单
			id : 'docFormPanel',
			layout : 'column',
			autoScroll : true,
			defaults : {
				labelAlign : 'right',
				labelWidth : 120,
				width : 360,
				margin : '4'
			},
			items : [ {
				xtype : 'fieldset',
				title : '<spring:message code="pleaseChoose" /><spring:message code="DOC_TYPE" />',
				layout : 'column',
				width : '96%',
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 360,
					margin : '4'
				},
				items : [ {
					xtype : 'hiddenfield',//隐藏的主键，提交表单时使用
					name : 'DOC_ID_'
				}, {
					xtype : 'hiddenfield',
					name : 'DOC_TYPE_ID_',
					allowBlank : false
				}, {
					xtype : 'textfield',
					name : 'DOC_TYPE_NAME_',
					fieldLabel : '<spring:message code="DOC.DOC_TYPE_NAME_" />',
					editable : false,
					allowBlank : false
				}, {
					xtype : 'button',
					text : '<spring:message code="choose" /><spring:message code="DOC_TYPE" />',
					width : null,
					handler : _chooseDocType
				} ]
			}, {
				id : 'basicDocInfo',
				xtype : 'fieldset',
				title : '公文基本信息',
				layout : 'column',
				width : '96%',
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 360,
					margin : '4'
				},
				items : [ {
					xtype : 'textfield',
					name : 'DOC_CODE_',
					fieldLabel : '<spring:message code="DOC.DOC_CODE_" />',
					maxLength : 20,
					allowBlank : true
				}, {
					xtype : 'textfield',
					name : 'DOC_NAME_',
					fieldLabel : '<spring:message code="DOC.DOC_NAME_" />',
					maxLength : 20,
					allowBlank : false
				}, {
					xtype : 'textfield',
					name : 'MEMO_',
					fieldLabel : '<spring:message code="DOC.MEMO_" />',
					maxLength : 40,
					allowBlank : true
				} ]
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
					handler : _updateDoc
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
								html : '<spring:message code="update" /><spring:message code="DOC" /><br /><br /><spring:message code="help.updateDoc" />'
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
				items : [ docFormPanel ]
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
		if (DOC_ID_ != null && DOC_ID_ != '' && doc == null) {//检查被修改对象是否加载成功
			Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.loadDataFailed" />', Ext.MessageBox.ERROR);
			return;
		}

		var form = Ext.getCmp('docFormPanel').getForm();//设置初始值，初始验证。
		if (DOC_ID_ != null && DOC_ID_ != '') {
			for ( var key in doc) {
				(form.findField(key) != null) ? form.findField(key).setValue(doc[key]) : 0;
			} 
		} else {
			Ext.getCmp('basicDocInfo').setCollapsed(true);
		}
		form.isValid();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _updateDoc() {//修改
		var url = 'insertDocByDocType.do';
		if (DOC_ID_ != null && DOC_ID_ != '') {
			url = 'updateDoc.do';
		}

		Ext.getCmp('docFormPanel').getForm().submit({//提交表单
			url : url,
			submitEmptyText : false,
			waitMsg : '<spring:message code="processing" />',
			success : function(form, action) {
				var data = action.result;
				parent.returnValue = data.doc;
				if (DOC_ID_ == null || DOC_ID_ == '') {
					DOC_ID_ = data.doc.DOC_ID_;
					Ext.getCmp('docFormPanel').getForm().findField('DOC_ID_').setValue(DOC_ID_);
					parent.doc = data.doc;
					parent._afterInsertDoc();
				} else {
					parent.doc = data.doc;
					parent._afterUpdateDoc();
				}

				parent.Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
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

	function _chooseDocType() {
		returnValue = null;
		win = Ext.create('Ext.window.Window', {
			title : '<spring:message code="choose" /><spring:message code="DOC_TYPE" />',
			modal : true,
			autoShow : true,
			maximized : false,
			maximizable : true,
			width : 800,
			height : '80%',
			html : '<iframe src="preChooseCustomDocType.do?token=' + (localStorage.token != null ? localStorage.token : '') + '" style="width: 100%; height: 100%;" frameborder="0"></iframe>',
			listeners : {
				'close' : function(panel, eOpts) {
					if (returnValue != null) {
						var docType = returnValue;

						if (DOC_ID_ != null && DOC_ID_ != '') {
							Ext.MessageBox.show({
								title : '<spring:message code="pleaseConfirm" />',
								msg : '<spring:message code="switch" /><spring:message code="to" /><spring:message code="DOC_TYPE" />?',
								buttons : Ext.MessageBox.YESNO,
								icon : Ext.MessageBox.QUESTION,
								fn : function(btn) {
									if (btn == 'yes') {
										var form = Ext.getCmp('docFormPanel').getForm();//设置初始值，初始验证。
										form.findField('DOC_TYPE_ID_').setValue(docType.DOC_TYPE_ID_);
										form.findField('DOC_TYPE_NAME_').setValue(docType.DOC_TYPE_NAME_);

										Ext.Ajax.request({
											url : 'updateDocByDocType.do',
											async : false,
											params : {
												'DOC_ID_' : DOC_ID_,
												'DOC_TYPE_ID_' : docType.DOC_TYPE_ID_
											},
											callback : function(options, success, response) {
												if (success) {
													var data = Ext.decode(response.responseText);
													if (data.success) {//更新页面数据
														var docDataPanel = parent.document.getElementById('docDataPanel');
														if (docDataPanel != null) {
															docDataPanel.contentWindow.location.reload();
														}

														Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);
													} else {
														Ext.MessageBox.alert('<spring:message code="error" />', data.message, Ext.MessageBox.ERROR);
													}
												} else {
													Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.serverError" />', Ext.MessageBox.ERROR);
												}
											}
										});
									}
								}
							});
						} else {
							var form = Ext.getCmp('docFormPanel').getForm();//设置初始值，初始验证。
							form.findField('DOC_TYPE_ID_').setValue(docType.DOC_TYPE_ID_);
							form.findField('DOC_TYPE_NAME_').setValue(docType.DOC_TYPE_NAME_);

							Ext.getCmp('basicDocInfo').setCollapsed(false);
						}
					}
				}
			}
		});
	}

	function _updateParentDocStatus() {
		var form = Ext.getCmp('docFormPanel').getForm();//设置初始值，初始验证。
		var DOC_RELATION_TYPE_ = form.findField('DOC_RELATION_TYPE_');
		var PARENT_DOC_ID_ = _ = form.findField('PARENT_DOC_ID_');
		var PARENT_DOC_NAME_ = _ = form.findField('PARENT_DOC_NAME_');
		var chooseParentDocButton = Ext.getCmp('chooseParentDocButton');

		PARENT_DOC_NAME_.setHidden(true);
		chooseParentDocButton.setHidden(true);
		PARENT_DOC_ID_.setValue('');
		PARENT_DOC_NAME_.setValue('');
		PARENT_DOC_ID_.allowBlank = true;
		PARENT_DOC_NAME_.allowBlank = true;
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>