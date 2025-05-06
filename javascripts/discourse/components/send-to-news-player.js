import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";

export default class SendToNewsPlayer extends Component {
  @service currentUser;

  get desktopEmbedCode() {
    const isMobile = /Mobi|Android/i.test(window.navigator.userAgent);
    const embedCode = isMobile
      ? settings.mobile_embed_code
      : settings.desktop_embed_code;
    return embedCode;
  }

  @action
  setupPlayer(element) {
    // Create script element dynamically
    const script = document.createElement("script");
    const isMobile = /Mobi|Android/i.test(window.navigator.userAgent);
    const embedCode = isMobile
      ? settings.mobile_embed_code
      : settings.desktop_embed_code;

    const exemptGroups = settings.exempt_groups
      .split(",")
      .map((group) => group.trim());
    const userGroups = this.currentUser.groups.map((g) => g.name);
    const isExempt = exemptGroups.some((group) => userGroups.includes(group));

    if (isExempt) {
      return;
    }
    script.src = `https://embed.sendtonews.com/player3/embedcode.js?fk=${embedCode}`;
    script.async = true;
    element.appendChild(script);
  }
}
