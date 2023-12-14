# wvp-docker

源项目地址为<https://github.com/648540858/wvp-GB28181-pro>，这里只是做了docker镜像和编排。

## 使用方法：

### 第一步 拉文件
```bash
git clone https://github.com/imnicn/wvp-docker.git
```

### 第二部 修改编排文件
```bash
cd wvp-docker
vim docker-compose.yml
```
这里`WVP_HOST`和`ZLM_HOST`改成自己的公网IP地址，别的按需要修改。

### 第三步 运行
```bash
docker-compose up -d
```
