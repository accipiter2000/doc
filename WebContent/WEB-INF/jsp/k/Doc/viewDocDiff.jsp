<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/jsp/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><spring:message code="view" /><spring:message code="DOC" /></title>
<link rel="stylesheet" type="text/css" href="css/ext-all.css" />
<link rel="stylesheet" type="text/css" href="css/ext-zh_CN.css" />
<script type="text/javascript" src="js/ext-all.js"></script>
<script type="text/javascript" src="js/ext-lang-zh_CN.js"></script>
<script type="text/javascript" src="js/toast.js"></script>
<script type="text/javascript" src="js/odUtils.js"></script>
<script>
	//获取url中的入参
	var DOC_ID_ = null;
	var VERSION_ = null;
	if (location.href.split('?')[1] != undefined) {
		var parameters = Ext.urlDecode(location.href.split('?')[1]);
		(parameters.DOC_ID_ != undefined) ? DOC_ID_ = parameters.DOC_ID_ : 0;
		(parameters.VERSION_ != undefined) ? VERSION_ = parameters.VERSION_ : 0;
	}

	var docDiff;//被修改对象

	Ext.onReady(function() {
		Ext.getBody().mask('<spring:message code="loading" />');//加载时页面遮盖

		Ext.Ajax.request({//加载被修改对象
			url : 'getDocDiff.do',
			async : false,//同步加载
			params : {
				'DOC_ID_' : DOC_ID_,
				'VERSION_' : VERSION_
			},
			callback : function(options, success, response) {
				if (success) {
					var data = Ext.decode(response.responseText);
					if (data.success) {
						docDiff = data.docDiff;
					}
				}
			}
		});

		var docDiffStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'docDiffStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : -1,
			fields : [ 'CURRENT_VERSION_', 'PREVIOUS_VERSION_' ]
		});

		var docRiderDiffStore = Ext.create('Ext.data.Store', {//表格数据
			storeId : 'docRiderDiffStore',
			autoLoad : false,//true为自动加载
			loading : false,//自动加载时必须为true
			pageSize : 20,
			fields : [ 'DOC_RIDER_HIS_ID_', 'DOC_RIDER_ID_', 'DOC_ID_', 'DOC_RIDER_FILE_NAME_', 'MD5_', 'VERSION_', 'OPERATION_' ]
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

		var docFileDiffPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'docFileDiffPanel',
			store : docDiffStore,
			title : '<spring:message code="DOC.DOC_FILE_" />差异',
			headerBorders : false,//是否显示表格竖线 
			columns : [ {
				text : '当前版本',
				dataIndex : 'CURRENT_VERSION_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '上一个版本',
				dataIndex : 'PREVIOUS_VERSION_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;">没有差异</div>',
				enableTextSelection : true
			},
			listeners : {
				'render' : function(gridPanel, eOpts) {
					var view = gridPanel.getView();
					var toolTip = Ext.create('Ext.tip.ToolTip', {
						target : gridPanel.getEl(),
						delegate : view.getCellSelector(),//单元格触发
						listeners : {
							beforeshow : function(sender, eOpts) { // 动态切换提示内容
								var dataIndex = view.getHeaderByCell(sender.triggerElement).dataIndex;
								if (dataIndex == 'CURRENT_VERSION_' || dataIndex == 'PREVIOUS_VERSION_') {
									toolTip.update(view.getRecord(sender.triggerElement).get(dataIndex));
								} else {
									return false;
								}
							}
						}
					});
				}
			}
		});

		var docRiderDiffPanel = Ext.create('Ext.grid.Panel', {//表格
			id : 'docRiderDiffPanel',
			store : docRiderDiffStore,
			title : '<spring:message code="DOC_RIDER" />差异',
			headerBorders : false,//是否显示表格竖线 
			columns : [ {
				text : '操作',
				dataIndex : 'OPERATION_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 1
			}, {
				text : '<spring:message code="DOC_RIDER.DOC_RIDER_FILE_NAME_" />',
				dataIndex : 'DOC_RIDER_FILE_NAME_',
				style : 'text-align: center; font-weight: bold;',
				align : 'center',
				flex : 3
			} ],
			viewConfig : {
				emptyText : '<div style="text-align: center; padding-top: 50px; font: italic bold 20px Microsoft YaHei;">没有差异</div>',
				enableTextSelection : true
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
				items : [ buttonPanel, ]
			}, {
				region : 'center',
				layout : 'fit',//充满
				items : [ docFileDiffPanel ]
			}, {
				region : 'south',
				layout : 'fit',//充满
				height : 200,
				items : [ docRiderDiffPanel ]
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

		_initDocFileDiff();
		_initDocRiderDiff();

		Ext.getBody().unmask();//取消页面遮盖
	}

	function _initDocFileDiff() {
		if (!docDiff.DOC_FILE_DIFF_) {
			return;
		}

		var docDiffStore = Ext.data.StoreManager.lookup('docDiffStore');//组装子代码数据，过滤注入。

		var ignoreLength = 30;

		var currentVersion = '';
		var previousVersion = '';
		var splits;
		var text;
		//按段落分割区别
		for (var i = 0; i < docDiff.DOC_FILE_DIFF_.length; i++) {
			//相同处理。
			if (docDiff.DOC_FILE_DIFF_[i].operation == 'EQUAL') {
				splits = docDiff.DOC_FILE_DIFF_[i].text.split('\n');//分段

				inner: for (var j = 0; j < splits.length; j++) {
					if (splits[j] == '' && currentVersion == '' && previousVersion == '') {//空段忽略
						continue inner;
					}

					if (currentVersion != '' || previousVersion != '') {//如果已有区别数据，添加相同部分，相同部分如果太长，忽略后面。
						text = splits[j];
						if (text.length > ignoreLength) {
							currentVersion = currentVersion + text.substring(0, ignoreLength) + '。。。。。。';
							previousVersion = previousVersion + text.substring(0, ignoreLength) + '。。。。。。';
						} else {
							currentVersion = currentVersion + text;
							previousVersion = previousVersion + text;
						}

						if (j < splits.length - 1) {//不是最后一个分段，添加区别并清空数据
							docDiffStore.add({
								'CURRENT_VERSION_' : currentVersion,
								'PREVIOUS_VERSION_' : previousVersion
							});
							currentVersion = '';
							previousVersion = '';
						}
					} else {//如果没有区别数据，忽略相同的分段，直接添加最后一个相同部分的分段。相同部分如果太长，忽略前面。
						if (j < splits.length - 1) {
							continue inner;
						}

						text = splits[j];
						if (text.length > ignoreLength) {
							currentVersion = '。。。。。。' + text.substring(ignoreLength);
							previousVersion = '。。。。。。' + text.substring(ignoreLength);
						} else {
							currentVersion = text;
							previousVersion = text;
						}
					}
				}
			} else if (docDiff.DOC_FILE_DIFF_[i].operation == 'DELETE') {
				splits = docDiff.DOC_FILE_DIFF_[i].text.split('\n');//分段

				inner: for (var j = 0; j < splits.length; j++) {
					if (splits[j] == '' && currentVersion == '' && previousVersion == '') {//空段忽略
						continue inner;
					}

					previousVersion += '<span style="color: red; text-decoration: line-through;">' + splits[j] + '</span>';

					if (j < splits.length - 1) {//不是最后一个分段，添加区别并清空数据
						docDiffStore.add({
							'CURRENT_VERSION_' : currentVersion,
							'PREVIOUS_VERSION_' : previousVersion
						});
						currentVersion = '';
						previousVersion = '';
					}
				}
			} else if (docDiff.DOC_FILE_DIFF_[i].operation == 'INSERT') {
				splits = docDiff.DOC_FILE_DIFF_[i].text.split('\n');//分段

				inner: for (var j = 0; j < splits.length; j++) {
					if (splits[j] == '' && currentVersion == '' && previousVersion == '') {//空段忽略
						continue inner;
					}

					currentVersion += '<span style="color: green;">' + splits[j] + '</span>';

					if (j < splits.length - 1) {//不是最后一个分段，添加区别并清空数据
						docDiffStore.add({
							'CURRENT_VERSION_' : currentVersion,
							'PREVIOUS_VERSION_' : previousVersion

						});
						currentVersion = '';
						previousVersion = '';
					}
				}
			}
		}
	}

	function _initDocRiderDiff() {
		if (!docDiff.DOC_RIDER_DIFF_) {
			return;
		}

		var docRiderDiffStore = Ext.data.StoreManager.lookup('docRiderDiffStore');//组装子代码数据，过滤注入。
		for (var i = 0; i < docDiff.DOC_RIDER_DIFF_.length; i++) {
			docRiderDiffStore.add(docDiff.DOC_RIDER_DIFF_[i]);
		}
	}

	function _close() {//关闭窗口
		parent.win.close();
	}
</script>
</head>
<body>
</body>
</html>