# Đề tài: Xây dụng hệ thống Cloud mô phỏng trang đăng ký môn học có thể tự scale up, scale down



Thành viên nhóm 29:

 1. Lê Quốc Bảo       -    19110327
 2. Phạm Quang Hưng   -    19110373
 3. Lương Quốc Trung  -    19110489

- - -
Đây là đề tài cuối kì xây dựng hệ thống Cloud mô phỏng trang đăng kí môn học có thể tự scale up, scale down. Ở đề tài này, áp dụng tính năng của Docker Swarm, giúp hệ thống có thể load blancing, high availability. Đề tài này sử dụng prometheus được ghép nối với số liệu cadvisor để xác định mức sử dụng cpu. Sau đó, nó sử dụng nút người quản lý để xác định xem một dịch vụ có muốn được auto scale hay không và sử dụng node manager để scale service.
Hiện tại dự án chỉ sử dụng cpu để autoscale. Nếu mức sử dụng cpu đạt 85%, dịch vụ sẽ scale up, nếu đạt 25%, dịch vụ sẽ scale down.


Một số công nghệ sử dụng trong dự án:
- Spring Boot Framework
- MariaDB Galera Cluster
- Redis Database
- Docker Swarm

> **Note:**  Trên đây là là toàn bộ source code. Nội dung của ứng dụng đã được đóng gói thành các docker image để trên docker hub, Được để sẵn trong file docker compose, chỉ cần chạy deploy stack là có thể hoạt động được.
## 1. Phần hệ thống
Trong bài này, thì hệ thống sử dụng các ứng dụng để dám sát hệ thống:
- **cAdvisor (Container Advisor)** cung cấp cho người dùng container sự hiểu biết về việc sử dụng tài nguyên và đặc điểm hiệu suất của các container đang chạy của họ. Đây là một daemon đang chạy thu thập, tổng hợp, quy trình và xuất khẩu thông tin về các container đang chạy. Cụ thể, đối với mỗi container, nó giữ các thông số cách ly tài nguyên, sử dụng tài nguyên lịch sử, biểu đồ sử dụng tài nguyên lịch sử hoàn chỉnh và thống kê mạng. Dữ liệu này được xuất khẩu bằng container và trên toàn máy.
- **Prometheus** là một hệ thống giám sát dịch vụ và hệ thống. Nó thu thập các chỉ số từ các mục tiêu đã định cấu hình trong các khoảng thời gian nhất định, đánh giá các biểu thức quy tắc, hiển thị kết quả và có thể kích hoạt cảnh báo nếu một số điều kiện được quan sát là đúng.
Ở đây, Prometheus sẽ giám sát các thông số được cập nhật từ các container thông cAdvisor, từ số liệu đó sẽ kiểm tra hiệu năng của cpu, sau đó thiết lập các luật để để có thể scale up và scale down. 
Các cấu hình được đóng gói thành image docker-swarm-autoscaler. Cấu hình được để trong thư mục docker-swarm-autoscaler. 
- **Phần đóng gói câu hình sử dụng cú pháp:**
>     docker build . -t  lequocbao29072001/autoscaler:1.0
 - **Tạo file prometheus.yml chứa các thông tin cấu hình của prometheus (file đã chứa trong repository này)**
 - **Tạo file docker-swarm-autoscaler.yml chứa cấu hình các ứng dụng để triển khai giám sát hệ thống(file đã chứa trong repository này)**
 - **Thực hiện deploy docker stack, sử dụng lệnh sau**:

>     `docker stack deploy -c swarm-autoscaler-stack.yml autoscaler`
## 2.  Phần ứng dụng

Dưới đây là phần chi tiết đóng gói ứng dụng.
- **Cài đặt maven để buid thành gói jar**

>     sudo apt-get install maven


- **Sử dụng maven build thành gói .jar**

>     mvn install

- **Sử dụng docker file đã chứa trong repo (`Dockerfile` )để đóng gói thành image**

>     docker build . -t  hungfq/dkmh:1.5


- **Tạo file docker compose dkmh.yml . File này ở nằm ở trong repo. Trong file này định nghĩa 3 service: app, db, redis.** 


>Trong đó :
>- _`app` : là service chứa các container ứng dụng web_
> - _`db` : là service chứa container database_ 
>- _`redis` : là service database giúp lưu trữ cache và các session giúp container giữ trạng thái stateless_ 
>- _`image`: xác định tên image để tạo container_
>- _`deploy`: tùy chọn cấu hình cho việc triển khai_
>- _`replicas`: Số lượng bản sao container_
>- _`constraints`: [node.role == worker/manager] → Xác định container sẽ được triển khai ở host nào trong docker swarm. Ở đây, chúng ta xác định vị trí docker host theo vai trò manager/worker trong docker swarm._
>- _`volumes`: để mount  giữa docker host và container._
>- _`swarm.autoscaler`: Bắt buộc. Điều này cho phép tự động tính tỷ lệ cho một dịch vụ. Bất kỳ điều gì khác với `true` sẽ không kích hoạt nó_
>- _`swarm.autoscaler.minimum`: Đây là số lượng bản sao tối thiểu mong muốn cho một dịch vụ. Bộ phân chia tỷ lệ tự động sẽ không giảm tỷ lệ xuống dưới con số này_
>-`swarm.autoscaler.maximum`: Đây là số lượng bản sao tối đa mong muốn cho một dịch vụ. Trình tính toán tự động sẽ không mở rộng quy mô vượt quá con số này.
>
>Ở service “app”, khai báo một số biến ENV để tạo thông tin database như: MYSQL_HOST, REDIS_HOST… Sau khi tạo và chạy stack, chúng ta có thể kiểm tra kết nối web và db.

>Đối với các dịch vụ bạn muốn tự auto scale, bạn sẽ cần một nhãn triển khai swarm.autoscaler = true
 ```
deploy:
  labels:
    - "swarm.autoscaler=true"
```
> Điều này được kết hợp tốt nhất với các giới hạn ràng buộc tài nguyên. Đây cũng là chìa khóa triển khai.
```
deploy:
  resources:
    reservations:
      cpus: '0.25'
      memory: 512M
    limits:
      cpus: '0.50'
```

- **Thực hiện deploy docker stack, sử dụng lệnh sau**:

>     docker stack deploy -c dkmh.yml dkmh
## 3.  Cách sử dụng
1. Từ thư mục gốc deploy prometheus, cadvisor và docker-swarm-autoscaler bằng lệnh: 
>     docker stack deploy -c swarm-autoscaler-stack.yml autoscaler
2. Sau đó tiến hành chạy app bằng lệnh:
>     docker stack deploy -c dkmh.yml dkmh


## 4. Tài liệu tham khảo
1. [Autoscale Docker Swarm services based on cpu utilization. (github.com)](https://github.com/jcwimer/docker-swarm-autoscaler)
2. [Getting Started | Spring Boot with Docker](https://spring.io/guides/gs/spring-boot-docker/)
3. [toughiq/mariadb-cluster - Docker Image | Docker Hub](https://hub.docker.com/r/toughiq/mariadb-cluster)
4. [prom/prometheus - Docker Image | Docker Hub](https://hub.docker.com/r/prom/prometheus)
5. [google/cadvisor - Docker Image | Docker Hub](https://hub.docker.com/r/google/cadvisor/)
6. [Redis - Official Image | Docker Hub](https://hub.docker.com/_/redis)