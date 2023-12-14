# wvp-docker

源项目地址为<https://github.com/648540858/wvp-GB28181-pro>，这里只是做了docker镜像和编排。

## 使用方法：

### 第一步 拉文件
```bash
git clone https://github.com/taoxincn/wvp-docker.git
```

### 第二步 修改编排文件
```bash
cd wvp-docker
vim docker-compose.yml
```
这里`STREAM_IP`、`SDP_IP`和`WVP_SHOW_IP`改成自己的公网IP地址，别的按需要修改。

### 第三步 修改最新的sql脚本
检查并修改`mvp/sql/1_create_table.sql`文件，与<https://github.com/648540858/wvp-GB28181-pro/blob/wvp-28181-2.0/sql/%E5%88%9D%E5%A7%8B%E5%8C%96.sql>保持一致。

### 第四步 运行
```bash
docker-compose up -d
```
