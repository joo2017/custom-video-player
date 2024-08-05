# frozen_string_literal: true

# name: custom-video-player
# about: Adds support for custom Video.js player and m3u8 files
# version: 0.1
# authors: Your Name
# url: https://github.com/your-repo/custom-video-player

enabled_site_setting :custom_video_player_enabled

after_initialize do
  # Load custom JavaScript
  Discourse::Application.routes.append do
    mount ::CustomVideoPlayer::Engine, at: "/custom_video_player"
  end
end

# Register custom assets
register_asset "javascripts/discourse/custom-video-player.js"
