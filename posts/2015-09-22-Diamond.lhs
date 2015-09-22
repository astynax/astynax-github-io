---
title: Diamond.lhs
description: Solution of the Diamond Kata in Haskell
tags: haskell,kata,quiz
---

Solution of the Diamond Kata in Haskell.
===

As the [Diamond Kata](http://claysnow.co.uk/recycling-tests-in-tdd/) requires,
our program must print the diamond-shaped figure which contains letters
in range from the letter ``'A'`` to some letter ``X``.

This post contains *only the solution* of problem but not the tests,
i.e. this is *not the Kata exercise* in the common sense.

For the ``'D'`` the result of printing should look like this:

<    A
<   B B
<  C   C
< D     D
<  C   C
<   B B
<    A

Our program will print the large "diamond" for the ``'Z'`` letter:

> module Diamond where
>
> main = mapM_ putStrLn $ diamond 'Z'

Because of double symmetricity of the shape of diamond we need to "draw"
the edge only once and then mirror it for two times:

> diamond = mirror . map mirror . edge

Mirroring function is pretty simple:

> mirror = mirr []
>   where
>     mirr acc []     = tail acc
>     mirr acc (x:xs) = x : mirr (x : acc) xs

That function works as expected:

< mirror "abcD" → "abcDcba"

Now when we can mirror "figures" in our "geometry" we need a function
for drawing the edge:

> edge c = map (pad c) ['A'..c]

And now the last thing we need is the function which
can "draw" some letter at proper position:

> pad b a
>   | b == 'A'  = [a]
>   | otherwise =
>     let b' = pred b
>     in  if a == b
>         then a   : pad b' ' '
>         else ' ' : pad b' a

A couple of examples:

< pad 'A' 'A' → "A"
< pad 'C' 'A' → "  A"
< pad 'C' 'B' → " B "
< pad 'C' 'C' → "C  "

That's all! Try it! Just ``runghc``' this file :)
