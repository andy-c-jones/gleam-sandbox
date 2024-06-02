import gleam/http.{Get, Post}
import gleam/string_builder
import sandbox/user
import sandbox/web
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack for this request/response.
  use _req <- web.middleware(req)

  case wisp.path_segments(req) {
    [] -> home_page(req)
    ["users"] -> users(req)
    ["users", id] -> get_user(req, id)
    _ -> wisp.not_found()
  }
}

fn home_page(req: Request) -> Response {
  use <- wisp.require_method(req, Get)

  let html = string_builder.from_string("Hello, Joe!")
  wisp.ok()
  |> wisp.html_body(html)
}

fn users(req: Request) -> Response {
  case req.method {
    Get -> list_users()
    Post -> create_users(req)
    _ -> wisp.method_not_allowed([Get, Post])
  }
}

fn list_users() -> Response {
  let users = [user.User(1, "alice"), user.User(2, "bob")]
  let body = string_builder.from_string(user.user_list_to_json_string(users))

  wisp.ok()
  |> wisp.json_body(body)
}

fn create_users(_req: Request) -> Response {
  let html = string_builder.from_string("Created")
  wisp.created()
  |> wisp.html_body(html)
}

fn get_user(req: Request, id: String) -> Response {
  use <- wisp.require_method(req, Get)

  let html = string_builder.from_string("User with id " <> id)
  wisp.ok()
  |> wisp.html_body(html)
}
