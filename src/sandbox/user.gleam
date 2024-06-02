import gleam/json.{type Json, array, int, object, string, to_string}

pub type User {
  User(id: Int, name: String)
}

pub fn user_to_json(user: User) -> Json {
  object([#("id", int(user.id)), #("name", string(user.name))])
}

pub fn user_list_to_json_string(users: List(User)) -> String {
  object([#("users", array(users, of: user_to_json))])
  |> to_string
}
