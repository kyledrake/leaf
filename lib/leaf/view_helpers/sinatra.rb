require 'leaf/view_helpers/base'
require 'leaf/view_helpers/link_renderer'
require 'leaf/view_helpers/list_renderer'

Leaf::ViewHelpers::LinkRenderer.class_eval do
  protected
  def url(page)
    url = @template.request.url
    url = @template.request.url.sub(/:\d+/, '') unless ENV['RACK_ENV'] =~ /dev$/
    
    if page == 1
      # strip out page param and trailing ? and & if they exists
      url.gsub(/(\?|\&)#{@options[:param_name]}=[0-9]+/, '').gsub(/\?$/, '').gsub(/\&$/, '')
    else
      if url =~ /(\?|\&)#{@options[:param_name]}=[0-9]+/
        url.gsub(/#{@options[:param_name]}=[0-9]+/, "#{@options[:param_name]}=#{page}").gsub(/\&+/, '&')
      else
        (url =~ /\?/) ? url + "&#{@options[:param_name]}=#{page}" : url + "?#{@options[:param_name]}=#{page}"
      end
    end
  end
end
