Toast = function() {
	var toastContainer;

	function createMessageBar(title, msg) {
		return '<div class="x-message-box" style="border: solid 2px #0099ff; border-radius: 5px; box-shadow: 1px 1px 2px #7F7F7F; background-color: #FFFFC8"><div class="x-box-tl"><div class="x-box-tr"><div class="x-box-tc"></div></div></div><div class="x-box-ml"><div class="x-box-mr"><div class="x-box-mc"><div style="font: 12px Microsoft YaHei;">' + title + '</div><div style="width: 240px; height: 80px; display: table-cell; text-align: center; vertical-align: middle; font: 13px Microsoft YaHei;">' + msg + '</div></div></div></div><div class="x-box-bl"><div class="x-box-br"><div class="x-box-bc"></div></div></div></div>';
	}

	return {
		alert : function(title, msg, delay) {
			if (!toastContainer) {
				toastContainer = Ext.DomHelper.insertFirst(document.body, {
					id : 'toastContainer',
					style : 'position: absolute; right: 6px; bottom: 6px; z-index: 20000;'
				}, true);
			}

			var message = Ext.DomHelper.append(toastContainer, createMessageBar(title, msg), true);
			message.hide();
			message.slideIn('b').ghost("b", {
				delay : delay,
				remove : true
			});
		}
	};
}();