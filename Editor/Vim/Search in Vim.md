Tags: #consume 

### Basic search functionalities

1. Forward search: `/` (after the cursor) - Backward search: `?` (before the cursor)
2. Navigate matches with `n` (next match) and `N` (previous match)

### Whole word search

Use `\b` and wrap the word inside `\<word\>`

### Search and Replace

Use `:%s/old/new/g`:
- `%s` applies to the **whole file**
- `g` to replace **every occurrence** in each line

**QUICK AND DIRTY?**: To search for a word, put the word under the cursor and use `*` (forward) or `#` (backward)

