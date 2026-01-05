# Guía de Publicación - Java 25 Docker para Pterodactyl

Esta guía te llevará paso a paso para publicar tu proyecto tanto en **GitHub** como en **Docker Hub**.

---

## 📋 Requisitos Previos

- [ ] Cuenta de GitHub ([crear aquí](https://github.com/signup))
- [ ] Cuenta de Docker Hub ([crear aquí](https://hub.docker.com/signup))
- [ ] Git instalado en tu PC
- [ ] Docker Desktop instalado y corriendo

---

## 🐙 Parte 1: Publicar en GitHub

### Paso 1: Inicializar el repositorio Git

```powershell
cd D:\ASAS\TurboMC\java-25-docker

# Inicializar Git
git init

# Agregar todos los archivos
git add .

# Hacer el primer commit
git commit -m "Initial commit: Java 25 Docker for Pterodactyl"
```

### Paso 2: Crear el repositorio en GitHub

1. Ve a [GitHub](https://github.com) e inicia sesión
2. Haz clic en el botón **"+"** (arriba a la derecha) → **"New repository"**
3. Configura el repositorio:
   - **Repository name**: `java-25-pterodactyl` (o el nombre que prefieras)
   - **Description**: "First Java 25 Docker image for Pterodactyl - Ready for Hytale"
   - **Visibility**: Public (para que otros lo puedan usar)
   - **NO** marques "Initialize with README" (ya tienes uno)
4. Haz clic en **"Create repository"**

### Paso 3: Conectar y subir a GitHub

GitHub te mostrará comandos, pero usa estos (reemplaza `TU_USUARIO`):

```powershell
# Agregar el remote (reemplaza TU_USUARIO con tu nombre de usuario de GitHub)
git remote add origin https://github.com/TU_USUARIO/java-25-pterodactyl.git

# Renombrar la rama a main (si es necesario)
git branch -M main

# Subir el código
git push -u origin main
```

### Paso 4: Configurar el repositorio (opcional pero recomendado)

1. Ve a tu repositorio en GitHub
2. Haz clic en **"Settings"** → **"General"**
3. En **"Social preview"**, sube una imagen (puedes crear una con el logo de Java 25)
4. En **"Topics"**, agrega: `java`, `java25`, `docker`, `pterodactyl`, `hytale`, `minecraft`
5. Haz clic en **"About"** (en la página principal) y agrega:
   - Website: Tu sitio web (si tienes)
   - Topics: Los mismos de arriba
   - Marca "Releases" y "Packages"

---

## 🐳 Parte 2: Publicar en Docker Hub

### Paso 1: Login en Docker Hub

```powershell
docker login
```

Te pedirá:
- **Username**: Tu nombre de usuario de Docker Hub
- **Password**: Tu contraseña (o Access Token recomendado)

> **💡 Tip**: Es mejor usar un Access Token en lugar de tu contraseña:
> 1. Ve a [Docker Hub](https://hub.docker.com)
> 2. Settings → Security → New Access Token
> 3. Copia el token y úsalo como contraseña

### Paso 2: Etiquetar la imagen con tu usuario

```powershell
# Reemplaza TU_USUARIO con tu nombre de usuario de Docker Hub
docker tag turbomc/java25-pterodactyl:latest TU_USUARIO/java25-pterodactyl:latest
docker tag turbomc/java25-pterodactyl:latest TU_USUARIO/java25-pterodactyl:1.0.0
```

### Paso 3: Subir la imagen a Docker Hub

```powershell
# Subir ambas versiones (latest y 1.0.0)
docker push TU_USUARIO/java25-pterodactyl:latest
docker push TU_USUARIO/java25-pterodactyl:1.0.0
```

Esto tomará varios minutos (la imagen es de ~655 MB).

### Paso 4: Configurar el repositorio en Docker Hub

1. Ve a [Docker Hub](https://hub.docker.com)
2. Haz clic en tu repositorio `java25-pterodactyl`
3. Haz clic en **"Edit"** o el ícono de lápiz
4. Configura:
   - **Short description**: "First Java 25 Docker image for Pterodactyl - Ready for Hytale"
   - **Full description**: Copia el contenido de tu `README.md`
   - **Categories**: Selecciona "Application Infrastructure"
5. Guarda los cambios

---

## 🔗 Parte 3: Conectar GitHub con Docker Hub (Opcional - Builds Automáticos)

### Opción A: GitHub Actions (Recomendado)

Crea un archivo `.github/workflows/docker-publish.yml` en tu repositorio:

```yaml
name: Docker Build and Push

on:
  push:
    branches: [ main ]
    tags: [ 'v*' ]
  pull_request:
    branches: [ main ]

env:
  REGISTRY: docker.io
  IMAGE_NAME: ${{ secrets.DOCKERHUB_USERNAME }}/java25-pterodactyl

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Log into Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=ref,event=pr
            type=semver,pattern={{version}}
            type=semver,pattern={{major}}.{{minor}}
            type=raw,value=latest,enable={{is_default_branch}}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
```

Luego, configura los secrets en GitHub:
1. Ve a tu repositorio → **Settings** → **Secrets and variables** → **Actions**
2. Haz clic en **"New repository secret"**
3. Agrega:
   - `DOCKERHUB_USERNAME`: Tu usuario de Docker Hub
   - `DOCKERHUB_TOKEN`: Tu Access Token de Docker Hub

### Opción B: Docker Hub Automated Builds (Más simple pero limitado)

1. Ve a Docker Hub → tu repositorio
2. Haz clic en **"Builds"**
3. Conecta tu cuenta de GitHub
4. Selecciona el repositorio
5. Configura las reglas de build (por defecto está bien)

---

## 📝 Parte 4: Actualizar el Egg con tu Imagen

Edita el archivo `egg-java-25.json`:

```json
"docker_images": {
    "Java 25": "TU_USUARIO/java25-pterodactyl:latest"
}
```

Luego haz commit y push:

```powershell
git add egg-java-25.json
git commit -m "Update egg with Docker Hub image"
git push
```

---

## 🎯 Parte 5: Crear un Release en GitHub (Opcional pero profesional)

1. Ve a tu repositorio en GitHub
2. Haz clic en **"Releases"** → **"Create a new release"**
3. Configura:
   - **Tag version**: `v1.0.0`
   - **Release title**: `v1.0.0 - First Java 25 Docker for Pterodactyl`
   - **Description**:
     ```markdown
     ## 🚀 First Release
     
     The first publicly available Java 25 Docker image for Pterodactyl!
     
     ### Features
     - ✅ Java 25.0.1 LTS (Eclipse Temurin)
     - ✅ Optimized for Pterodactyl
     - ✅ Ready for Hytale
     - ✅ Pre-configured with Aikar's flags
     
     ### Docker Image
     ```
     docker pull TU_USUARIO/java25-pterodactyl:1.0.0
     ```
     
     ### Installation
     See [README.md](README.md) for full instructions.
     ```
   - **Attach files**: Sube el `egg-java-25.json`
4. Haz clic en **"Publish release"**

---

## ✅ Checklist Final

Antes de publicar, verifica:

- [ ] `.gitignore` creado
- [ ] Todos los archivos commiteados en Git
- [ ] Repositorio creado en GitHub
- [ ] Código subido a GitHub
- [ ] Login en Docker Hub exitoso
- [ ] Imagen etiquetada con tu usuario
- [ ] Imagen subida a Docker Hub
- [ ] Descripción agregada en Docker Hub
- [ ] `egg-java-25.json` actualizado con tu imagen
- [ ] (Opcional) GitHub Actions configurado
- [ ] (Opcional) Release creado en GitHub

---

## 🌐 URLs Finales

Después de publicar, tendrás:

- **GitHub**: `https://github.com/TU_USUARIO/java-25-pterodactyl`
- **Docker Hub**: `https://hub.docker.com/r/TU_USUARIO/java25-pterodactyl`
- **Docker Pull**: `docker pull TU_USUARIO/java25-pterodactyl:latest`

---

## 📢 Parte 6: Promoción (Opcional)

Para maximizar el impacto:

1. **Reddit**:
   - r/hytale
   - r/admincraft
   - r/selfhosted

2. **Discord**:
   - Servidor oficial de Hytale
   - Comunidades de Pterodactyl
   - Comunidades de hosting

3. **Twitter/X**:
   - Tweet con hashtags: #Hytale #Java25 #Pterodactyl #Docker

4. **Foros**:
   - Foros de Pterodactyl
   - Foros de Hytale

**Mensaje sugerido**:
```
🚀 ¡Primer Docker de Java 25 para Pterodactyl!

Listo para Hytale cuando salga. Incluye:
✅ Java 25 LTS
✅ Egg pre-configurado
✅ Flags optimizados

GitHub: [tu-link]
Docker Hub: [tu-link]

#Hytale #Java25 #Pterodactyl
```

---

## 🆘 Solución de Problemas

### Error: "denied: requested access to the resource is denied"
**Solución**: Verifica que hiciste `docker login` correctamente.

### Error: "repository does not exist"
**Solución**: Asegúrate de que el nombre de usuario es correcto y que el repositorio existe en Docker Hub.

### Error al hacer push a GitHub
**Solución**: Verifica que tienes permisos y que la URL del remote es correcta:
```powershell
git remote -v
```

---

## 🎉 ¡Listo!

Una vez completados estos pasos, tu proyecto estará públicamente disponible y listo para que la comunidad lo use cuando Hytale salga.

**¡Serás el primero en ofrecer hosting de Java 25 para Hytale!** 🎮
