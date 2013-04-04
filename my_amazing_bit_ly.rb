require 'sinatra'

set :urls, {
  :xyz => "http://www.generalassemb.ly"
}

get '/:short_url' do
  full_url = settings.urls[params[:short_url].to_sym]
  if full_url
    redirect full_url
  else
    404
  end
end