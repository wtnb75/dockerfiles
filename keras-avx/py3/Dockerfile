FROM insready/bazel AS build
ARG tfver=1.2.1
RUN apt-get update && apt-get install -y python3-numpy python3-dev python3-pip python3-wheel
RUN mkdir /src
#ADD https://github.com/tensorflow/tensorflow/archive/v${tfver}.tar.gz /src/
#RUN tar xfz /src/v${tfver}.tar.gz -C /src
ADD v${tfver}.tar.gz /src/
WORKDIR /src/tensorflow-${tfver}
RUN yes '' | env PYTHON_BIN_PATH=/usr/bin/python3 CC_OPT_FLAG="-march=native" ./configure
RUN bazel build -c opt --copt=-mavx --copt=-msse4.1 --copt=-msse4.2 //tensorflow/tools/pip_package:build_pip_package
RUN bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

FROM python:3.4
ARG tfver=1.2.1
COPY --from=build /tmp/tensorflow_pkg/tensorflow-${tfver}-cp34-cp34m-linux_x86_64.whl /tmp/tensorflow-${tfver}-cp34-cp34m-linux_x86_64.whl
RUN pip install /tmp/tensorflow-${tfver}-cp34-cp34m-linux_x86_64.whl
RUN pip install keras h5py pandas sklearn
