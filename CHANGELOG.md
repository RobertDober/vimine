# v 1.2.1  2020-12-25
this is a merge release for features developped parallelly

- rust snippets
- more crystal keywords for cccompletion

# v 1.2.0  2020-12-25

- split string into chars
- iteration now possible on strings too (just made foldl _polymorphic_)
- elixr test file completions → active_support.camelize

# v 1.1.2  2020-12-21

- cccompletion for crystal added


# v 1.1.1  2020-12-18

- fixes #1 and #4

- implements #2 (negative slice indicies)
- implements #3 (elixir cccompletion for doc and moduledoc)
- implements #5 (general cccompletor for `%date` use case, see above ;) )

# v 1.1.0  2020-12-17

- fn.curry_at
- fn.curry_kwd
- fn.merge (many tables)

- general cccompletion (for all filetypes)
- 100% test coverage with all vim API calls speced
- refactoring of API access into one place
- stubbing API access in specs

# v 1.0.1 2020-12-15

- @spec completion for elixir

# v 1.0.0 2020-12-14

- RotateAround (only for current line)

# 2020-11-20
Now on Lua instead of Ruby in the wo_ruby branch
Releases on this branch will be made with release tags of the form v1.x.y
