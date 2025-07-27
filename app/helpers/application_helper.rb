# app/helpers/application_helper.rb
module ApplicationHelper
  def markdown(text)
    options = {
      filter_html:     true, # Filter HTML tags to prevent XSS
      hard_wrap:       true, # Render newlines as <br>
      link_attributes: { rel: 'nofollow', target: "_blank" }, # Add rel and target to links
      space_after_headers: true, # Add space after # for headers
      fenced_code_blocks: true # Support GitHub-style code blocks
    }

    extensions = {
      autolink:           true, # Convert URLs to links
      superscript:        true, # Support superscript (e.g. 2^nd)
      disable_indented_code_blocks: true # Disable legacy indented code blocks
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    # Use html_safe to mark the output as safe HTML. Rails will then render it as HTML.
    markdown.render(text.to_s).html_safe
  end
end
