# 下载环境包
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.tar.gz"
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/11.0.2+9/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_linux-x64_bin.tar.gz"
wget "http://mirrors.shu.edu.cn/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz"
wget "https://downloads.lightbend.com/scala/2.12.8/scala-2.12.8.tgz"
wget "https://sbt-downloads.cdnedge.bluemix.net/releases/v1.2.8/sbt-1.2.8.tgz"
wget "https://repo.anaconda.com/archive/Anaconda3-2018.12-Linux-x86_64.sh"

# 创建目录
mkdir -p /usr/local/java
mkdir -p /usr/local/maven
mkdir -p /usr/local/scala
mkdir -p /usr/local/sbt
mkdir -p /usr/local/python/anaconda

# 解压到指定目录
tar -xf jdk-8u202-linux-x64.tar.gz -C /usr/local/java
tar -xf jdk-11.0.2_linux-x64_bin.tar.gz -C /usr/local/java
tar -xf apache-maven-3.6.0-bin.tar.gz -C /usr/local/maven
tar -xf scala-2.12.8.tgz -C /usr/local/scala
tar -xf sbt-1.2.8.tgz -C /usr/local/sbt
mv /usr/local/sbt/sbt /usr/local/sbt/sbt-1.2.8

# /etc/profile 配置环境变量
#export JAVA_HOME=/usr/local/java/jdk1.8.0_202
#export M2_HOME=/usr/local/maven/apache-maven-3.6.0
#export SCALA_HOME=/usr/local/scala/scala-2.12.8
#export SBT_HOME=/usr/local/sbt/sbt-1.2.8
#export ANACONDA_HOME=/usr/local/python/anaconda/anaconda3
#export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
#export PATH=$ANACONDA_HOME/bin:$SBT_HOME/bin:$SCALA_HOME/bin:$M2_HOME/bin:$JAVA_HOME/bin:$PATH

# 安装Anaconda
sh Anaconda3-2018.12-Linux-x86_64.sh
