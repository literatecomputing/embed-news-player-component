import { hbs } from "ember-cli-htmlbars";
import { apiInitializer } from "discourse/lib/api";
import { registerWidgetShim } from "discourse/widgets/render-glimmer";
import DiscourseURL from "discourse/lib/url";

export default apiInitializer((api) => {
  registerWidgetShim(
    "send-to-news-player",
    "div.send-to-news-player",
    hbs`<SendToNewsPlayer />`
  );

  api.decorateWidget("post:before", (helper) => {
    const url = DiscourseURL.router.currentURL;
    const topicId = url.startsWith("/t/") ? url.split("/").slice(1)[3] : null;
    const postNumber =
      url.startsWith("/t/") && url.split("/").slice(4)[0]
        ? url.split("/").slice(4)[0]
        : 2;
    console.log("decorate", helper, helper.widget.model.post_number);
    if (helper.widget.model.post_number === postNumber) {
      return helper.attach("send-to-news-player");
    }
  });
  // api.onPageChange((url) => {
  //   // get topic and post id from url if url starts with /t/
  //   const topicId = url.startsWith("/t/") ? url.split("/").slice(1)[3] : null;
  //   const postNumber =
  //     url.startsWith("/t/") && url.split("/").slice(4)[0]
  //       ? url.split("/").slice(4)[0]
  //       : 2;
  //   console.log("page change post number", postNumber);
  // });

  // api.renderInOutlet("topic-map-expanded-after", SendToNewsPlayer, { desktopEmbedCode: settings.desktop_embed_code, mobileEmbedCode: settings.mobile_embed_code });
});
