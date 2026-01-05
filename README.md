# Java 25 Docker Image for Pterodactyl

![Java Version](https://img.shields.io/badge/Java-25-orange)
![Docker](https://img.shields.io/badge/Docker-Ready-blue)
![Pterodactyl](https://img.shields.io/badge/Pterodactyl-Compatible-green)

**The first publicly available Java 25 Docker image for Pterodactyl!** 🚀

This Docker image is specifically designed for running Java 25 applications on Pterodactyl panel, with a primary focus on **Hytale** server hosting when the game is released.

## 🎯 Why Java 25?

Hytale is being developed with Java 25, which means existing Minecraft server hosting solutions won't work out of the box. This Docker image positions you ahead of the curve, ready to host Hytale servers as soon as the game launches.

## ✨ Features

- ✅ **Java 25** (Eclipse Temurin JDK)
- ✅ **Pterodactyl-optimized** entrypoint and configuration
- ✅ **Security-hardened** with non-root user
- ✅ **Minimal footprint** - only essential dependencies
- ✅ **Pre-configured** with optimized JVM flags (Aikar's flags)
- ✅ **Auto-EULA** acceptance support
- ✅ **Easy deployment** - ready to use egg configuration

## 🐳 Building the Docker Image

### Prerequisites

- Docker installed on your system
- (Optional) Docker Hub account for publishing

### Build Command

```bash
cd D:\ASAS\TurboMC\java-25-docker
docker build -t turbomc/java25-pterodactyl:latest .
```

### Build with Version Tag

```bash
docker build -t turbomc/java25-pterodactyl:1.0.0 -t turbomc/java25-pterodactyl:latest .
```

## 📤 Publishing to Docker Hub

1. **Login to Docker Hub:**
   ```bash
   docker login
   ```

2. **Tag your image:**
   ```bash
   docker tag turbomc/java25-pterodactyl:latest yourusername/java25-pterodactyl:latest
   ```

3. **Push to Docker Hub:**
   ```bash
   docker push yourusername/java25-pterodactyl:latest
   docker push yourusername/java25-pterodactyl:1.0.0
   ```

## 🥚 Installing the Pterodactyl Egg

1. **Download the egg file:**
   - Use `egg-java-25.json` from this repository

2. **Import into Pterodactyl:**
   - Navigate to your Pterodactyl admin panel
   - Go to **Nests** → Select a nest (or create a new one)
   - Click **Import Egg**
   - Upload `egg-java-25.json`

3. **Configure the egg:**
   - Update the Docker image field to point to your published image
   - Default: `ghcr.io/pterodactyl/yolks:java_25` (update this to your image)

## 🚀 Usage

### Creating a Server

1. Create a new server in Pterodactyl
2. Select the **Java 25 Generic** egg
3. Configure the following variables:
   - **Server JAR File**: URL to download or filename if uploading manually
   - **Server Memory**: Amount of RAM in MB (e.g., 2048)
   - **Java Arguments**: JVM flags (pre-configured with Aikar's flags)
   - **Server Arguments**: Additional server arguments (default: `nogui`)
   - **Auto Accept EULA**: Set to `true` to automatically accept EULA

### Example Configuration for Hytale (when available)

```
Server JAR File: https://example.com/hytale-server.jar
Server Memory: 4096
Java Arguments: (use default optimized flags)
Server Arguments: nogui
Auto Accept EULA: true
```

## 🔧 Configuration Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `SERVER_JARFILE` | Server JAR filename or download URL | `server.jar` | Yes |
| `SERVER_MEMORY` | Memory allocation in MB | `2048` | Yes |
| `JAVA_ARGS` | JVM arguments | Aikar's flags | No |
| `SERVER_ARGS` | Server-specific arguments | `nogui` | No |
| `AUTO_EULA` | Auto-accept EULA | `true` | Yes |

## 🎮 Optimized JVM Flags

The egg comes pre-configured with **Aikar's flags**, which are battle-tested for optimal Minecraft server performance:

```
-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 
-XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch 
-XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 
-XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 
-XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 
-XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1
```

These flags work great for Minecraft and should also work well for Hytale!

## 🧪 Testing the Image

### Verify Java Version

```bash
docker run --rm turbomc/java25-pterodactyl:latest java -version
```

Expected output:
```
openjdk version "25" 2025-XX-XX
OpenJDK Runtime Environment Temurin-25+XX (build 25+XX)
OpenJDK 64-Bit Server VM Temurin-25+XX (build 25+XX, mixed mode, sharing)
```

### Test Container Startup

```bash
docker run --rm -e STARTUP="echo 'Test successful!'" turbomc/java25-pterodactyl:latest
```

## 📋 Troubleshooting

### Issue: Container won't start

**Solution:** Check the Pterodactyl console logs for errors. Ensure the `SERVER_JARFILE` is accessible.

### Issue: Out of memory errors

**Solution:** Increase the `SERVER_MEMORY` variable. For Hytale, we recommend at least 4GB (4096 MB).

### Issue: EULA not accepted

**Solution:** Set `AUTO_EULA` to `true` or manually create an `eula.txt` file with `eula=true`.

### Issue: Java version mismatch

**Solution:** Verify the Docker image is using Java 25:
```bash
docker run --rm your-image:tag java -version
```

## 🔒 Security Considerations

- The container runs as a **non-root user** (`container`)
- Only essential packages are installed
- Regular security updates via Eclipse Temurin base image
- No unnecessary ports exposed

## 📦 What's Included

- **Eclipse Temurin 25 JDK** - Production-ready Java distribution
- **Essential tools**: curl, wget, git
- **Network utilities**: iproute2 for IP detection
- **Timezone support**: tzdata for proper time handling
- **Font support**: fontconfig for GUI applications

## 🌟 Future Plans

- [ ] Add support for Java 25 preview features
- [ ] Create specialized Hytale egg when game releases
- [ ] Add performance monitoring tools
- [ ] Create multi-arch builds (ARM64 support)
- [ ] Add automated health checks

## 📄 License

This project is open source and available for anyone to use and modify.

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest features
- Submit pull requests
- Share your Hytale server configurations

## 📞 Support

For issues or questions:
- Open an issue on GitHub
- Check Pterodactyl documentation
- Join the TurboMC community

## 🎉 Credits

- **TurboMC** - Docker image and egg creation
- **Eclipse Adoptium** - Java distribution
- **Pterodactyl** - Game server management panel
- **Aikar** - Optimized JVM flags

---

**Ready for Hytale! 🎮**

Built with ❤️ by TurboMC
