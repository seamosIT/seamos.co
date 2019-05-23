module PollsHelper
  def set_metas
    set_meta_tags og: {
      title: @poll.title,
      url: request.url,
      image: {
        _: @poll.poll_image,
        width: 600,
        height: 600
      },
      description: @poll.summary,
      type: "article",
      site_name: "seamOS Bueanaventura"
    }

    set_meta_tags article: {
      published_time:    @poll.created_at,
      section:           @poll.tags.first.name,
      tag:               @poll.tags.first.name,
    }

    set_meta_tags twitter: {
      card:  "summary_large_image",
      site:  "@seamos",
      title:  @poll.title,
      description: @poll.summary ? @poll.summary.first(199) : nil,
      creator: "@seamos",
      image: {
        _:      @poll.poll_image,
        width:  100,
        height: 100,
      }
    }
  end
end
