# Java 25 Docker for Pterodactyl

<div align="center">

![Java 25](https://img.shields.io/badge/Java-25.0.1_LTS-orange?style=for-the-badge&logo=openjdk)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Pterodactyl](https://img.shields.io/badge/Pterodactyl-Compatible-0e8a16?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

**The first publicly available Java 25 Docker image for Pterodactyl**

*Ready for Hytale and next-generation Java applications*

[Quick Start](#-quick-start) • [Installation](#-installation) • [Configuration](#-configuration) • [Documentation](#-documentation)

</div>

---

## 🎯 Overview

This Docker image provides a production-ready Java 25 environment specifically optimized for Pterodactyl game server panel. Built on **Eclipse Temurin 25 LTS**, it's designed to support the next generation of Java-based games, with a primary focus on **Hytale** when it releases.

### Why This Matters

Hytale is being developed with Java 25, making this the **only** Docker solution currently available for hosting Hytale servers on Pterodactyl. By using this image, you're positioning yourself ahead of the curve for when the game launches.

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🚀 **Java 25 LTS** | Latest Eclipse Temurin 25.0.1 with long-term support |
| 🔒 **Security Hardened** | Non-root user execution, minimal attack surface |
| ⚡ **Performance Optimized** | Pre-configured with Aikar's battle-tested JVM flags |
| 🎮 **Game Ready** | Designed for Hytale, compatible with any Java 25 application |
| 📦 **Lightweight** | Only 655 MB with essential dependencies |
| 🔧 **Pterodactyl Native** | Full integration with variable substitution and controls |
| 🤖 **Auto-Configuration** | Automatic JAR download and EULA acceptance |

---

## 🚀 Quick Start

### For Server Owners

1. **Import the egg** into your Pterodactyl panel:
   - Download `egg-java-25.json` from this repository
   - Navigate to **Admin Panel** → **Nests** → **Import Egg**
   - Upload the egg file

2. **Create a server** using the **Java 25 Generic** egg

3. **Configure and start** your server with your Java 25 application

### For Pterodactyl Administrators

```bash
# Pull the image
docker pull janxhg/java25-pterodactyl:latest

# Verify Java version
docker run --rm janxhg/java25-pterodactyl:latest java -version
```

---

## 📥 Installation

### Step 1: Import the Pterodactyl Egg

1. Download the egg configuration file: [`egg-java-25.json`](egg-java-25.json)
2. Access your Pterodactyl admin panel
3. Navigate to **Nests** → Select or create a nest
4. Click **Import Egg** and upload the JSON file
5. Configure the Docker image field: `janxhg/java25-pterodactyl:latest`

### Step 2: Create a Server

1. Go to **Servers** → **Create New Server**
2. Select the **Java 25 Generic** egg
3. Allocate resources (minimum 2GB RAM recommended)
4. Configure server variables (see [Configuration](#-configuration))

### Step 3: Deploy Your Application

- **Option A**: Provide a direct download URL in `SERVER_JARFILE`
- **Option B**: Upload your JAR file manually to the server directory

---

## ⚙️ Configuration

### Environment Variables

| Variable | Description | Default | Example |
|----------|-------------|---------|---------|
| `SERVER_JARFILE` | Server JAR filename or download URL | `server.jar` | `https://example.com/hytale-server.jar` |
| `SERVER_MEMORY` | Memory allocation in MB | `2048` | `4096` |
| `JAVA_ARGS` | JVM arguments (see below) | Aikar's flags | Custom JVM flags |
| `SERVER_ARGS` | Application-specific arguments | `nogui` | `--world-dir /data` |
| `AUTO_EULA` | Auto-accept EULA on first start | `true` | `false` |

### Optimized JVM Flags (Aikar's Flags)

The egg comes pre-configured with production-tested JVM flags optimized for game servers:

```bash
-XX:+UseG1GC
-XX:+ParallelRefProcEnabled
-XX:MaxGCPauseMillis=200
-XX:+UnlockExperimentalVMOptions
-XX:+DisableExplicitGC
-XX:+AlwaysPreTouch
-XX:G1HeapWastePercent=5
-XX:G1MixedGCCountTarget=4
-XX:InitiatingHeapOccupancyPercent=15
-XX:G1MixedGCLiveThresholdPercent=90
-XX:G1RSetUpdatingPauseTimePercent=5
-XX:SurvivorRatio=32
-XX:+PerfDisableSharedMem
-XX:MaxTenuringThreshold=1
```

These flags are optimized for:
- ✅ Low latency and reduced GC pauses
- ✅ Efficient memory management
- ✅ High throughput for game servers
- ✅ Tested with Minecraft (compatible with Hytale)

---

## 🎮 Use Cases

### Hytale Servers (When Released)

```yaml
Server JAR File: https://hytale.com/downloads/server.jar
Server Memory: 4096
Java Arguments: (use default)
Server Arguments: nogui
Auto Accept EULA: true
```

### Custom Java 25 Applications

```yaml
Server JAR File: your-application.jar
Server Memory: 2048
Java Arguments: -Xms2G -Xmx2G -jar
Server Arguments: --config /home/container/config.yml
```

### Modded Servers

```yaml
Server JAR File: https://example.com/modded-server.jar
Server Memory: 8192
Java Arguments: (use default + custom mods flags)
Server Arguments: nogui --forceUpgrade
```

---

## 📊 Performance Recommendations

| Server Size | Players | RAM | CPU Cores | Storage |
|-------------|---------|-----|-----------|---------|
| **Small** | 1-10 | 2-4 GB | 2 | 10 GB |
| **Medium** | 10-50 | 4-8 GB | 4 | 20 GB |
| **Large** | 50-100 | 8-16 GB | 6-8 | 50 GB |
| **Enterprise** | 100+ | 16+ GB | 8+ | 100+ GB |

> **Note**: These are general recommendations. Actual requirements will vary based on your specific application, plugins, and world size.

---

## 🔧 Technical Details

### Base Image
- **Distribution**: Eclipse Temurin (formerly AdoptOpenJDK)
- **Version**: 25.0.1 LTS
- **OS**: Ubuntu 22.04 LTS (Jammy)
- **Architecture**: amd64

### Included Packages
- `curl`, `wget` - Download utilities
- `git` - Version control
- `fontconfig` - Font rendering support
- `ca-certificates` - SSL/TLS support
- `tzdata` - Timezone data
- `iproute2` - Network utilities

### Security Features
- ✅ Non-root user execution (`container:container`)
- ✅ Minimal package installation
- ✅ No unnecessary ports exposed
- ✅ Regular security updates via base image

---

## 🐛 Troubleshooting

<details>
<summary><b>Container won't start</b></summary>

**Symptoms**: Server fails to start, no output in console

**Solutions**:
1. Check that `SERVER_JARFILE` is accessible
2. Verify sufficient disk space
3. Review Pterodactyl console logs
4. Ensure proper file permissions

</details>

<details>
<summary><b>Out of Memory (OOM) errors</b></summary>

**Symptoms**: Server crashes with `OutOfMemoryError`

**Solutions**:
1. Increase `SERVER_MEMORY` allocation
2. Optimize JVM flags for your workload
3. Monitor actual memory usage
4. Consider upgrading server resources

</details>

<details>
<summary><b>EULA not accepted</b></summary>

**Symptoms**: Server stops with EULA message

**Solutions**:
1. Set `AUTO_EULA=true` in egg variables
2. Manually create `eula.txt` with `eula=true`
3. Restart the server

</details>

<details>
<summary><b>Java version mismatch</b></summary>

**Symptoms**: Application requires different Java version

**Solutions**:
1. Verify your application supports Java 25
2. Check Docker image version: `docker run --rm janxhg/java25-pterodactyl:latest java -version`
3. Use appropriate egg for your Java version

</details>

---

## 📚 Documentation

- **[Quick Start Guide](QUICKSTART.md)** - Get up and running in 5 minutes
- **[Egg Configuration](egg-java-25.json)** - Pterodactyl egg specification
- **[Dockerfile](Dockerfile)** - Image build configuration
- **[License](LICENSE)** - MIT License

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

- 🐛 **Report bugs** via GitHub Issues
- 💡 **Suggest features** for future releases
- 📝 **Improve documentation** with pull requests
- 🎮 **Share configurations** for different games
- ⭐ **Star this repository** if you find it useful

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Credits

- **[Eclipse Adoptium](https://adoptium.net/)** - Java distribution
- **[Pterodactyl Panel](https://pterodactyl.io/)** - Game server management
- **[Aikar](https://aikar.co/)** - JVM optimization flags
- **Community contributors** - Testing and feedback

---

## 🌟 Star History

If this project helps you, please consider giving it a ⭐!

---

<div align="center">

**Built with ❤️ for the gaming community**

Ready for Hytale 🎮 | Optimized for Performance ⚡ | Secure by Design 🔒

[Report Bug](https://github.com/janxhg/java-25-pterodactyl/issues) • [Request Feature](https://github.com/janxhg/java-25-pterodactyl/issues)

</div>
