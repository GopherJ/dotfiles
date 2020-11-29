#!/bin/bash

set -e

DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

GREEN="\033[1;32m"
RED="\033[0;31m"
END="\033[0m"
TOOLCHAIN="nightly"
DISTRIBUTION="$(lsb_release -is)"
DISTRIBUTION_VERSION="$(lsb_release -rs)"
PG_VERSION="10"

cd $DIR

if [ "$DISTRIBUTION" != "Ubuntu" ] && [ "$DISTRIBUTION" != "Linuxmint" ] && [ "$DISTRIBUTION" != "LinuxMint" ]; then
    echo -e "${RED}Error: distribution is not one of (ubuntu, LinuxMint)${END}" && exit 1
fi

if [ "$DISTRIBUTION_VERSION" == "16.04" ]; then
    PG_VERSION="9.5"
elif [ "$DISTRIBUTION_VERSION" == "18.04" ] || [ "$DISTRIBUTION_VERSION" == "19.3" ]; then
    PG_VERSION="10"
elif [ "$DISTRIBUTION_VERSION" == "19.04" ]; then
    PG_VERSION="11"
elif [ "$DISTRIBUTION_VERSION" == "19.10" ]; then
    PG_VERSION="12"
elif [ "$DISTRIBUTION_VERSION" == "20" ]; then
    PG_VERSION="12"
fi

function get_config_value() {
    local val=$(sed -ne "s/^\s*$1.*\"\(.*\)\"/\1/p" Config.toml |  sed -n "$2p")
    echo $val
}

PG_USERNAME="$(get_config_value username 1)"
PG_PASSWORD="$(get_config_value password 1)"
PG_DB="$(get_config_value db 1)"
PG_PORT="$(echo $(get_config_value host 2) | cut -d: -f2)"
REDIS_PORT="$(echo $(get_config_value url 1) | cut -d: -f3)"

sudo apt install \
    -y \
    --no-install-recommends \
    redis-server \
    curl \
    wget \
    apt-transport-https \
    postgresql-$PG_VERSION \
    libpq-dev \
    build-essential

echo -e "${GREEN}=> Configuring redis...${END}"
sudo sed -i "/^port\s[0-9]*/c\port ${REDIS_PORT}" /etc/redis/redis.conf
sudo sed -i "/^notify-keyspace-events\s/c\notify-keyspace-events KEA" /etc/redis/redis.conf
sudo systemctl restart redis-server

echo -e "${GREEN}=> Installing elasticsearch...${END}"
if [ ! -f /etc/apt/sources.list.d/elastic-7.x.list ]; then
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
fi
sudo apt-get update && sudo apt-get -y install elasticsearch=7.7.1  --allow-downgrades
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch
if [ -d /var/lib/elasticsearch ]; then
    sudo chown -R elasticsearch:elasticsearch /var/lib/elasticsearch
fi
curl -X PUT "localhost:9200/_template/coupons" \
    -H 'Content-Type: application/json' \
    -d @coupon_mappings.json

curl -X PUT "localhost:9200/_template/logs" \
    -H 'Content-Type: application/json' \
    -d @log_mappings.json

echo -e "\n${GREEN}=> Creating user $PG_USERNAME...${END}"
if [ -z "$(sudo -Hiu postgres psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='$PG_USERNAME'")" ]; then
    sudo -Hiu postgres createuser --superuser $PG_USERNAME
fi
sudo -Hiu postgres psql -c "alter user $PG_USERNAME with password '$PG_PASSWORD';"

echo -e "${GREEN}=> Creating database $PG_DB...${END}"
if [ "$(sudo -Hiu postgres psql -lqt | cut -d"|" -f 1 | grep -cw "$PG_DB")" -eq 0 ]; then
    sudo -Hiu postgres createdb $PG_DB
fi
sudo -Hiu postgres psql -c "grant all privileges on database $PG_DB to $PG_USERNAME;"

echo -e "${GREEN}=> Configuring postgresql...${END}"
if [ "$(sudo cat /etc/postgresql/$PG_VERSION/main/pg_hba.conf | grep -c "host all all 0.0.0.0/0 md5")" -eq 0 ]; then
    sudo bash -c "echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/$PG_VERSION/main/pg_hba.conf"
    sudo sed -i "/#listen_addresses/a listen_addresses = \'0.0.0.0\'" /etc/postgresql/$PG_VERSION/main/postgresql.conf
fi
sudo sed -i "s/\(5432\|5433\)/$PG_PORT/" /etc/postgresql/$PG_VERSION/main/postgresql.conf
sudo systemctl restart postgresql
pg_lsclusters

echo -e "${GREEN}=> Installing rust tool chain...${END}"
command -v rustup >/dev/null 2>&1 || bash -c "curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain ${TOOLCHAIN}"
# https://github.com/webdevops/Dockerfile/issues/138
sed -i -re 's/^(mesg n)(.*)$/#\1\2/g' ~/.profile
source ~/.profile
rustup default nightly

echo -e "${GREEN}=> Installing diesel cli...${END}"
command -v diesel >/dev/null 2>&1 || bash -c "cargo install diesel_cli --no-default-features --features postgres --force"

echo -e "${GREEN}=> Run migrations...${END}"
diesel migration run --database-url "postgres://$PG_USERNAME:$PG_PASSWORD@127.0.0.1:$PG_PORT/$PG_DB"
if [ -f $DIR/../server/src/postgres/schema.rs ]; then
    diesel print-schema --database-url "postgres://$PG_USERNAME:$PG_PASSWORD@127.0.0.1:$PG_PORT/$PG_DB" > $DIR/../server/src/postgres/schema.rs
fi

echo -e "${GREEN}=> Finished!${END}"
