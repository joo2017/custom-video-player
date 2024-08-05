# frozen_string_literal: true

# name: custom-video-player
# about: Adds support for custom Video.js player and m3u8 files
# version: 0.1
# authors: Your Name
# url: https://github.com/your-repo/custom-video-player

enabled_site_setting :custom_video_player_enabled

after_initialize do
  require_dependency 'onebox/engine/video_onebox'

  module ::Onebox
    module Engine
      class VideoOnebox
        include Engine
        matches_regexp(%r{^(https?:)?//.*\.(mov|mp4|webm|ogv|m3u8)(\?.*)?$}i)

        def always_https?
          AllowlistedGenericOnebox.host_matches(uri, AllowlistedGenericOnebox.https_hosts)
        end

        def to_html
          if @url.match(%r{\.m3u8$})
            random_id = "video_#{SecureRandom.hex(8)}"
            video_tag_html = <<-HTML
              <div class="onebox video-onebox videoWrap">
                <video id='#{random_id}' class="video-js vjs-default-skin vjs-16-9" controls preload="auto" width="100%" data-setup='{"fluid": true}'>
                  <source src="#{@url}" type="application/x-mpegURL">
                </video>
              </div>
            HTML
          else
            escaped_url = ::Onebox::Helpers.normalize_url_for_output(@url)
            video_tag_html = <<-HTML
              <div class="onebox video-onebox">
                <video width='100%' height='100%' controls #{@options[:disable_media_download_controls] ? 'controlslist="nodownload"' : ""}>
                  <source src='#{escaped_url}'>
                  <a href='#{escaped_url}'>#{@url}</a>
                </video>
              </div>
            HTML
          end
          video_tag_html
        end

        def placeholder_html
          SiteSetting.enable_diffhtml_preview ? to_html : ::Onebox::Helpers.video_placeholder_html
        end
      end
    end
  end

  # Register custom assets
  register_asset "javascripts/discourse/custom-video-player.js"
end
