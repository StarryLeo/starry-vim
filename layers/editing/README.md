# [Undotree]

If you undo changes and then make a new change, in most editors the changes you undid are gone forever, as their undo-history is a simple list.
Since version 7.0 vim uses an undo-tree instead. If you make a new change after undoing changes, a new branch is created in that tree.
Combined with persistent undo, this is nearly as flexible and safe as git ;-)

Undotree makes that feature more accessible by creating a visual representation of said undo-tree.

**QuickStart** Launch using `<Leader>u`.

# [Surround]

This plugin is a tool for dealing with pairs of "surroundings."  Examples
of surroundings include parentheses, quotes, and HTML tags.  They are
closely related to what Vim refers to as text-objects.  Provided
are mappings to allow for removing, changing, and adding surroundings.

Details follow on the exact semantics, but first, consider the following
examples.  An asterisk (*) is used to denote the cursor position.

      Old text                  Command     New text ~
      "Hello *world!"           ds"         Hello world!
      [123+4*56]/2              cs])        (123+456)/2
      "Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
      if *x>3 {                 ysW(        if ( x>3 ) {
      my $str = *whee!;         vllllS'     my $str = 'whee!';

For instance, if the cursor was inside `"foo bar"`, you could type
`cs"'` to convert the text to `'foo bar'`.

There's a lot more, check it out at `:help surround`

# [EasyMotion]

EasyMotion provides an interactive way to use motions in Vim.

It quickly maps each possible jump destination to a key allowing very fast and
straightforward movement.

**QuickStart** EasyMotion is triggered using the normal movements, but prefixing them with `<Leader><Leader>`

For example this screen shot demonstrates pressing `,,w`

# [TextObj-User]

TextObj-User make it easier to create your own text objects.

There are many text objects written with TextObj-User, see the [list](https://github.com/kana/vim-textobj-user/wiki).

starry-vim includes:

* [vim-textobj-indent]: Text objects for indented blocks of lines.
* [vim-textobj-entire]: Text objects for entire buffer.
* [vim-textobj-comment]: Text objects for comments.


[Undotree]: https://github.com/mbbill/undotree
[Surround]: https://github.com/tpope/vim-surround
[EasyMotion]: https://github.com/easymotion/vim-easymotion
[TextObj-User]: https://github.com/kana/vim-textobj-user
[vim-textobj-indent]: https://github.com/kana/vim-textobj-indent
[vim-textobj-entire]: https://github.com/kana/vim-textobj-entire
[vim-textobj-comment]: https://github.com/glts/vim-textobj-comment

