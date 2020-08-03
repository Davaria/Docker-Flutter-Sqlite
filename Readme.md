# Flutter + Sqlite3 📲

## Requerimientos

**_Para este proyecto se uso docker, dentro de las cuales estan las configuraciones para el desarrollo con Flutter. Nota leer el siguiente articulo para trabajar con Docker_**

- [Docker](https://blog.codemagic.io/how-to-dockerize-flutter-apps/) 🐋

## Configuraciones actualizadas👨‍🔧

En la parte de **Understanding Dockerfile ...**

### Dockerfile 🐋

```docker
# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
# Set up new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor
```

## Flutter 📱

### ⚠️ **_Alerta..._**

En este repositorio estara incluido un proyecto flutter simplemente nesecitara conectar **_cable USB_** el cual nesecitara para visualizar el proyecto, nota en Windows y MacOS se nesecitara una configuracion extra.

```dart
flutter doctor -v
```

![Flutter%20+%20Sqlite3%20%F0%9F%93%B2%2058e5ae77c422496da04dfa6ed4b3f42f/Screenshot_20200802_215114.png](Flutter%20+%20Sqlite3%20%F0%9F%93%B2%2058e5ae77c422496da04dfa6ed4b3f42f/Screenshot_20200802_215114.png)

Una vez lances la app por la consola con `flutter run` o `flutter run -v` , ademas que se instalaran las dependencias de desarrollo.Recuerda que ante la interaccion con la app deberas recargar desde la consola con `R` para visualizar los cambios.

![Flutter%20+%20Sqlite3%20%F0%9F%93%B2%2058e5ae77c422496da04dfa6ed4b3f42f/Screenshot_20200802_222747.png](Flutter%20+%20Sqlite3%20%F0%9F%93%B2%2058e5ae77c422496da04dfa6ed4b3f42f/Screenshot_20200802_222747.png)

### Resultados

Los resultados son probados en un **\*Samsung Galaxy S10+** nombre de la app **DEMO.\***

![Flutter%20+%20Sqlite3%20%F0%9F%93%B2%2058e5ae77c422496da04dfa6ed4b3f42f/WhatsApp_Image_2020-08-02_at_9.17.04_PM(2).jpeg](<Flutter%20+%20Sqlite3%20%F0%9F%93%B2%2058e5ae77c422496da04dfa6ed4b3f42f/WhatsApp_Image_2020-08-02_at_9.17.04_PM(2).jpeg>)

![Flutter%20+%20Sqlite3%20%F0%9F%93%B2%2058e5ae77c422496da04dfa6ed4b3f42f/WhatsApp_Image_2020-08-02_at_9.17.04_PM(1).jpeg](<Flutter%20+%20Sqlite3%20%F0%9F%93%B2%2058e5ae77c422496da04dfa6ed4b3f42f/WhatsApp_Image_2020-08-02_at_9.17.04_PM(1).jpeg>)

![Flutter%20+%20Sqlite3%20%F0%9F%93%B2%2058e5ae77c422496da04dfa6ed4b3f42f/WhatsApp_Image_2020-08-02_at_9.17.04_PM.jpeg](Flutter%20+%20Sqlite3%20%F0%9F%93%B2%2058e5ae77c422496da04dfa6ed4b3f42f/WhatsApp_Image_2020-08-02_at_9.17.04_PM.jpeg)
