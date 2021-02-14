# v1.2.6  2021-??-??

- selection completion (imap ,,,) 

# v1.2.5  2021-02-14

- rubocop
- file name navigation
- minor enhancements

# v1.2.4  2021-01-09

- selection tools inside `context.lua` 
- V command → `selection_command.lua`
- general completions (ft unrelated) for `%datetimez` (zoned)

# v1.2.3  2021-01-08

- new tool functors
- list tool tail_from
- module completion with name generated for elixir (active_support tool)
- rust cccompletion
- iex -S mix test completion for elixir tests "&ti" 
- fn.flat_map

# v1.2.2  2021-01-04

- create secure passwords with  `mk_secure_passwords`, command L42MkSecurePassword
- copy selection to clipboard

- elixir cccompletion test coverage back to 100%

# v1.2.1  2020-12-25
this is a merge release for features developped parallelly

- rust snippets
- more crystal keywords for cccompletion

# v1.2.0  2020-12-25

- split string into chars
- iteration now possible on strings too (just made foldl _polymorphic_)
- elixr test file completions → active_support.camelize

# v1.1.2  2020-12-21

- cccompletion for crystal added


# v1.1.1  2020-12-18

- fixes #1 and #4

- implements #2 (negative slice indicies)
- implements #3 (elixir cccompletion for doc and moduledoc)
- implements #5 (general cccompletor for `%date` use case, see above ;) )

# v1.1.0  2020-12-17

- fn.curry_at
- fn.curry_kwd
- fn.merge (many tables)

- general cccompletion (for all filetypes)
- 100% test coverage with all vim API calls speced
- refactoring of API access into one place
- stubbing API access in specs

# v1.0.1 2020-12-15

- @spec completion for elixir

# v1.0.0 2020-12-14

- RotateAround (only for current line)

# v1.0.0-dev 2020-11-20
Now on Lua instead of Ruby in the wo_ruby branch
Releases on this branch will be made with release tags of the form v1.x.y
