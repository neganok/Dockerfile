# Sử dụng một image cơ sở phù hợp với Ubuntu
FROM ubuntu:20.04

# Đảm bảo sử dụng non-interactive mode để tránh yêu cầu tương tác
ENV DEBIAN_FRONTEND=noninteractive

# Cập nhật apt và cài đặt các gói cần thiết
RUN apt update -y && \
    apt install -y \
    git \
    tmux \
    htop \
    speedtest-cli \
    python3-pip \
    zip \
    screen \
    curl \
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
    xdg-utils

# Cài đặt Node.js từ source
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
    apt install -y nodejs

# Clone repository mix và giải nén tệp mix.zip
RUN git clone https://github.com/neganok/mix && \
    cd mix && \
    unzip mix.zip

# Cài đặt các thư viện Python cần thiết
RUN pip3 install requests python-telegram-bot pytz termcolor psutil

# Cài đặt các package Node.js
RUN npm install async fs request puppeteer-extra puppeteer-extra-plugin-stealth hpack

# Thiết lập entrypoint để container có thể chạy theo yêu cầu
CMD ["bash"]
