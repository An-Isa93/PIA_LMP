# Usa una imagen base de Python
FROM python:3.11-slim

# Establece las variables de entorno
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Establece el directorio de trabajo
WORKDIR /PIA_LMP

# Instala dependencias del sistema necesarias para mysqlclient y Pillow
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    libmariadb-dev \
    build-essential \
    libjpeg-dev zlib1g-dev python3-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

# Instala Pillow y otras dependencias del sistema
RUN pip install --upgrade pip setuptools wheel

# Instala la librería de imágenes Pillow y mysqlclient
RUN pip install Pillow mysqlclient

# Copia los archivos de requirements.txt al contenedor
COPY requirements.txt .

# Instala las dependencias de Python desde el requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copia el resto de los archivos del proyecto al contenedor
COPY . .

# Expone el puerto 8000 para la aplicación
EXPOSE 8000

# Comando para ejecutar la aplicación Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
