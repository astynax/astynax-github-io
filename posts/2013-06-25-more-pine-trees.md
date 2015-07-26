---
title: Ёлки, лес их :)
tags: python,dc,елочка
---

## Ёлки, лес их :)

На родном **Python**'е однострочная ёлочка:

```python
print (lambda n: '\n'.join((' ' * (n - x)) + ('*' * (x * 2 - 1)) for x in range(1, n + 1)))(10)
```

Экзотическая ёлка на [dc](https://www.gnu.org/software/bc/manual/dc-1.05/html_mono/dc.html) *(эдакий стековый калькулятор nix-овый)*:

```sh
dc -e "[32P1-d0!=b]sb[42P1-d0!=s]ss[lilbxln+li-2*1-lsx]sr[li1-silrx10Pli1!=m]sm 10 1+snlnsilmx"
```
