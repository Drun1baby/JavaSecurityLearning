# JavaSecurityLearning
记录一下 Java 安全学习历程，也有参考 Y4tacker 师傅的https://github.com/Y4tacker/JavaSec

> 也在整理自己的 Java 学习路线，学了也有一会儿了，总结出一点小心得

## 先从开发学起

推荐的是这些

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



后续还没想好，也还没学到，初定会先 log4j2 ---> jackson 然后内存马

## Log4j2



## Weblogic



## EL 表达式



## 内存马