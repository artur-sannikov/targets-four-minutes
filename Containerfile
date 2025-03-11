FROM rocker/rstudio:4.4.3

RUN apt-get update && apt install -y \
	libglpk-dev \
	libxml2-dev

RUN R -e "install.packages('remotes')"
RUN R -e "remotes::install_github('rstudio/renv@v1.1.2')"

WORKDIR /project

# Copy renv to image
RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

# Rebuild the environemnt
RUN R -e "setwd('/project');renv::init();renv::restore()"



