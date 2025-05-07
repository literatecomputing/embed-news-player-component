import { hbs } from "ember-cli-htmlbars";
import { apiInitializer } from "discourse/lib/api";
import DiscourseURL from "discourse/lib/url";
import { registerWidgetShim } from "discourse/widgets/render-glimmer";

export default apiInitializer((api) => {
  registerWidgetShim(
    "send-to-news-player",
    "div.send-to-news-player",
    hbs`<SendToNewsPlayer />`
  );

  api.decorateWidget("post:before", (helper) => {
    const url = DiscourseURL.router.currentURL;
    const postNumber =
      url.startsWith("/t/") && url.split("/").slice(4)[0]
        ? url.split("/").slice(4)[0]
        : 2;
    if (
      parseInt(helper.widget.model.post_number, 10) === parseInt(postNumber, 10)
    ) {
      return helper.attach("send-to-news-player");
    }
  });
});
