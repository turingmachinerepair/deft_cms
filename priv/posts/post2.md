
%{
    id: "post-2",
    title: "Pitfalls of using timed maps",
    author: "Jaime Iniesta",
    tags: ~w(tag1 tag3),
    description: "Our second blog post is here"
}
---
Yes, this is **the post** you've been waiting for.


```erlang

-module(test).

test(Payload) ->
    lists:map(
        fun(X) -> X + X end,
        list:seq(1,100)
    ).
```


# Header1
## Header2
### HEader3
