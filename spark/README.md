# Usage

## boot

- docker-compose build
- docker-compose up -d --scale worker=3

## use(spark-shell)

- docker-compose exec master spark-shell --master spark://master:7077

or

- brew install apache-spark
- spark-shell --master spark://localhost:7077

## use(pyspark, jupyter notebook)

- pip install pyspark
- pyspark --master spark://localhost:7077

or

- open http://localhost:8888
   - New - Python 3
   - from pyspark.context import SparkContext
   - sc = SparkContext("spark://master:7077")
   - sc.applicationId
   - sc
   - ...
- examples
   - [sum1](./sum1.ipynb)
