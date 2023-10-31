# ShiroVulnEnv

博客文章中的环境：http://wjlshare.com/archives/1545
增加了 CommonsBeanutils 和 Tomcat 通用的回显 payload

### 介绍
文章的漏洞环境，利用代码都在 test/java 下

![image](https://github.com/KpLi0rn/ShiroVulnEnv/blob/main/images/exploit.png)

生成的序列化文件在项目根目录下

![image](https://github.com/KpLi0rn/ShiroVulnEnv/blob/main/images/exploit2.png)

### 步骤

#### Step1 
启动服务
![image](https://github.com/KpLi0rn/ShiroVulnEnv/blob/main/images/start1.png)

#### Step2
来到 AESEncode 处，利用 AES 加密 tomcatHeader.ser 生成密文
![image](https://github.com/KpLi0rn/ShiroVulnEnv/blob/main/images/start2.png)

#### Step3 
添加到 rememberMe 中进行发送，绕过 Tomcat Header 限制
![image](https://github.com/KpLi0rn/ShiroVulnEnv/blob/main/images/start3.png)

#### Step4
来到 AESEncode 处，利用 AES 加密 tomcatInject.ser 生成密文
![image](https://github.com/KpLi0rn/ShiroVulnEnv/blob/main/images/start4.png)

#### Step5
添加到 rememberMe 中进行发送，进行内存马的注入
![image](https://github.com/KpLi0rn/ShiroVulnEnv/blob/main/images/start5.png)

#### Step6 
注入成功，回显如下
![image](https://github.com/KpLi0rn/ShiroVulnEnv/blob/main/images/start6.png)


### 参考链接
感谢三梦师傅和Litch1师傅，文章链接如下：

https://xz.aliyun.com/t/7388#toc-2
https://mp.weixin.qq.com/s?__biz=MzIwNDA2NDk5OQ==&mid=2651374294&idx=3&sn=82d050ca7268bdb7bcf7ff7ff293d7b3
