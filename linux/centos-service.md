# service

 | action                  | ~CentOS 6                       | CentOS 7~                                  |
 |-------------------------|---------------------------------|--------------------------------------------|
 |                         |                                 | systemctl list-units --t target --all --no-pager |
 | list service            | chkconfig --list                | systemctl list-unit-files -t service       |
 | register service        | chkconfig --add                 | systemctl daemon-reload                    |
 | start service           | service SERVICE_NAME start      | systemctl start SERVICE_NAME.service       |
 | stop service            | service SERVICE_NAME stop       | systemctl stop SERVICE_NAME.service        |
 | service status          | service SERVICE_NAME status     | systemctl status SERVICE_NAME.service      |
 | service status list     | chkconfig --list SERVICE_NAME   | systemctl is-active SERVICE_NAME.service   |
 | auto start on           | chkconfig SERVICE_NAME on       | systemctl enable SERVICE_NAME.service      |
 | auto statt off          | chkconfig SERVICE_NAME off      | systemctl disable SERVICE_NAME.service     |
 | run level               | runlevel                        | systemctl get-default                      |
 | show default            | /etc/inittab                    | systemctl set-default                      |
 | change default          | telinit                         | systemctl isolate                          |
 