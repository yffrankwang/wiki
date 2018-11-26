##### install packages
    yum -y install http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
    yum -y install --enablerepo=nginx nginx

##### nginx connect() to 127.0.0.1:8080 failed (13: Permission denied)
    setsebool httpd_can_network_connect on -P

##### auto start service
    systemctl enable nginx

##### change owner
    chown -R nginx.nginx /var/cache/nginx

##### start service
    systemctl start nginx

##### app deploy folder
    mkdir -p /opt/apps/XXXXX
    chown -R tomcat:tomcat /opt/apps/XXXXX
    chmod -R g+rwX /opt/apps/XXXXX

##### nginx open() /xxx/ failed (13: Permission denied)
    yum install -y policycoreutils-devel
    chcon -Rt httpd_sys_content_t /opt/apps/XXXXX

