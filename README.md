# Docker - mariadb:10.4.15 on alpine:3.12
  
  
  
  
## Description
- Alpine Linux 3.12 기반의 저용량 MariaDB 10.4.15 컨테이너
- 설치하며 환경변수로 전달받은 옵션 적용은 scripts 디렉토리 내부의 쉘 스크립트 파일을 통해 설정됨
- Alpine MariaDB 레파지토리 업데이트에 따라 실행이 보장되지 않을 
  
## 빌드
- build.sh 또는 build_windows.bat 실행 (docker build --tag mariadb-alpine:1.0 .)
- mariadb-alpine:1.0 로 빌드
- Dockerfile을 참조하여 빌드  
  
  
  
## 컨테이너 실행
- startup.sh 또는 startup_windows.bat 실행 (docker-compose up -d)
- docker-compose.yml을 참조하여 실행
  
  
  
## Environment Variables
- MYSQL_DATABASE　:　입력한 값으로 데이터베이스를 생성
- MYSQL_CHARSET　:　데이터베이스의 캐릭터셋을 설정
- MYSQL_COLLATION　:　데이터베이스의 컬레이션 설정
- MYSQL_USER　:　all privileges를 가진 사용자 생성
- MYSQL_PASSWORD　:　위의 사용자의 비밀번호 설정
- MYSQL_ROOT_PASSWORD　:　root 비밀번호 설정
- SKIP_INNODB　:　특정 볼륨을 연동하는 경우 설정이 기억됨
  
```console
$ docker run -it --rm --name=db \
	-v /foo/bar:/var/lib/mysql \
	-e MYSQL_USER=foo \
	-e MYSQL_DATABASE=bar \
	-e MYSQL_PASSWORD=baz \
	{container}
```
  
  
  
## 설정파일 연동하기
```console
$ docker run -it --rm --name=db \
         -v $(pwd)/config/my.cnf:/etc/my.cnf.d/my.cnf \
         {container}
```
  
  
  
## 서비스 시작시 특정 sql 스크립트 실행
첫 서비스 구동시 mysql_install_db 스크립트가 실행된다.  
(데이터베이스가 존재하면 실행되지 않음)  
직접 작성한 sql 스크립트를 사용할 수 있다.  
/docker-entrypoint-initdb.d에 전달하는 방식으로 구동  
  
target : init/mydatabase.sql  

```console
$ docker run -it --rm -e SKIP_INNODB=1 -v db:/var/lib/mysql \
	-v $(pwd)/init:/docker-entrypoint-initdb.d \
	{container}
  
> init: installing mysql client
> init: updating system tables
> init: executing /docker-entrypoint-initdb.d/custom.sh
> 	Hello from script
> init: adding /docker-entrypoint-initdb.d/mydatabase.sql
> init: removing mysql client
```
  
위 과정은 다른 이미지에서 구현하는 방식과 비슷하다.  
쉘스크립트가 실행된 후 선택적으로 sql 또는 sql.gz가 mysqld 서비스 구동 부분으로 파이프 된다.  
제공된 스크립트 또는 sql은 MYSQL_DATABASE에 명시한 데이터베이스 범위 내에서 실행된다.  
