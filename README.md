yakstack
========

<img src="http://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Bos_grunniens_at_Letdar_on_Annapurna_Circuit.jpg/320px-Bos_grunniens_at_Letdar_on_Annapurna_Circuit.jpg" />

Do you find yourself sometimes going down a rabbit hole and forgetting how you got there? Every time you feel a subtask coming on, just `yak push` it on the stack.

Usage
-----

```shell
yak [push <message>|pop|peek] - store brief TODOs so you don't forget
```

### push

Add messages to the stack:

```shell
$ yak push update the README for yakstack
$ yak push read more about docker and vagrant
$ yak push read about the lens package
```

### pop

Use pop to quickly return (and remove) the top item in the stack, this was the thing you were most recently working on.

```shell
$ yak pop
read about the lens package
```

### peek

Shows the whole stack:

```shell
$ yak peek
read more about docker and vagrant
update the README for yakstack
```

## Info

`yak` stores messages in a [datastore](http://hackage.haskell.org/package/acid-state) found in the `.yak/` directory
