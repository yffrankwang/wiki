##### Install GeoIP
    wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
    gunzip GeoIP.dat.gz
    wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
    gunzip GeoLiteCity.dat.gz
    sudo mkdir /usr/local/share/GeoIP
    sudo mv GeoIP.dat /usr/local/share/GeoIP/
    sudo mv GeoLiteCity.dat /usr/local/share/GeoIP/

#### EC2 (/usr/share/GeoIP/GeoIP.dat)
    sudo yum install nginx-mod-http-geoip

#### Configuration (nginx.conf)
    load_module "modules/ngx_http_geoip_module.so";

    http {
        geoip_country  /usr/local/share/GeoIP/GeoIP.dat;
    }

