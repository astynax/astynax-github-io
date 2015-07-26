---
title: Counters: React powered
tags: clojure,clojurescript,react
description: Проба пера на ниве client-side разработки с использованием ClJS+React
---

## Counters: React powered

Прочитал сегодня отличную статью ["ClojureScript: how to begin"](http://solovyov.net/en/2014/cljs-start/)
от [Александра Соловьёва](https://twitter.com/asolovyov). При том, что я
[ClJS](https://github.com/clojure/clojurescript) уже использую какое-то время
да и на [React](https://facebook.github.io/react/) посматриваю (точнее на его
обёртку - [Quescent](https://github.com/levand/quiescent)), статья натолкнула
попробовать это всё в связке с [figwheel](https://github.com/bhauman/lein-figwheel)
- расширением для **lein**, позволяющим обновлять код в браузере инкрементально,
прямо после успешной его сборки. Сама концепция такой "живой" разработки
очень для меня привлекательна, а в связке с реактом ещё и визуальная
составляющая отлично "живёт" без обновления страницы!

Получилась у меня <a href="../reactbox.html" target="_blank">следующая страничка</a>.
Впечатления от эксперимента сугубо положительные! Осталось придумать,
как callback'и от элементов "более реативно" реализовать ;)

И да, [исходники эксперимента](https://bitbucket.org/astynax/cljs-react-counters) ;)

