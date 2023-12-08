Ext.Ajax.on('requestcomplete', function(conn, response, options) {
	try {
		var data;
		if (!Ext.isEmpty(response.responseText)) {
			data = Ext.decode(response.responseText);
		} else {
			data = response.responseJson;
		}

		if (data != null && data.success == false) {
			Ext.MessageBox.alert('error', data.message, Ext.MessageBox.ERROR);
		}
	} catch (e) {
	}
});