# Bowlarama

Bowling scores for awesome bowlers.

> This is the Elixir version of [Bowlarama](https://github.com/cesc1989/bowlarama/)

## Rules

See [project rules](./project_rules.md)

## Debugging in iex

Load Elixir interactive console with the application modules

```elixir
$ iex -S mix 
```

Run project in iex console:

```
 iex(1)> Bowlarama.score_sheet('./fixtures/scores.txt')

 iex(1)> Bowlarama.score_sheet('./fixtures/scores_normal.txt')

 iex(1)> Bowlarama.score_sheet('./fixtures/scores_with_foul.txt')

 iex(1)> Bowlarama.score_sheet('./fixtures/scores_invalid.txt')
```

After doing code changes, reload in console with `recompile` instruction.
