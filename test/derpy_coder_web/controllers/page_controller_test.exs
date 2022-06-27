defmodule DerpyCoderWeb.PageControllerTest do
  use DerpyCoderWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Hello from DerpyCoder!"
  end
end
