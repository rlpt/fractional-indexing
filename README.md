# Elm fractional indexing

Elm port of https://github.com/rocicorp/fractional-indexing

Not a complete port as it only supports base62, where as original js supports other bases

# What is fractional indexing?

Fractional indexing is a method to keep a list ordered by assigning fractional values to list positions. When inserting an element, a new index is created by averaging the surrounding indices, avoiding the need to reindex the entire list. 

The value for an index is base62 encoded. 

# Usage

`generateKeyBetween`

Generate a single key in between two points

`generateNKeysBetween`

Use this when generating multiple keys at some known position, as it spaces out indexes more evenly and leads to shorter keys.
