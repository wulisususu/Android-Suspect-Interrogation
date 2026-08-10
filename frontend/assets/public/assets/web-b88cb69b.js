import { W as WebPlugin } from "../index.js";
class NoTrouble extends WebPlugin {
  constructor() {
    super();
    window.screen.orientation.addEventListener("change", () => {
      const type = window.screen.orientation.type;
      this.notifyListeners("screenOrientationChange", {
        type
      });
    });
  }
  orientation() {
    return {
      type: window.screen.orientation.type
    };
  }
  getAppInfo() {
    return {
      version_name: "1.1.0",
      version_code: 1,
      platform: "web",
      aliyun_device_id: ""
    };
  }
  disableKeyboard() {
  }
}
export {
  NoTrouble
};
