FROM php:8.2-fpm
 
# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    unixodbc-dev \
    gcc \
    g++ \
    make \
    autoconf \
    libc-dev \
    pkg-config \
    libxml2-dev \
    bash \
    libcurl4-openssl-dev \
    libssl-dev \
    git \
    openssh-client
 
# Ajouter la clé GPG Microsoft
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg
 
# Ajouter le dépôt Microsoft pour Debian 12 (bookworm)
RUN curl https://packages.microsoft.com/config/debian/12/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
 
# Mettre à jour les dépôts
RUN apt-get update
 
# Installer le ODBC driver pour SQL Server
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18
 
# Installer les outils mssql (optionnel)
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools18
 
# Ajouter le chemin mssql-tools au PATH (optionnel)
RUN echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
 
RUN apt-get update && apt-get install -y libzip-dev && docker-php-ext-install zip

RUN apt-get update && apt-get install -y \
    wget unzip libx11-xcb1 libxcomposite1 libxcursor1 libxi6 libxtst6 libxrandr2 libxdamage1 libglib2.0-0 \
    libnss3 libxss1 libasound2 libatk1.0-0 libcups2 libdrm2 libdbus-1-3 libxshmfence1 libgbm-dev \
    libgtk-3-0 libcurl4 libcurl3-gnutls chromium chromium-driver

# Installer les extensions SQLSRV et PDO_SQLSRV
RUN pecl install sqlsrv pdo_sqlsrv \
&& docker-php-ext-enable sqlsrv pdo_sqlsrv
 
# Nettoyer les fichiers inutiles pour alléger l'image
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
 
# Configurer Git pour ignorer les vérifications de l'hôte
RUN git config --global core.sshCommand "ssh -o StrictHostKeyChecking=no"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./ApiLaravel /var/www/app
# Assurez-vous que les bonnes permissions et la configuration sont en place pour le répertoire de l'application
WORKDIR /var/www/app
 