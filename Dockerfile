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
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    lsb-release \
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
    unzip mix.zip

# Cài đặt các thư viện Python cần thiết
RUN pip3 install requests python-telegram-bot pytz termcolor psutil

# Cài đặt các package Node.js
RUN npm install async fs request puppeteer-extra puppeteer-extra-plugin-stealth hpack colors set-cookie-parser axios chalk chalk@2

# Thiết lập thư mục làm việc mặc định khi vào container
WORKDIR /mix

# Cài đặt entrypoint để khi container chạy sẽ vào shell
CMD ["/bin/bash"]
