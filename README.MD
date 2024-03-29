最近回顾了一下JVM的知识，把jdk12的源代码在Centos环境编译了一下，还比较顺利，趁热打铁，把编译过程在docker进行封装，
便于以后可以快速启用，执行脚本如下(以后就可以快速编译自己定制的JDK啦:):

- 脚本代码参见: https://github.com/perfectstorm88/jdk-compile-with-docker
- 官方编译说明: https://openjdk.java.net/groups/build/doc/building.html
  
```bash
docker build -t my-jdk # 
docker run my-jdk /jdk-release/jdk/bin/java -version  # 验证
```

其中主要的执行步骤如下：
```bash
#  参考：https://openjdk.java.net/groups/build/doc/building.html
#  说明文档描述的功能
yum groupinstall  -y "Development Tools"
yum install -y java-11-openjdk-devel
yum install  -y freetype-devel
yum install -y cups-devel
yum install -y  alsa-lib-devel
yum install  -y libXtst-devel libXt-devel libXrender-devel libXrandr-devel libXi-devel
yum install -y alsa-lib-devel
yum install -y libffi-devel
yum install -y    autoconf

# 安装文档中没有说明，但是docker容器中缺少的工具
yum install -y which  && yum install -y  fontconfig-devel

# 下载版本并解压, 
# 进入http://hg.openjdk.java.net/jdk/jdk12 页面，点击左边的browse，可以看到各种源文件，再点击右边的gz，可以下载
yum install -y wget
wget http://hg.openjdk.java.net/jdk/jdk12/archive/06222165c35f.tar.gz
 tar -xzvf 06222165c35f.tar.gz #解压到jdk12-06222165c35f 目录

# 执行编译
cd jdk12-06222165c35f 
bash configure  # 编译配置
make # 编译 等同于make images

# test  版本
./build/linux-x86_64-server-release/images/jdk/bin/java -version
```