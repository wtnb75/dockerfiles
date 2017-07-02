# Dockerfile to build tensorflow + avx (without GPU)

## Build

- git clone https://github.com/wtnb75/dockerfiles.git
- cd dockerfiles/keras-avx
- sh build.sh
  - wait (it tooks about 2 hours...)

## Use

- docker run -ti keras-avx:3 python
- docker run -ti keras-avx:2 python

```python
import tensorflow as tf

hello = tf.constant('Hello, TensorFlow!')
sess = tf.Session()
print(sess.run(hello))
```
