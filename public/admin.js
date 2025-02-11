'use strict';

define('admin/plugins/talksimlish', ['settings'], function (Settings) {
	var ACP = {};

	ACP.init = function () {
		Settings.load('talksimlish', $('.talksimlish-settings'));

		$('#save').on('click', function () {
			Settings.save('talksimlish', $('.talksimlish-settings'));
		});
	};

	return ACP;
});
