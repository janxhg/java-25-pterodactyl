# Quick Start Guide - Java 25 Docker for Pterodactyl

## 🚀 Fast Track to Hytale Hosting

### Step 1: Build the Docker Image

```powershell
cd D:\ASAS\TurboMC\java-25-docker
.\build.ps1
```

Or manually:
```powershell
docker build -t turbomc/java25-pterodactyl:latest .
```

### Step 2: Test the Image

```powershell
# Verify Java 25 is installed
docker run --rm turbomc/java25-pterodactyl:latest java -version
```

You should see:
```
openjdk version "25"
```

### Step 3: Publish to Docker Hub (Optional)

```powershell
# Login first
docker login

# Build and push
.\build.ps1 -Push -Username "yourusername" -Version "1.0.0"
```

### Step 4: Import Egg to Pterodactyl

1. Open your Pterodactyl admin panel
2. Navigate to **Admin** → **Nests**
3. Select or create a nest (e.g., "Java Servers")
4. Click **Import Egg**
5. Upload `egg-java-25.json`
6. Edit the egg and update the Docker image field to your image name

### Step 5: Create Your First Server

1. Go to **Servers** → **Create New**
2. Select the **Java 25 Generic** egg
3. Configure:
   - **Server JAR File**: Your server JAR URL or filename
   - **Server Memory**: 2048 (or more for better performance)
   - **Auto Accept EULA**: true
4. Click **Create**

### Step 6: Start Your Server

1. Go to your server's console
2. Click **Start**
3. Watch the magic happen! ✨

## 🎮 Ready for Hytale!

When Hytale releases:
1. Get the Hytale server JAR download URL
2. Create a new server using this egg
3. Set **Server JAR File** to the Hytale download URL
4. Adjust memory (recommended: 4096 MB minimum)
5. Start and enjoy!

## 📝 Notes

- **First time?** The installation script will download the server JAR automatically
- **Memory**: Allocate at least 2GB for testing, 4GB+ for production
- **EULA**: Auto-accepted by default (can be disabled)
- **Performance**: Pre-configured with Aikar's optimized JVM flags

## 🆘 Need Help?

Check the full [README.md](README.md) for detailed documentation and troubleshooting.

---

**You're now ready to be the first to host Hytale servers! 🎉**
