import gleeunit
import gleeunit/should
import sandbox/router
import wisp/testing

pub fn main() {
  gleeunit.main()
}

pub fn hello_world_test() {
  let response = router.handle_request(testing.get("/", []))

  response.status
  |> should.equal(200)

  response.headers
  |> should.equal([#("content-type", "text/html")])

  response
  |> testing.string_body
  |> should.equal("Hello, Joe!")
}

pub fn get_user_test() {
  let response = router.handle_request(testing.get("/users/1", []))

  response.status
  |> should.equal(200)

  response.headers
  |> should.equal([#("content-type", "text/html")])

  response
  |> testing.string_body
  |> should.equal("User with id 1")
}

pub fn get_users_test() {
  let response = router.handle_request(testing.get("/users", []))

  response.status
  |> should.equal(200)

  response.headers
  |> should.equal([#("content-type", "application/json")])

  response
  |> testing.string_body
  |> should.equal(
    "{\"users\":[{\"id\":1,\"name\":\"alice\"},{\"id\":2,\"name\":\"bob\"}]}",
  )
}
