FROM centos:7 as builder
MAINTAINER developer li.changzhen@163.com
WORKDIR /my
#  参考：https://openjdk.java.net/groups/build/doc/building.html
#  按着文档描述按着依赖
RUN yum groupinstall  -y "Development Tools"
RUN yum install -y java-11-openjdk-devel
RUN yum install  -y freetype-devel
RUN yum install -y cups-devel
RUN yum install -y  alsa-lib-devel
RUN yum install  -y libXtst-devel libXt-devel libXrender-devel libXrandr-devel libXi-devel
RUN yum install -y alsa-lib-devel
RUN yum install -y libffi-devel
RUN yum install -y  autoconf

# 安装文档中没有说明，但是docker容器中缺少的工具
RUN yum install -y which  && yum install -y  fontconfig-devel

# 下载版本并解压,
# 进入http://hg.openjdk.java.net/jdk/jdk12 页面，点击左边的browse，可以看到各种源文件，再点击右边的gz，可以下载
RUN yum install -y wget
RUN wget http://hg.openjdk.java.net/jdk/jdk12/archive/06222165c35f.tar.gz

# 执行编译
RUN tar -xzvf 06222165c35f.tar.gz #解压到jdk12-06222165c35f 目录
RUN cd jdk12-06222165c35f && bash configure && make  # 编译配置

# test  版本
RUN cd jdk12-06222165c35f && ./build/linux-x86_64-server-release/jdk/bin/java -version



FROM centos:7
COPY --from=builder /my/jdk12-06222165c35f/build/linux-x86_64-server-release/  /jdk-release