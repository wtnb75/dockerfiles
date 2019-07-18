
# 使い方

## ブート

```
# docker-compose build
# docker-compose up -d --scale worker=3
```

## spark-shellをmasterで動かしてみる

```
# docker-compose exec master spark-shell --master spark://master:7077
  :
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
Spark context Web UI available at http://d8a58cf442fd:4040
Spark context available as 'sc' (master = spark://master:7077, app id = app-20190717075809-0007).
Spark session available as 'spark'.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 2.4.3
      /_/

Using Scala version 2.11.12 (OpenJDK 64-Bit Server VM, Java 1.8.0_212)
Type in expressions to have them evaluated.
Type :help for more information.

scala> sc.master
res0: String = spark://master:7077
```


# S3のデータを読み込む

(まだ動かない)

- docker-compose exec master spark-shell --master spark://master:7077 --packages org.apache.hadoop:hadoop-aws:2.7.1
- val akey = "minio"
- val skey = "miniominio"
- val endpoint = "http://storage:9000"
- sc.hadoopConfiguration.set("fs.s3a.awsAccessKeyId", akey)
- sc.hadoopConfiguration.set("fs.s3a.awsSecretAccessKey", skey)
- sc.hadoopConfiguration.set("fs.s3a.endpoint", endpoint)
- sc.hadoopConfiguration.set("fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
- sc.hadoopConfiguration.set("fs.s3a.connection.ssl.enabled", "false")
- sc.hadoopConfiguration.set("fs.s3a.path.style.access", "true")
- sc.hadoopConfiguration.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider")
- sc.hadoopConfiguration.set("fs.s3a.access.key", akey)
- sc.hadoopConfiguration.set("fs.s3a.secret.key", skey)

## pysparkを動かしてみる

```
# docker-compose exec jupyter python
Python 3.7.4 (default, Jul 12 2019, 01:16:06)
[GCC 8.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from pyspark.context import SparkContext
>>> sc = SparkContext("spark://master:7077")
19/07/17 08:23:33 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel). For SparkR, use setLogLevel(newLevel).
>>> sc.master
'spark://master:7077'
>>> txt=sc.textFile("/spark/README.md")
>>> txt
/spark/README.md MapPartitionsRDD[1] at textFile at NativeMethodAccessorImpl.java:0
>>> res = txt.flatMap(lambda line: line.split(" ")).map(lambda word: (word, 1)).reduceByKey(lambda a,b: a+b)
>>> out = dict(res.collect())
>>> out
{'': 72, './bin/run-example': 2, 'SparkPi': 2, 'run': 7, 'set': 2, 'variable': 1, 'when': 1, 'examples': 2, 'spark://': 1, 'URL,':...
```

## Jupyter notebook

- open http://localhost:8888
- examples
  - [sum1](./sum1.ipynb)
  - [wordcount-scala](./wordcount-scala.ipynb)
  - [runjob](./runjob.ipynb)

## HDFSを使う

ローカルファイルを参照する場合、全てのノードで同じパスで同じファイルが参照できる必要があり、使いにくい。HDFSやS3などを使えば解消できる。

- docker-compose -f hdfs.yml build
- docker-compose -f docker-compose.yml -f hdfs.yml up -d --scale datanode=3 --scale worker=3
  - HDFSのアドレスは hdfs://namenode
  - HDFSのWebUIは http://localhost:9870 

```
scala> val txt = sc.textFile("/spark/README.md")
scala> txt.saveAsTextFile("hdfs://namenode/README.md")
```

HDFS側からも見える

```
# docker-compose -f docker-compose.yml -f hdfs.yml exec namenode hdfs dfs -ls /
Found 1 items
drwxr-xr-x   - root supergroup          0 2019-07-18 02:42 /README.md
# docker-compose -f docker-compose.yml -f hdfs.yml exec namenode hdfs dfs -ls /README.md
Found 3 items
-rw-r--r--   3 root supergroup          0 2019-07-18 02:42 /README.md/_SUCCESS
-rw-r--r--   3 root supergroup       2030 2019-07-18 02:42 /README.md/part-00000
-rw-r--r--   3 root supergroup       1922 2019-07-18 02:42 /README.md/part-00001
```


```python

```
