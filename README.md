# JavaSecurityLearning

可能写的有点乱，但基本是形成了一个路线形式的文章，后续可能会把排版优化一下哈哈哈

记录一下 Java 安全学习历程，也有参考 Y4tacker 师傅的学习笔记 https://github.com/Y4tacker/JavaSec

> 也在整理自己的 Java 学习路线，学了也有一会儿了，总结出一点小心得
> 有师傅说这个项目对他帮助很大，我想这是我当初新建这个项目的初衷，能够帮助到越来越多的师傅学习 Java 安全，不至于那么迷茫。

## 先从开发学起

推荐的是这些：

先学 Springboot[【狂神说Java】SpringBoot最新教程IDEA版通俗易懂](https://www.bilibili.com/video/BV1PE411i7CV)，前面部分是 Thymeleaf 模板引擎的开发，后面是一些组件的基本使用，很基础。



学一下 vue：[尚硅谷Vue2.0+Vue3.0全套教程丨vuejs从入门到精通](https://www.bilibili.com/video/BV1Zy4y1K7SH?spm_id_from=333.788.top_right_bar_window_custom_collection.content.click)

学完这两个之后可以自己过一个小项目[【实战】基于SpringBoot+Vue开发的前后端分离博客项目完整教学](https://www.bilibili.com/video/BV1PQ4y1P7hZ?vd_source=a4eba559e280bf2f1aec770f740d0645)



- 学完这些内容最多花费两个月时间。



如果中途有什么看不懂的，也可以推荐看 Java 基础，哪块不懂看哪块，二倍速走起看[【狂神说Java】Java零基础学习视频通俗易懂](https://www.bilibili.com/video/BV12J41137hu?spm_id_from=333.337.search-card.all.click)

## Java 基础

可以看b站白日梦组长的视频，讲的非常好

- [Java反序列化漏洞专题-基础篇(21/09/05更新类加载部分)](https://www.bilibili.com/video/BV16h411z7o9?spm_id_from=333.788.top_right_bar_window_custom_collection.content.click)
- [Java-IO流](https://drun1baby.github.io/2022/05/30/Java-IO流/)
- [反射](https://drun1baby.github.io/2022/05/20/Java反序列化基础篇-02-Java反射与URLDNS链分析/)
- [JDK动态代理](https://drun1baby.github.io/2022/06/01/Java反序列化基础篇-04-JDK动态代理/)
- [反序列化概念与利用](https://drun1baby.github.io/2022/05/17/Java反序列化基础篇-01-反序列化概念与利用/)
- [URLDNS链分析](https://drun1baby.github.io/2022/05/20/Java反序列化基础篇-02-Java反射与URLDNS链分析/)
- [类的动态加载](https://drun1baby.github.io/2022/06/03/Java反序列化基础篇-05-类的动态加载/)
- [反弹shell学习 ———— 这里主要是为了 yso 的使用](https://drun1baby.github.io/2022/07/20/反弹shell学习/)
- [Java 反弹 shell 与 Runtime.getRuntime().exec() 的故事](https://drun1baby.github.io/2022/10/12/Java-反弹-shell-与-Runtime-getRuntime-exec-的故事/)

一开始学还是会有点懵的，学到后面自然而然就会了



## Java 反序列化基础

接着就可以开始 CC 链了；CC 链是 1-6-3-2-4-5-7

还有一个 CC11；这一块 CC 链的学习要多自己总结，有利于后续的学习。

- 视频同样推荐 b 站白日梦组长的视频

- [CC1链](https://drun1baby.github.io/2022/06/06/Java反序列化Commons-Collections篇01-CC1链/)

- [CC1链补充](https://drun1baby.github.io/2022/06/10/Java反序列化Commons-Collections篇02-CC1链补充/)

- [CC6链](https://drun1baby.github.io/2022/06/11/Java反序列化Commons-Collections篇03-CC6链/)

- [CC3链](https://drun1baby.github.io/2022/06/20/Java反序列化Commons-Collections篇04-CC3链/)

- [CC2链](https://drun1baby.github.io/2022/06/28/Java反序列化Commons-Collections篇05-CC2链/)

- [CC4链](https://drun1baby.github.io/2022/06/28/Java反序列化Commons-Collections篇06-CC4链/)

- [CC5链](https://drun1baby.github.io/2022/06/29/Java反序列化Commons-Collections篇07-CC5链/)

- [CC7链](https://drun1baby.github.io/2022/06/29/Java反序列化Commons-Collections篇08-CC7链/)

- [CC11链](https://drun1baby.github.io/2022/07/11/Java反序列化Commons-Collections篇09-CC11链/)

- [CommonsBeanUtils反序列化](https://drun1baby.github.io/2022/07/12/CommonsBeanUtils反序列化/)

CC 链部分结束，进入 shiro 部分，shiro 之前我们已经走过开发了，所以理解起来很简单。

- [Shiro550流程分析](https://drun1baby.github.io/2022/07/10/Java反序列化Shiro篇01-Shiro550流程分析/)

Shiro 721 的可能后续会学习吧，现在先不学习。



进入到新的阶段

## Java 反序列化进阶

- 这块是基础中的基础，但是也很难，要静下心来学的。

- [RMI基础](https://drun1baby.github.io/2022/07/19/Java反序列化之RMI专题01-RMI基础/)

- [RMI的几种攻击方式](https://drun1baby.github.io/2022/07/23/Java反序列化之RMI专题02-RMI的几种攻击方式/)

- [JNDI学习](https://drun1baby.github.io/2022/07/28/Java反序列化之JNDI学习/)

LDAP 是包含在 JNDI 里面的

***

学完上面的之后就可以开始学习其他的了。



## Fastjson&&Jackson

- [FastJson基础](https://drun1baby.github.io/2022/08/04/Java反序列化Fastjson篇01-Fastjson基础/)
- [Fastjson-1.2.24版本漏洞分析](https://drun1baby.github.io/2022/08/06/Java反序列化Fastjson篇02-Fastjson-1-2-24版本漏洞分析/)
- [Fastjson篇03-Fastjson各版本绕过分析](https://drun1baby.github.io/2022/08/08/Java反序列化Fastjson篇03-Fastjson各版本绕过分析/)
- [Java反序列化Fastjson篇04-Fastjson1.2.62-1.2.68版本反序列化漏洞](https://drun1baby.github.io/2022/08/13/Java反序列化Fastjson篇04-Fastjson1-2-62-1-2-68版本反序列化漏洞/)
- [Java反序列化Fastjson篇05-写给自己看的一些源码深入分析](https://drun1baby.top/2022/10/19/Java反序列化Fastjson篇05-写给自己看的一些源码深入分析/)

值得一提的是，2022 蓝帽杯初赛有一道 fastjson 1.2.68 的题目，师傅们可以去我的仓库中，到本地复现。[CTFReposityStore](https://github.com/Drun1baby/CTFReposityStore)

## Log4j2

- [Log4j2 复现](https://drun1baby.github.io/2022/08/09/Log4j2复现/)



这些学完之后可以学一下内存马，Weblogic，Tomcat 和 Spring 开发；这里先学 Spring 开发。 

[Spring开发学习](https://drun1baby.github.io/2022/08/18/Spring开发学习/)

## Weblogic 

以下四个洞虽然简单，但很有趣。

- [CVE-2015-4852 WebLogic T3 反序列化分析](https://drun1baby.top/2022/11/28/CVE-2015-4852-WebLogic-T3-反序列化分析/)
- [CVE-2017-10271 WebLogic XMLDecoder](https://drun1baby.top/2023/02/09/CVE-2017-10271-WebLogic-XMLDecoder/)
- [CVE-2021-2109 WebLogic JNDI 注入](https://drun1baby.top/2023/02/12/CVE-2021-2109-WebLogic-JNDI-注入/)
- [WebLogic 弱口令&文件上传&SSRF](https://drun1baby.top/2023/03/06/WebLogic-弱口令-文件上传-SSRF/)



## EL 表达式注入（本质上还是 OGNL 表达式注入）

- [Java 之 SpEL 表达式注入](https://drun1baby.github.io/2022/09/23/Java-之-SpEL-表达式注入/)

- [Java 之 EL 表达式注入](https://drun1baby.github.io/2022/09/23/Java-之-EL-表达式注入/)

## 内存马

个人认为内存马刚开始学习的时候和反序列化并无太大关联，反而和 Servlet，Tomcat 关联度非常高。

我觉得还是需要打一下基础的，学习路线如下

基础部分：Tomcat 架构 ---> Servlet 相关基础知识 ----> JSP 的马 ----> 



学完基础就可以开始看内存马了，Web 服务的流程应该是 Listener ---> Filter ---->  Servlet；但是先学 Listener



内存马的学习：Filter ----> Listener -----> Servlet; 内存马与反序列化



关于内存马的环境搭建可以看我这一篇文章：[Servlet 项目搭建](https://drun1baby.github.io/2022/08/22/Servlet-项目搭建/)



- [Java反序列化之内存马系列 01-基础内容学习](https://drun1baby.github.io/2022/08/19/Java内存马系列-01-基础内容学习/)
- [Java内存马系列-02-内存马介绍](https://drun1baby.github.io/2022/08/21/Java内存马系列-02-内存马介绍/)
- [Java内存马系列-03-Tomcat 之 Filter 型内存马](https://drun1baby.github.io/2022/08/22/Java内存马系列-03-Tomcat-之-Filter-型内存马/)
- [Java内存马系列-04-Tomcat 之 Listener 型内存马](https://drun1baby.github.io/2022/08/27/Java内存马系列-04-Tomcat-之-Listener-型内存马/)
- [Java内存马系列-05-Tomcat 之 Servlet 型内存马](https://drun1baby.github.io/2022/09/04/Java内存马系列-05-Tomcat-之-Servlet-型内存马/)
- [Java内存马系列-06-Tomcat 之 Valve 型内存马](https://drun1baby.github.io/2022/09/07/Java内存马系列-06-Tomcat-之-Valve-型内存马/)



## 关于 Java 代码审计

最近自己也在看吧，感觉有点意思，Java 代码审计还是有点难度的；建议先从 WebGoat 入手，后续再看吧。



最近学下来，感觉先学完 WebGoat，然后跟着复现一些漏洞吧，比如 RuoYi 的一些漏洞，前期先看其他师傅的文章跟着复现，后续可以自己审计一些代码。

详细的**代码审计的文章**与资料，欢迎师傅们进到 [Java Owasp Top10 审计](https://github.com/Drun1baby/JavaSecurityLearning/tree/main/JavaSecurity/OWASP TOP10)，项目中查看。这个项目是我参考于 joychou93 师傅写的 `java-sec-code` 项目的，并且自己加上了一些理解



**更新于 2022.10.13**

现在一些基础的东西已经没问题了，如果在把上述内容都学完之后，谈一谈我认为蛮重要的几个点吧。



- 要温故而知新，像 CC 链这种 EXP，能手写尽量手写，其他的链子也是，要有独立分析的能力
- 对于 Java 代码审计也是，需要有独立分析的能力，学会总结审计方法
- 最近自己也在刷力扣，还是想保证一些编程手感，并且为日后的手撕代码做准备。



## 在学完上述内容之后该学什么

> 我认为还是应该查漏补缺，下面会放一些我觉得蛮有意思的东西供师傅们学习



[Java反序列化之C3P0链](https://drun1baby.github.io/2022/10/06/Java反序列化之C3P0链/)

[Java OWASP 中的 XXE 代码审计](https://drun1baby.github.io/2022/09/16/Java-OWASP-中的-XXE-代码审计/)

[Java OWASP 中的 SQL 注入代码审计](https://drun1baby.github.io/2022/09/14/Java-OWASP-中的-SQL-注入代码审计/)

[Java 代码审计之华夏 ERP CMS v2.3](https://drun1baby.github.io/2022/09/30/Java-代码审计之华夏-ERP-CMS-V2.3/)

[Java反序列化之 SnakeYaml 链](https://drun1baby.github.io/2022/10/16/Java反序列化之-SnakeYaml-链/)

因为 SnakeYaml 的链子和 Fastjson 特别像，所以又复习了一遍 Fastjson 的源码

[Java反序列化Fastjson篇05-写给自己看的一些源码深入分析](https://drun1baby.github.io/2022/10/19/Java反序列化Fastjson篇05-写给自己看的一些源码深入分析/)

懒癌终于不犯了，开始学习 Struts2 系列漏洞，这一块是没有必要特别去学开发的，因为 Struts2 的应用已经太少太少了。

[Java Struts2 学习与环境搭建](https://drun1baby.github.io/2022/11/02/Java-Struts2-学习与环境搭建/)

[Java Struts2 系列 S2-001](https://drun1baby.github.io/2022/10/27/Java-Struts2-系列-S2-001/)

在进行代码审计的时候，多想一想有漏洞的代码是为什么产生的，最好是自己手写一遍有漏洞的代码，并且进行修复。

在审计 CMS 的时候，审计出漏洞之后，不光是要明白怎么打，更要明白如何修复。

**更新于 2023.1.28**

走到这一步我觉得需要学习一下对应的开发，这个开发不是单纯的 Java 开发，比如这些课题 "用 golang 重构一个 sqlmap"，比如 "如何自己写一个扫描器"，如何写 "burpsuite 插件"，目前我正在学习这一部分。

另有一些新的 Java 产出文章，有兴趣的师傅可以具体见博客 https://drun1baby.github.io/

**更新于 2023.4.28**

一眨眼就是三个月，谈一谈我所认为的安全研究吧，不一定准确，若有说的不准确的地方还请师傅们多多斧正。

我认为的安全研究分四种：

最厉害的一种应该是纯研究，这种太厉害太厉害。

再就是几种类型的安全研究

安全研究 + 攻击性产品完善（开发）、类似于 安全研究新漏洞，将其规则输出到 goby 里；

安全研究 + 审计性产品完善（开发）、类似于主机扫描等，或者说 jar 包分析、代码审计的白盒自动化扫描器。

安全研究 + 红队、类似于研究 0day、代码审计、域渗透攻防研究。

几种研究并不分好坏，但是目前很少有”纯“安全研究了。

我也很菜，目前还是在不断前进，愿与师傅们共勉这一段话，最早看到是在 Err0r 哥哥的博客（队内的好哥哥）

[关于考研](https://err0r.top/article/postgraduate/)

> 即便尽其所能，亦未必如初愿。如举笔画物，光有明暗，画制于材，技艺有所不能，虽心之所愿，然下笔仍有憾。

深有感触，前路可能黑暗迷茫，努力加油走下去，终会看见曙光。
