# Spec

1. Write new specs

Add case in `representative_commands.md` and then insert it to `command_spec.rb`

```ruby
it "does something" do
    result = lookup 'gles'
    _(result).must_equal <<~RES
    From: cryptic_computer
    GLES redirects to OpenGL ES

      OpenGL ES: OpenGL for Embedded Systems

    RES
  # Notice: The space here is very easy to get wrong, try to adjust it!!
  #
  # Always write heredoc-end: RES first, then copy terminal output to the middle
  # This way, your editor can help you handle the space automatically
end
```

2. Run `rake spec`
