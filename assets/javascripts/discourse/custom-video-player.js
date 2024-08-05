import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  name: "custom-video-player",
  initialize() {
    withPluginApi("0.8", (api) => {
      api.onPageChange(() => {
        setTimeout(() => {
          const domList = document.querySelectorAll(".video-js");
          console.log(domList, "==domList");
          domList.forEach((ele, i) => {
            const videoElement = domList[i];
            const player = videojs(videoElement); // Initialize Video.js
            player.ready(function () {
              console.log("Player is ready!");
            });
          });
        }, 200);
      });
    });
  },
};
