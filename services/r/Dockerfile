## start with the latest ubuntu
FROM twistedogic/worker

## That's me
MAINTAINER twistedogic

## Remain current
RUN apt-get update -qq
RUN apt-get dist-upgrade -y

## get tool
RUN apt-get install -y software-properties-common

## Add CRAN repo to get current R
RUN add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu $(lsb_release -cs)/"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

## Update again
RUN apt-get update -qq
RUN apt-get dist-upgrade -y

RUN apt-get install -y --no-install-recommends r-base r-base-dev r-recommended littler
RUN ln -s /usr/share/doc/littler/examples/install.r /usr/local/bin/install.r

## To have a container run multiple & persistent tasks, we use the very simple supervisord as recommended in Docker documentation.
CMD ["/usr/bin/supervisord"]


