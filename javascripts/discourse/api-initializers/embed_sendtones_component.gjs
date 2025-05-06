import { hbs } from "ember-cli-htmlbars";
import { apiInitializer } from "discourse/lib/api";
import { registerWidgetShim } from "discourse/widgets/render-glimmer";

export default apiInitializer((api) => {
  // console.log("currentuser", this.currentUser);
  registerWidgetShim(
    "send-to-news-player",
    "div.send-to-news-player",
    hbs`<SendToNewsPlayer />`
  );
  api.decorateWidget("post:before", (helper) => {
    if (helper.widget.model.post_number === 2) {
      return helper.attach("send-to-news-player");
    }
  });
  // api.renderInOutlet("topic-map-expanded-after", SendToNewsPlayer, { desktopEmbedCode: settings.desktop_embed_code, mobileEmbedCode: settings.mobile_embed_code });
});
