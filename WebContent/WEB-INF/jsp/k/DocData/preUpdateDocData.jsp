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
<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="js/pdf.js"></script>
<script type="text/javascript" src="js/pdf.worker.js"></script>
<script>
	//获取url中的入参
	var DOC_ID_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.DOC_ID_ != undefined) ? DOC_ID_ = parameters.DOC_ID_ : 0;
	}

	var doc;
	var templateHtml;//html格式文档模板
	var templateBookmarkList;//被修改对象
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
					if (data != null) {
						doc = data.doc;
					}
				}
			}
		});

		Ext.Ajax.request({//加载被修改对象
			url : 'loadDocTemplateHtml.do',
			async : false,//同步加载
			params : {
				'DOC_ID_' : DOC_ID_,
				'editable' : true
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data != null) {
						templateHtml = data.templateHtml;
					}
				}
			}
		});

		Ext.Ajax.request({//加载被修改对象
			url : 'getDocTemplateBookmarkList.do',
			async : false,//同步加载
			params : {
				'DOC_ID_' : DOC_ID_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data != null) {
						templateBookmarkList = data.templateBookmarkList;
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

		if (doc.USING_TEMPLATE_PLACEHOLDERS_ == '1') {
			var docDataFormPanel = Ext.create('Ext.form.Panel', {//表单
				id : 'docDataFormPanel',
				layout : 'column',
				autoScroll : true,
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 720,
					margin : '4'
				},
				items : [],
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
						handler : _updateDocData
					}, {
						xtype : 'button',
						text : '用Word查看',
						icon : 'image/icon/view.png',
						handler : _viewDocFile
					}, {
						xtype : 'hiddenfield',
						name : 'DOC_ID_',
						value : DOC_ID_
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
				} ],
				listeners : {
					afterrender : function() {
						var panel = this;
						Ext.create('Ext.util.KeyNav', {
							target : panel.getEl(),
							enter : function(e) {
								panel.down('[hasFocus=true]').next().focus();
							}
						});
					}
				}
			});

			var templateHtmlPanel = Ext.create('Ext.form.Panel', {//表单
				id : 'templateHtmlPanel',
				layout : 'column',
				autoScroll : true,
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 720,
					margin : '4'
				},
				html : '<iframe id="templateHtmlFrame" style="width: 100%; height: 100%;" frameborder="0"></iframe>'
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
					region : 'west',
					layout : 'fit',//充满
					width : 800,
					items : [ docDataFormPanel ]
				}, {
					region : 'center',
					layout : 'fit',//充满
					items : [ templateHtmlPanel ]
				} ]
			});
		} else {
			var pdfPanel = Ext.create('Ext.form.Panel', {//表单
				id : 'pdfPanel',
				layout : 'column',
				autoScroll : true,
				defaults : {
					labelAlign : 'right',
					labelWidth : 120,
					width : 720,
					margin : '4'
				},
				items : [],
				dockedItems : [ {//所属按钮面板
					xtype : 'panel',
					layout : 'column',
					defaults : {
						labelAlign : 'right',
						margin : '2'
					},
					items : [ {
						xtype : 'hiddenfield',
						name : 'DOC_ID_',
						value : DOC_ID_
					}, {
						id : 'uploadFileField',
						xtype : 'filefield',
						name : 'DOC_FILE_',
						width : 400,
						buttonText : '<spring:message code="pleaseChoose" /><spring:message code="DOC.DOC_FILE_" />',
						listeners : {
							afterrender : function(cmp) {
								cmp.fileInputEl.set({
									accept : 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
								});
							}
						}
					}, {
						id : 'upload',
						xtype : 'button',
						text : '<spring:message code="upload" />',
						icon : 'image/icon/upload.png',
						handler : _uploadDocFile
					}, {
						xtype : 'button',
						text : '<spring:message code="download" /><spring:message code="DOC.TEMPLATE_FILE_" />',
						icon : 'image/icon/download.png',
						handler : _downloadDocTemplateFile
					}, {
						xtype : 'button',
						text : '<spring:message code="download" /><spring:message code="DOC.DOC_FILE_" />',
						icon : 'image/icon/download.png',
						handler : _downloadDocFile
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
					items : [ pdfPanel ]
				} ]
			});
		}

		_init();
	});

	function _init() {//初始化。页面和所有自动加载数据全部加载完成后调用。
		for (var i = 0; i < Ext.data.StoreManager.getCount(); i++) {//检查是否所有自动加载数据已经全部加载完成
			if (Ext.data.StoreManager.getAt(i).isLoading()) {
				return;
			}
		}

		if (templateBookmarkList == null) {//检查被修改对象是否加载成功
			Ext.MessageBox.alert('<spring:message code="error" />', '<spring:message code="errors.loadDataFailed" />', Ext.MessageBox.ERROR);
			return;
		}

		if (doc.USING_TEMPLATE_PLACEHOLDERS_ == '1') {
			var form = Ext.getCmp('docDataFormPanel').getForm();//设置初始值，初始验证。
			_initDocDataForm();
			form.isValid();
		} else {
			_loadPdfDocFile();
		}

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _initDocDataForm() {//修改
		//显示html格式的文档
		var contentDocument = document.getElementById('templateHtmlFrame').contentDocument;
		contentDocument.write(templateHtml);
		var $input = $(contentDocument).find('input');
		$input.css('border-width', '0px 0px 1px 0px');
		$input.css('border-style', 'solid');
		$input.css('border-color', 'black');
		$input.attr('readonly', 'readonly');

		var docDataFormPanel = Ext.getCmp('docDataFormPanel');
		var form = docDataFormPanel.getForm();
		var docDataStore = Ext.data.StoreManager.lookup('docDataStore');
		var docData;
		var field;
		var $elements;
		//按标签创建录入框
		for (var i = 0; i < templateBookmarkList.length; i++) {
			docDataFormPanel.add({
				xtype : 'textfield',
				name : templateBookmarkList[i].bookmark,
				fieldLabel : templateBookmarkList[i].bookmark,
				listeners : {
					change : function(textfield, newValue, oldValue, eOpts) { // 同步录入框和html格式中的文档数值 
						$elements = $(contentDocument).find('input[name="' + textfield.getName() + '"]');
						$elements.val(newValue);
					},
					focus : function(textfield, event, eOpts) { // 标识位置
						$elements = $(contentDocument).find('input[name="' + textfield.getName() + '"]');
						$elements.css('color', 'red');
						$elements.css('border-color', 'red');

						var renderTargetId = Ext.getCmp('templateHtmlPanel').getLayout().getRenderTarget().id
						var renderTargetHeight = $('#' + renderTargetId).height();
						var elementTop = $elements[0].getBoundingClientRect().top;
						if (elementTop <= 0 || renderTargetHeight <= elementTop) {
							$elements[0].scrollIntoView();
						}
					},
					blur : function(textfield, event, eOpts) { // 取消标识位置
						$elements = $(contentDocument).find('input[name="' + textfield.getName() + '"]');
						$elements.css('color', 'black');
						$elements.css('border-color', 'black');
					}
				}
			});
		}
		//初始化文档数值
		for (var i = 0; i < docDataStore.getCount(); i++) {
			docData = docDataStore.getAt(i);
			field = form.findField(docData.get('BOOKMARK_'));
			if (field != null) {
				field.setValue(docData.get('VALUE_'));
			}
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

	function _updateDocData() {//修改
		var VALUE_LIST = new Array();
		var fields = Ext.getCmp('docDataFormPanel').getForm().getFields();
		for (var i = 1; i < fields.getCount(); i++) {
			VALUE_LIST.push(fields.getAt(i).getValue());
		}

		var BOOK_MARK_LIST = new Array();
		var DATA_TYPE_LIST = new Array();
		var ORDER_LIST = new Array();
		for (var i = 0; i < templateBookmarkList.length; i++) {
			BOOK_MARK_LIST.push(templateBookmarkList[i].bookmark);
			DATA_TYPE_LIST.push(templateBookmarkList[i].dataType);
			ORDER_LIST.push(templateBookmarkList[i].order);
		}

		var url = 'updateDocData.do';
		Ext.Ajax.request({
			url : url,
			async : false,
			params : {
				'DOC_ID_' : DOC_ID_,
				'BOOK_MARK_LIST' : BOOK_MARK_LIST,
				'VALUE_LIST' : VALUE_LIST,
				'DATA_TYPE_LIST' : DATA_TYPE_LIST,
				'ORDER_LIST' : ORDER_LIST
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {//更新页面数据
						parent._afterUpdateDocData();

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

	function _uploadDocFile() {
		var form = Ext.getCmp('pdfPanel').getForm();
		if (form.findField('DOC_FILE_').getValue() == null || form.findField('DOC_FILE_').getValue() == '') {
			Ext.MessageBox.alert('<spring:message code="error" />', '请选择要上传的文档文件', Ext.MessageBox.ERROR);
			return;
		}

		var url = 'updateDocFile.do';
		form.submit({//提交表单
			url : url,
			submitEmptyText : false,
			waitMsg : '<spring:message code="processing" />',
			success : function(form, action) {
				Toast.alert('<spring:message code="info" />', '<spring:message code="success" />', 1000);

				_loadPdfDocFile();
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

	function _downloadDocTemplateFile() {
		location.href = 'loadDocTemplateFile.do?DOC_ID_=' + DOC_ID_;
	}

	function _downloadDocFile() {//下载
		location.href = 'loadDocFile.do?DOC_ID_=' + DOC_ID_ + '&readOnly=false';
	}

	function _viewDocFile() {
		var url = 'office://word$open$' + document.getElementById('base').href + 'loadDocFile.do;jsessionid=' + sessionId + '?DOC_ID_=' + DOC_ID_
		window.open(url);
	}
</script>
</head>
<body>
</body>
</html>