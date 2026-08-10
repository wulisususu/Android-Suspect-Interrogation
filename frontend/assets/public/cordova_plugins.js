
  cordova.define('cordova/plugin_list', function(require, exports, module) {
    module.exports = [
      {
          "id": "cordova-plugin-ble-peripheral.blePeripheral",
          "file": "plugins/cordova-plugin-ble-peripheral/www/blePeripheral.js",
          "pluginId": "cordova-plugin-ble-peripheral",
        "clobbers": [
          "blePeripheral"
        ]
        },
      {
          "id": "cordova-plugin-app-version.AppVersionPlugin",
          "file": "plugins/cordova-plugin-app-version/www/AppVersionPlugin.js",
          "pluginId": "cordova-plugin-app-version",
        "clobbers": [
          "cordova.getAppVersion"
        ]
        },
      {
          "id": "cordova-plugin-inappbrowser.inappbrowser",
          "file": "plugins/cordova-plugin-inappbrowser/www/inappbrowser.js",
          "pluginId": "cordova-plugin-inappbrowser",
        "clobbers": [
          "cordova.InAppBrowser.open"
        ]
        },
      {
          "id": "cordova-plugin-android-permissions.Permissions",
          "file": "plugins/cordova-plugin-android-permissions/www/permissions.js",
          "pluginId": "cordova-plugin-android-permissions",
        "clobbers": [
          "cordova.plugins.permissions"
        ]
        },
      {
          "id": "com-darryncampbell-cordova-plugin-intent.IntentShim",
          "file": "plugins/com-darryncampbell-cordova-plugin-intent/www/IntentShim.js",
          "pluginId": "com-darryncampbell-cordova-plugin-intent",
        "clobbers": [
          "intentShim"
        ]
        },
      {
          "id": "com-sarriaroman-photoviewer.PhotoViewer",
          "file": "plugins/com-sarriaroman-photoviewer/www/PhotoViewer.js",
          "pluginId": "com-sarriaroman-photoviewer",
        "clobbers": [
          "PhotoViewer"
        ]
        }
    ];
    module.exports.metadata =
    // TOP OF METADATA
    {
      "com-darryncampbell-cordova-plugin-intent": "2.2.0",
      "com-sarriaroman-photoviewer": "1.3.0",
      "cordova-plugin-android-permissions": "1.1.5",
      "cordova-plugin-app-version": "0.1.14",
      "cordova-plugin-ble-peripheral": "1.0.0",
      "cordova-plugin-inappbrowser": "5.0.0"
    };
    // BOTTOM OF METADATA
    });
    