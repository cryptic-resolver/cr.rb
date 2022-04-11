# Test

The file `basic.rb` is just an experiment when I introduce tests.

1. Run `rake gen_output` to generate `gen_output.txt` to quickly inspect expected results used in our test cases.

2. Write new tests

```ruby
def test_cmd
  result = cr("cmd")
  assert_equal(<<~EOC, result)
  EOC

  # Always write heredoc-end: EOC first, then copy 'gen_output.txt' to the middle
  # This way, your editor can help you handle the space automatically
end
```

3. Run `rake test`
