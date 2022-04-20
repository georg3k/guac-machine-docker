# Docker web kiosk machine 

With this project you can launch your GUI application in a Docker container as a web-service using guacamole as a front-end. It builds a CentOS 7 container and configures openbox WM so it works as your app will be available in kiosk mode. 

## Usage

1. Put your application binaries in my_app directory
2. Edit Dockerfile so it includes all the dependencies needed by your application
```
RUN yum install -y epel-release && \
    yum install -y \
        fontconfig \
        libX11 \
        openbox \
        supervisor \
        xrdp \
        YOUR \
        DEPENDENCIES \
        HERE && \
    yum clean all
```
3. Edit xdg autostart in Dockerfile so it points to your application
```
RUN adduser user && \
    echo "user:user" | chpasswd && \
    echo "/opt/my_app/YOUR_APP_HERE.sh &" >> /etc/xdg/openbox/autostart
```
4. Deploy containers using docker-compose
```
docker-compose up -d
```
5. Open guacamole in browser and login: http://localhost:8080/guacamole

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

