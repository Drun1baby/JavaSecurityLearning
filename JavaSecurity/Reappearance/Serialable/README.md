# 这块基础部分要小心这个坑

当我们复现这个 DynamicClassLoader 里面的内容的时候，我们的恶意类，是需要新建于 src 目录下的，不然都会报错。

把 .class 文件拿出来，后续要把根 .class 与 源.java 都删掉