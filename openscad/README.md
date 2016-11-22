# OpenSCAD snapshot

## build

```
# docker build -t openscad .
```

## run

```
# docker run -t -i -v $PWD:$PWD -w $PWD openscad openscad -o output.stl --render input.scad
```
