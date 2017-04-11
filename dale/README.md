# dale compoler

## Usage

```
[local]# docker pull wtnb75/dale
[local]# cat hello.dt
(import cstdio)

(def main (fn extern-c int ((argc int) (argv (p (p char))))
  (printf "hello, world\n")))

[local]# docker run -v $PWD:/c -w /c wtnb75/dale dalec hello.dt
[local]# docker run -v $PWD:/c -w /c wtnb75/dale ./a.out
hello, world
```
