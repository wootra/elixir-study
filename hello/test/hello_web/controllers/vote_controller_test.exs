defmodule HelloWeb.VoteControllerTest do
  use HelloWeb.ConnCase

  import Hello.ElectionFixtures

  @create_attrs %{count: 42, candidates: "some candidates"}
  @update_attrs %{count: 43, candidates: "some updated candidates"}
  @invalid_attrs %{count: nil, candidates: nil}

  describe "index" do
    test "lists all votes", %{conn: conn} do
      conn = get(conn, ~p"/votes")
      assert html_response(conn, 200) =~ "Listing Votes"
    end
  end

  describe "new vote" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/votes/new")
      assert html_response(conn, 200) =~ "New Vote"
    end
  end

  describe "create vote" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/votes", vote: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/votes/#{id}"

      conn = get(conn, ~p"/votes/#{id}")
      assert html_response(conn, 200) =~ "Vote #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/votes", vote: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Vote"
    end
  end

  describe "edit vote" do
    setup [:create_vote]

    test "renders form for editing chosen vote", %{conn: conn, vote: vote} do
      conn = get(conn, ~p"/votes/#{vote}/edit")
      assert html_response(conn, 200) =~ "Edit Vote"
    end
  end

  describe "update vote" do
    setup [:create_vote]

    test "redirects when data is valid", %{conn: conn, vote: vote} do
      conn = put(conn, ~p"/votes/#{vote}", vote: @update_attrs)
      assert redirected_to(conn) == ~p"/votes/#{vote}"

      conn = get(conn, ~p"/votes/#{vote}")
      assert html_response(conn, 200) =~ "some updated candidates"
    end

    test "renders errors when data is invalid", %{conn: conn, vote: vote} do
      conn = put(conn, ~p"/votes/#{vote}", vote: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Vote"
    end
  end

  describe "delete vote" do
    setup [:create_vote]

    test "deletes chosen vote", %{conn: conn, vote: vote} do
      conn = delete(conn, ~p"/votes/#{vote}")
      assert redirected_to(conn) == ~p"/votes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/votes/#{vote}")
      end
    end
  end

  defp create_vote(_) do
    vote = vote_fixture()
    %{vote: vote}
  end
end
