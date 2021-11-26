# Đề tài: Xây dụng hệ thống Cloud mô phỏng trang đăng ký môn học có thể tự scale up, scale down



Thành viên nhóm 29:

 1. Lê Quốc Bảo       -    19110327
 2. Phạm Quang Hưng   -    19110373
 3. Lương Quốc Trung  -    19110489

- - -
**Note:**  Trên đây là là toàn bộ source code, nội dung của ứng dụng đã được đóng gói thành các docker image để trên docker hub, để trong file docker compose là dkmh.yml. 

Dưới đây là phần chi tiết đóng gói ứng dụng.
- **Cài đặt maven để buid thành gói jar**

>     sudo apt-get install maven


- **Sử dụng maven build thành gói .jar**

>     maven install

- **Sử dụng docker file đã chứa trong repo (`Dockerfile` )để đóng gói thành image**

>     docker build . -t  hungfq/dkmh:1.4.3


- **Tạo file docker compose dkmh.yml . File này ở nằm ở trong repo. Trong file này định nghĩa 3 service: app, db, redis.** 


>Trong đó :
>- _app : là service chứa các container ứng dụng web_
> - _db : là service chứa container database_ 
>- _redis : là service database giúp lưu trữ cache và các session giúp container giữ trạng thái stateless_ 
>- _image: xác định tên image để tạo container_
>- _deploy: tùy chọn cấu hình cho việc triển khai_
>- _replicas: Số lượng bản sao container_
>- _constraints: [node.role == worker/manager] → Xác định container sẽ được triển khai ở host nào trong docker swarm. Ở đây, chúng ta xác định vị trí docker host theo vai trò manager/worker trong docker swarm._
>- _volumes: để mount  giữa docker host và container._
>
>Ở service “app”, khai báo một số biến ENV để tạo thông tin database như: MYSQL_HOST, REDIS_HOST… Sau khi tạo và chạy stack, chúng ta có thể kiểm tra kết nối web và db.

- **Thực hiện deploy docker stack, sử dụng lệnh sau**:

>     docker stack deploy -c dkmh.yml dkmh