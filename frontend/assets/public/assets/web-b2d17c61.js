import { W as WebPlugin, _ } from "../index.js";
const screen_preview = "" + new URL("screen_preview-inquiry.jpg", import.meta.url).href;
const popupName = "doctor-assistant-secondary";
var hold_open = false;
setTimeout(() => {
  hold_open = false;
}, 3e4);
class MultiScreen extends WebPlugin {
  constructor() {
    super();
    window.addEventListener("message", (event) => {
      var {
        name,
        data
      } = _.isString(event.data) ? JSON.parse(event.data) : event.data;
      if (name) {
        console.log("收到页面消息:", event.data);
        this.notifyListeners(name, data);
      }
    });
  }
  postMessage(message) {
    var _a;
    (_a = this.popup) == null ? void 0 : _a.postMessage(message, "*");
  }
  open({
    url
  }) {
    if (hold_open) {
      throw new Error("副屏无法打开");
    }
    return window.getScreenDetails().then(({
      currentScreen,
      screens
    }) => {
      var target_screen = _.find(screens, (screen) => {
        return screen !== currentScreen;
      }) || currentScreen;
      this.terminate();
      this.popup = window.open(
        url,
        popupName,
        // 使用唯一 name
        `left=${target_screen.availLeft},
			top=${target_screen.availTop},
			width=${target_screen.availWidth},
			height=${target_screen.availHeight}`
      );
    });
  }
  terminate() {
    let popup = this.popup;
    if (!popup) {
      popup = window.open("", popupName);
    }
    if (popup) {
      popup.close();
      this.popup = null;
    }
  }
  getMjpegStreamUrl() {
    return {
      url: screen_preview
    };
  }
}
export {
  MultiScreen
};
