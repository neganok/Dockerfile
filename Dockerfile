# Sử dụng image cơ sở Ubuntu
FROM ubuntu:20.04

# Đảm bảo sử dụng non-interactive mode để tránh yêu cầu tương tác
ENV DEBIAN_FRONTEND=noninteractive

# Cập nhật apt, cài đặt các gói cần thiết và dọn dẹp cache
RUN apt update -y && \
    apt install -y --no-install-recommends \
    git \
    tmux \
    htop \
    speedtest-cli \
    python3-pip \
    zip \
    screen \
    curl \
    unzip \
    wget \
    xdg-utils && \
    rm -rf /var/lib/apt/lists/*

# Cài đặt Node.js từ NodeSource
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Clone repository mix và giải nén tệp mix.zip
RUN git clone https://github.com/neganok/mix /mix && \
    cd /mix && \
    if [ -f mix.zip ]; then unzip mix.zip; else echo "mix.zip not found!"; fi

# Cài đặt các thư viện Python cần thiết
RUN pip3 install requests python-telegram-bot pytz termcolor psutil

# Thiết lập thư mục làm việc mặc định khi vào container
WORKDIR /mix

# Chỉ cài đặt các package npm khi đã vào thư mục /mix
RUN npm cache clean --force && \
    npm install -g npm@latest && \
    npm install --legacy-peer-deps puppeteer puppeteer-core async fs request puppeteer-extra puppeteer-extra-plugin-stealth hpack colors set-cookie-parser axios chalk chalk@2

# Cài đặt entrypoint để khi container chạy sẽ vào shell
CMD ["/bin/bash"]
