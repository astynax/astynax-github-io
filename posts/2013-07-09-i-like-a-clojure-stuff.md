---
title: Я люблю плюшки Clojure
tags: clojure
---

## Я люблю плюшки Clojure (№1)

Ну нравится мне **Clojure**, и всё тут!

Люблю я такие структуры данных:

```clojure
(def shapes
     [{:shape {:type :line
               :path [{:x 10 :y 10}
                      {:x 100 :y 100}]}
       :pen {:color "FF00FF"
             :style :solid}}

      {:shape {:type :dot
               :path [{:x 200 :y 200}]}
       :pen {:color :red}}])
```

Тут у нас список неких графических примитивов. У примитива есть форма ``:shape`` и перо ``:pen``, которым этот примитив отрисовывается. Форма имеет тип и описание траектории пера, и т.д. Всё достаточно наглядно и просто!

Очень удобны кложуровские ``:keywords``, означающие просто сами себя (ну прямо *атомы* **erlang**овские!). В других языках так их не хватает порой :(

С данными в Сlojure очень удобно работать. Попробуем (в *REPL*):

```clojure
=> (def point {:x 100 :y 150}) ; словарь
=> point
{:x 100 :y 150}

=> (def nums [1 2 3]) ; вектор
=> nums
[10 20 30]

=> (def primes #{1 3 5 7 11}) ; множество (set)
=> primes
#{1 3 5 7 11}
```

Извлекать элементы из словарей и векторов можно так:

```clojure
=> (get point :x) ; всё как обычно
100
=> (get point :z) ; нет ключа - будет nil
nil
=> (get point :z 0) ; даже default есть
0
=> (get nums 1) ; у вектора ключ, это позиция элемента
20
```

Но так можно и в Python, а в Clojure можно и по-вкуснее:

```clojure
=> (point :x) ; словарь, это функция от ключей!
100
=> (point :z 0)
0
=> (num 0) ; вектор, это функция от позиции!
10
=> (primes 7)
7
=> (primes 6)
nil ; 6 не входит в набор!

=> (def yes? #{"Y" "y" "Д" "д"})
=> (if (yes? input) ...) ; множество, как предикат!
```

Дальше-больше!

```clojure
=> (:x point) ; keywords - функции для словарей!
100
=> (:z point -1)
-1
```

Ну а раз у нас столько клёвых функций, мы можем их использовать в ФВП (функциях высших порядков):

```clojure
=> (map point [:x :y :z])
(100 150 nil)            ; это список, если что

=> (map nums [0 2 1])
(10 30 20)

=> (filter primes (range 12 0 -1))
(11 7 5 3 1)

=> (map :x [point {:x 200 :y 100} {}]) ; селектор!
(100 200 nil)

=> (let [set-1 #{1 2 3 4 5}
         set-2 #{2 4 6 8 10}]
      (filter set-1 set-2)) ; пересечение двух множеств!
(2 4)
```

Но особо меня радуют вспомогательные функции типа ``update-in``:

```clojure
;; напомню наш список примитивов
=> (pprint shapes)  ; да, pprint тут тоже есть!
[{:shape {:path [{:y 10, :x 10} {:y 100, :x 100}], :type :line},
  :pen {:color "FF00FF", :style :solid}}
 {:shape {:path [{:y 200, :x 200}], :type :dot}, :pen {:color :red}}]

=> (get-in shapes [0 :pen :color])
"FF00FF"
=> (get-in shapes [1 :pen :style] :none)
:none

;; в Clojure структуры - immutable, поэтому изменения будут доступны по новой имени
=> (def new-shapes
      (assoc-in shapes [1 :pen :style] :thin))
;... так я пропускаю вывод чего то малоинтересного
=> (get-in new-shapes [1 :pen :style] :none)
:thin

=> (get-in new-shapes [0 :shape :path 0 :x])
10
=> (def newest-shapes
        (update-in new-shapes [0 :shape :path 0 :x] + 42))
;...
=> (get-in newest-shapes [0 :shape :path 0 :x])
52

=> (assoc-in {} [:a :b :c] 42) ; создание вглубь!
{:a {:b {:c 42}}}
```

Всё это очень удобно при решении широкого круга задач! И очень мне нравится :)

На всякий случай код положил в [Gist](https://gist.github.com/astynax/5956370#file-clojure-data-examples-clj)

