ExUnit.start()
ExUnit.after_suite(fn
  :ok ->
    IO.puts("test succeeded")
  %{total: t, failures: f, excluded: e, skipped: s} ->
    IO.puts("test results: #{t}, failures: #{f}, excluded: #{e}, skipped: #{s}")
  _ ->
    # IO.inspect(arg, [])
    IO.puts "After suite but failed"
end)
