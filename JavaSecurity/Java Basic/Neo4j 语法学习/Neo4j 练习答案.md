# 练习答案

### MATCH、OPTIONAL

#### MATCH （用指定的模式检索数据库）

1. 返回数据库的所有信息

```cql
MATCH(n)RETURN(n)
```

2. 返回数据库中所有电影的信息

```CQL
MATCH (movie:Movie)
RETURN movie.title
```

3. 返回 Lilly Wachowski 相关的所有电影

```cql
MATCH ({ name: 'Lilly Wachowski' })--(movie)
RETURN movie.title
```

4. 返回与Person 'Lilly Wachowski'相连的带有Movie标签的所有节点

```cql
MATCH (:Person { name: 'Lilly Wachowski' })--(movie:Movie)
RETURN movie.title
```

