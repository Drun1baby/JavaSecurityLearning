# JavaSecurityLearning

项目的初衷是为了让更多师傅在学习 Java 安全的时候能够有一条比较清晰的学习路线，也希望师傅们通过这个项目学习 Java 安全时有能够所收获。

项目文件夹中包含了部分用于漏洞调试的代码（如果有些东西打不通可以直接看代码），对应文章记录在博客中。

## 基础开发（是一定要学的）

先学 Springboot[【狂神说Java】SpringBoot最新教程IDEA版通俗易懂](https://www.bilibili.com/video/BV1PE411i7CV)

学一下 vue，VUE 可以过快一点：[尚硅谷Vue2.0+Vue3.0全套教程丨vuejs从入门到精通](https://www.bilibili.com/video/BV1Zy4y1K7SH?spm_id_from=333.788.top_right_bar_window_custom_collection.content.click)

学完这两个之后可以自己过一个小项目[【实战】基于SpringBoot+Vue开发的前后端分离博客项目完整教学](https://www.bilibili.com/video/BV1PQ4y1P7hZ?vd_source=a4eba559e280bf2f1aec770f740d0645)

- 学完这些内容最多花费两个月

推荐的 Java 基础，哪块不懂看哪块，[二倍速【狂神说Java】Java零基础学习视频通俗易懂](https://www.bilibili.com/video/BV12J41137hu?spm_id_from=333.337.search-card.all.click)

## Java 安全基础

可以看b站白日梦组长视频，讲的非常好

- [Java反序列化漏洞专题-基础篇(21/09/05更新类加载部分)](https://www.bilibili.com/video/BV16h411z7o9?spm_id_from=333.788.top_right_bar_window_custom_collection.content.click)
- [Java-IO流](https://drun1baby.github.io/2022/05/30/Java-IO流/)
- [反射](https://drun1baby.github.io/2022/05/20/Java反序列化基础篇-02-Java反射与URLDNS链分析/)
- [JDK动态代理](https://drun1baby.github.io/2022/06/01/Java反序列化基础篇-04-JDK动态代理/)
- [反序列化概念与利用](https://drun1baby.github.io/2022/05/17/Java反序列化基础篇-01-反序列化概念与利用/)
- [URLDNS链分析](https://drun1baby.github.io/2022/05/20/Java反序列化基础篇-02-Java反射与URLDNS链分析/)
- [类的动态加载](https://drun1baby.github.io/2022/06/03/Java反序列化基础篇-05-类的动态加载/)
- [反弹shell学习 ———— 这里主要是为了 yso 的使用](https://drun1baby.github.io/2022/07/20/反弹shell学习/)
- [Java 反弹 shell 与 Runtime.getRuntime().exec() 的故事](https://drun1baby.github.io/2022/10/12/Java-反弹-shell-与-Runtime-getRuntime-exec-的故事/)

一开始学还是会有点懵的，学到后面自然而然就会了。

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
- [02-Shiro721流程分析](https://drun1baby.top/2023/03/08/Java反序列化Shiro篇02-Shiro721流程分析/)

后面根据自己需求可以补 Shiro 权限绕过的部分。

## Java 反序列化进阶

- 这块是基础中的基础，但是也很难，要静下心来学的。
- [RMI基础](https://drun1baby.github.io/2022/07/19/Java反序列化之RMI专题01-RMI基础/)
- [RMI的几种攻击方式](https://drun1baby.github.io/2022/07/23/Java反序列化之RMI专题02-RMI的几种攻击方式/)
- [JNDI学习](https://drun1baby.github.io/2022/07/28/Java反序列化之JNDI学习/)
- [浅谈 JEP290](https://drun1baby.top/2023/04/18/浅谈-JEP290/)

LDAP 是包含在 JNDI 里面的

***

学完上面的之后就可以开始学习其他的了。

## Fastjson

- [FastJson基础](https://drun1baby.github.io/2022/08/04/Java反序列化Fastjson篇01-Fastjson基础/)
- [Fastjson-1.2.24版本漏洞分析](https://drun1baby.github.io/2022/08/06/Java反序列化Fastjson篇02-Fastjson-1-2-24版本漏洞分析/)
- [Fastjson篇03-Fastjson各版本绕过分析](https://drun1baby.github.io/2022/08/08/Java反序列化Fastjson篇03-Fastjson各版本绕过分析/)
- [Java反序列化Fastjson篇04-Fastjson1.2.62-1.2.68版本反序列化漏洞](https://drun1baby.github.io/2022/08/13/Java反序列化Fastjson篇04-Fastjson1-2-62-1-2-68版本反序列化漏洞/)
- [Java反序列化Fastjson篇05-写给自己看的一些源码深入分析](https://drun1baby.top/2022/10/19/Java反序列化Fastjson篇05-写给自己看的一些源码深入分析/)

2022 蓝帽杯初赛有一道 fastjson 1.2.68 的题目 [CTFReposityStore](https://github.com/Drun1baby/CTFReposityStore)

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

关于内存马的环境搭建可以看我这一篇文章：[Servlet 项目搭建](https://drun1baby.github.io/2022/08/22/Servlet-项目搭建/)
学习完之后最好自己可以用 Java Agent 实现一个 RASP

- [Java反序列化之内存马系列 01-基础内容学习](https://drun1baby.github.io/2022/08/19/Java内存马系列-01-基础内容学习/)
- [Java内存马系列-02-内存马介绍](https://drun1baby.github.io/2022/08/21/Java内存马系列-02-内存马介绍/)
- [Java内存马系列-03-Tomcat 之 Filter 型内存马](https://drun1baby.github.io/2022/08/22/Java内存马系列-03-Tomcat-之-Filter-型内存马/)
- [Java内存马系列-04-Tomcat 之 Listener 型内存马](https://drun1baby.github.io/2022/08/27/Java内存马系列-04-Tomcat-之-Listener-型内存马/)
- [Java内存马系列-05-Tomcat 之 Servlet 型内存马](https://drun1baby.github.io/2022/09/04/Java内存马系列-05-Tomcat-之-Servlet-型内存马/)
- [Java内存马系列-06-Tomcat 之 Valve 型内存马](https://drun1baby.github.io/2022/09/07/Java内存马系列-06-Tomcat-之-Valve-型内存马/)
- [Java Agent 内存马学习](https://drun1baby.top/2023/12/07/Java-Agent-内存马学习/)

## 关于 Java 代码审计（很多人对这块其实有个误区）

其实 Java 安全不光只有反序列化，其实代码审计也是很重要的，我最开始学的时候就踏入了这个误区。

WebGoat 代码打底 [WebGoat代码审计](https://drun1baby.top/2022/03/17/WebGoat代码审计-02-SQL注入/)

详细的**代码审计的文章与资料**，指路 [Java Owasp Top10 审计](https://github.com/Drun1baby/JavaSecurityLearning/tree/main/JavaSecurity/CodeReview/JavaSec-Code)

Springboot 文件上传 RCE https://github.com/LandGrey/spring-boot-upload-file-lead-to-rce-tricks

## 查漏补缺

- 其实链子没必要跟太多了，实战才是最重要的。

[Java反序列化之C3P0链](https://drun1baby.github.io/2022/10/06/Java反序列化之C3P0链/)

[Java OWASP 中的 XXE 代码审计](https://drun1baby.github.io/2022/09/16/Java-OWASP-中的-XXE-代码审计/)

[Java OWASP 中的 SQL 注入代码审计](https://drun1baby.github.io/2022/09/14/Java-OWASP-中的-SQL-注入代码审计/)

[Java 代码审计之华夏 ERP CMS v2.3](https://drun1baby.github.io/2022/09/30/Java-代码审计之华夏-ERP-CMS-V2.3/)

[Java反序列化之 SnakeYaml 链](https://drun1baby.github.io/2022/10/16/Java反序列化之-SnakeYaml-链/)

因为 SnakeYaml 的链子和 Fastjson 特别像，所以又复习了一遍 Fastjson 的源码

[Java反序列化Fastjson篇05-写给自己看的一些源码深入分析](https://drun1baby.github.io/2022/10/19/Java反序列化Fastjson篇05-写给自己看的一些源码深入分析/)

JS 引擎攻防 https://xz.aliyun.com/t/8697

## Struts2 系列漏洞

这块应该是目前学习的重点之一

[Java Struts2 学习与环境搭建](https://drun1baby.github.io/2022/11/02/Java-Struts2-学习与环境搭建/)

[Java Struts2 系列 S2-001](https://drun1baby.github.io/2022/10/27/Java-Struts2-系列-S2-001/)

## Jackson 系列漏洞

[Jackson 反序列化（一）漏洞原理](https://drun1baby.top/2023/12/07/Jackson-反序列化（一）漏洞原理/)

[Jackson 反序列化（二）CVE-2017-7525](https://drun1baby.top/2023/12/07/Jackson-反序列化（二）CVE-2017-7525/)

[Jackson 反序列化（三）CVE-2017-17485](https://drun1baby.top/2023/12/07/Jackson-反序列化（三）CVE-2017-17485/)

Jackson 反序列化 —— https://boogipop.com/2023/06/20/Jackson%E5%8F%8D%E5%BA%8F%E5%88%97%E5%8C%96%E9%80%9A%E6%9D%80Web%E9%A2%98/

## Apache

### Apache DolphinScheduler

CVE-2023-49299 & CVE-2024-23320 & CVE-2023-49109 漏洞概述：https://xz.aliyun.com/t/13981

### Apache Ofbiz

https://y4tacker.github.io/2023/12/27/year/2023/12/Apache-OFBiz%E6%9C%AA%E6%8E%88%E6%9D%83%E5%91%BD%E4%BB%A4%E6%89%A7%E8%A1%8C%E6%B5%85%E6%9E%90-CVE-2023-51467/

## CodeQL

师傅可能在编译的时候还会遇到一些问题，然而新版本的 CodeQL 对于 Java 已经不需要编译了

[CodeQL 入门](https://drun1baby.top/2023/09/03/CodeQL-%E5%85%A5%E9%97%A8/)

[CodeQL 官方文档学习](https://drun1baby.top/2023/07/31/CodeQL-%E5%AD%A6%E4%B9%A0/)

[用CodeQL分析漏洞_CVE-2022-42889 | l3yx's blog](https://l3yx.github.io/2022/12/17/用CodeQL分析漏洞-CVE-2022-42889/)

## 漏洞挖掘

Tabby 的使用：https://github.com/wh1t3p1g/tabby

## 后记
感觉现在 go 用的真的很多，java 系列可能暂时断更了，或许在不久的将来会出一个 golangSecurityLearning

<picture>
  <source
    media="(prefers-color-scheme: dark)"
    srcset="
      https://api.star-history.com/svg?repos=Drun1baby/JavaSecurityLearning&type=Timeline&theme=dark
    "
  />
  <source
    media="(prefers-color-scheme: light)"
    srcset="
      https://api.star-history.com/svg?repos=Drun1baby/JavaSecurityLearning&type=Timeline
    "
  />
  <img
    alt="Star History Chart"
    src="https://api.star-history.com/svg?repos=Drun1baby/JavaSecurityLearning&type=Timeline"
  />
</picture>

- 交流群

随着点 Star 的师傅越来越多，希望给师傅们提供一个交流的平台。
同时平常有一些师傅会加我好友问问题，问的人越来越多，于是决定建个群，也可以让师傅们在群里交流。（希望以后会写 golang 的 SecurityLearning）

> 可加 VX DrunkbabySec

![image](https://github.com/user-attachments/assets/2bb09ef2-ee00-4362-9d18-8f3ed22fdd1b)









