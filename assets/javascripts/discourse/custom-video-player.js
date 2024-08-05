import { withPluginApi } from 'discourse/lib/plugin-api';
import { ajax } from 'discourse/lib/ajax';

export default {
  name: 'custom-video-player',
  initialize() {
    withPluginApi('0.8', api => {
      api.modifyClass('component:onebox', {
        default: {
          // Override the default `to_html` method to include custom logic
          didInsertElement() {
            this._super(...arguments);
            
            const videoElements = document.querySelectorAll('.video-js');

            videoElements.forEach(videoElement => {
              // Initialize VideoJS for custom player
              if (videoElement) {
                const player = videojs(videoElement); // Initialize Video.js
                player.ready(function() {
                  console.log("Player is ready!");
                });
              }
            });
          }
        }
      });
    });
  }
};
