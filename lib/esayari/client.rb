module Esayari
  class Client
    def initialize(token)
      endpoint = 'https://api.esa.io'

      url = URI.parse(endpoint)
      @http = Net::HTTP.new(url.host, url.port)
      @http.use_ssl = true
      @headers = {
        "Content-Type"  => "application/json",
        "Authorization" => "Bearer #{token}",
      }
    end

    # https://docs.esa.io/posts/102#POST%20/v1/teams/:team_name/posts
    def create_post(team_path, name, body, tags, category, wip: true)
      path = "/v1/teams/#{team_path}/posts"

      params = {
        post: {
          name: name,
          body_md: body,
          tags: tags,
          category: category,
          wip: wip,
        }
      }

      @http.post(path, JSON.generate(params), @headers)
    end

    # create_postとほぼ一緒だが、仕様でnameがrequireじゃなくなるっぽかったので、
    # コード上で分岐させられるけど明示的にメソッドを分けてしまった。
    def create_post_with_template(team_path, tags, category, template_post_id: nil, wip: true)
      path = "/v1/teams/#{team_path}/posts"

      params = {
        post: {
          tags: tags,
          category: category,
          template_post_id: template_post_id,
          wip: wip,
        }
      }

      @http.post(path, JSON.generate(params), @headers)
    end
  end
end
