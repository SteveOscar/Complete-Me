# Complete Me
## Autocomplete utilizing N-ary Trie data structure
## Turing Module 1: Project 4 (Echo)

### Overview

Complete Me is an example of an auto-complete text suggestion system, as is commonly seen on mobile phones. It utilizes a [Trie data structure](https://en.wikipedia.org/wiki/Trie) which stores words as a branching tree of letters. Suggestions can also be weighted so the program will suggest more commonly used words. Each node in the tree is equal, and data is loaded and retrieved recursively.

The words in the database of the Complete Me can be loaded individually, or mass-populated. The program was tested with the native dictionary on OS X, wich contains ~ 240,000 words. The Trie is dynamically created each time the program is run and the tree is populated.

### Methods:

* __insert(word)__ - used to indiviually insert words into the trie.
* __populate(list)__ - used for mass insertion of large word lists into the tree.
* __suggest(string)__ - generates an array of suggested words for the given substring. All potential matches in the database are displayed.
* __count__ - recursively determines the number of words in the Trie.
* __select(substring, string)__ - allows the user to weight the suggestion of specified words with the desired substring. Another version of the program does this more dynamically, automatically weighting suggestions that are used.
