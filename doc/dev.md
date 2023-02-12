# cr in Ruby development

## Develop

Ref: https://github.com/ruby/typeprof/blob/master/doc/doc.md

```PowerShell
typeprof -I .\lib .\bin\cr    -o sig\bin\cr.rbs

typeprof -I .\lib .\lib\cr.rb -o sig\lib\cr.rbs
```

<br>

## Test and build

Maybe you need `sudo` access

- `rake gen_output`
- `rake test`
- `rake release`
- `gh release create`

OR

- `gem build cr.rb`
- `gem install ./cr.rb-4.x.x.gem -l`
- `gem uninstall cr.rb`
- `gem update cr.rb (--pre)`
- `gem push cr.rb-4.x.x.gem`
