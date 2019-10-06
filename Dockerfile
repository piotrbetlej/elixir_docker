FROM debian:buster

RUN apt-get update && apt-get install -y python3 python3-jinja2 python3-pygments python3-bsddb3 exuberant-ctags perl git apache2 net-tools vim

# Original repository
# RUN git clone https://github.com/bootlin/elixir.git /usr/local/elixir/

# Custom repository
RUN git clone -b grep https://github.com/piotrbetlej/elixir.git /usr/local/elixir/
RUN mkdir -p /path/elixir-data/linux/repo && mkdir -p /path/elixir-data/linux/data

# Append LXR_XYZ_DIR variable if not present
RUN grep "LXR_REPO_DIR" /etc/profile || echo "export LXR_REPO_DIR=/path/elixir-data/linux/repo" >> /etc/profile
RUN grep "LXR_DATA_DIR" /etc/profile || echo "export LXR_DATA_DIR=/path/elixir-data/linux/data" >> /etc/profile

# Setup apache2
COPY files/elixir.conf /etc/apache2/sites-available/
RUN a2enmod cgi rewrite

RUN a2dissite 000-default
RUN a2ensite elixir

# This is only an example. Todo: Automate for multiple repositories.
RUN git clone https://github.com/piotrbetlej/iwinfo.git /path/elixir-data/linux/repo/

# File to be sourced for updating database
COPY files/run.sh /
RUN chmod a+x /run.sh

# For automatic branch tagging
RUN git config --global user.email "pb_elixir@a.a" && git config --global user.name "PB Elixir"
# Copy autotagging script. Todo: solve this for multiple repos
COPY files/autotag.sh /path/elixir-data/linux/repo/
RUN chmod a+x /path/elixir-data/linux/repo/autotag.sh
RUN cd /path/elixir-data/linux/repo/ && /path/elixir-data/linux/repo/./autotag.sh