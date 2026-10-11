## Comprehensive Deployment Analysis: Win32/OpenGL Game Streaming Migration

| Metric | Target Value / Status |
|---|---|
| Source Engine | FOClassic / FOnline C++ Client (Win32 API Architecture) |
| Graphics Context | Desktop OpenGL Pipeline |
| WebAssembly Compatibility | Failed (Unsupported Win32 Core Hooks & Kernel Loops) |
| Production Solution | Selkies-Webrtc Container Pixel Streaming |
| Deployment Efficiency | High (Zero Core Code Modifications Required) |

------------------------------
## Part 1: Core Architectural Findings## Why the WebAssembly Pathways Failed
Traditional WebAssembly conversion strategies (Emscripten, Boxedwine, Wine-Assembly) assume an execution payload built entirely around isolated mathematical logic or ancient, software-driven 2D pixel routines.
When your compiled desktop ClientGL.exe executable was loaded inside client-side virtual machine shells, the process collapsed due to several architectural limitations:

* The Win32 Kernel Block: Your client code communicates directly with the Windows subsystem (CreateWindowEx, GetMessage, wglCreateContext). WebAssembly runs inside a highly restricted, secure browser sandbox that has no native understanding of an HWND pointer or a Windows messaging event thread loop.
* The Infinite Loop Freeze: Traditional game pipelines depend on sequential blocking logic (while(true) { tick(); render(); }). Running this format directly within a browser tab blocks the browser's single-threaded JavaScript execution loop. This freezes the application UI and causes the browser to kill the tab.
* The Graphics Engine Translation Gap: Web browsers do not understand native desktop OpenGL. They render elements exclusively using WebGL (modeled after OpenGL ES for mobile devices). Translating legacy fixed-function loops into valid shader structures through virtualized layers creates memory allocation faults and causes the browser engine to close.

## Why Container Pixel Streaming works
Instead of trying to compile your codebase into web-native languages, Pixel Streaming leaves your native Windows binary completely intact.
The application compiles natively in Visual Studio 2026 as an .exe file. The server engine handles the execution thread inside a dedicated Linux container running a high-performance Wine translation layer. The system captures the desktop audio/video outputs and streams them securely via WebRTC straight onto a standard HTML5 <video> element canvas on the player's web browser page, with no local client installation required.
------------------------------
## Part 2: Structural Verification (The Local Workspace Folder Layout)
Before firing up the pipeline engine, your storage workspace directory on your hard drive must match this exact folder structure layout to ensure dependencies route correctly:

C:\Games\FOnlineServer\foclassic7\Client\
├── ClientGL.exe      <-- Your main compiled C++ application binary execution entry point
├── FOnline.cfg        <-- The configuration file managing server IP endpoints
├── data/              <-- Subfolder holding game world maps, items, and UI sprites
├── text/              <-- Subfolder holding localized dialogue string packages
└── [Other DLLs]       <-- Extension libraries required for engine startup loops

------------------------------
## Part 3: Step-by-Step Server Engine Deployment Guide## 1. Setup the Network Target Link
Because the client inside the container runs inside an isolated virtual network subsystem, pointing its inner configurations to localhost or 127.0.0.1 will cause it to search inside itself and return a connection dropped exception.
To link up to your active game server thread listening at port 2238:

   1. Open your terminal console on Windows and run the ipconfig command.
   2. Locate the vEthernet (WSL) network interface configuration card. Copy the assigned IPv4 Address (typically 172.29.240.1).
   3. Open your client configuration file (FOnline.cfg or your engine's target config file) in Notepad and map the server destination strings exactly like this:
   
   ServerAddress = 172.29.240.1
   ServerPort = 2238
   
   4. Save and close the file.

## 2. Clean out old Container Instances
To prevent port mapping conflicts or naming layout blockades inside Docker Desktop, wipe out any residual background tasks using this command block:

docker rm -f game-stream

## 3. Spin up the Production Stream Environment
Triple-click this single-line command block below to capture it completely, copy it, and paste it straight into your Command Prompt window to launch your hardware-friendly rendering container:

docker run -d --name game-stream --shm-size=2g -p 3001:3001 -v "C:\Games\FOnlineServer\foclassic7\Client:/config/Desktop/MyGame" -e WINE_CSMT=1 lscr.io/linuxserver/winegui:latest

------------------------------
## Part 4: Production Configuration and Performance Optimizations## Game Launch Optimization Workflow
Once the container layout returns its unique ID hash signature string inside your console, open your browser and navigate strictly to this destination URL:
👉 https://localhost:3001 (Note: The s is required for HTTPS).

   1. Bypass the browser certificate warning by clicking Advanced -> Proceed to localhost (unsafe).
   2. Log in using the built-in system secure profile fields if prompted:
   * Username: abc
      * Password: abc
   3. Open the terminal utility sitting inside the browser desktop space and jump into your mounted directory using this location path command:
   
   cd /config/Desktop/MyGame
   
   4. Execute the system wrapper configuration to launch the engine canvas safely:
   
   wine ClientGL.exe
   
   
## Correcting the Cursor Drag Lag
Because the game engine draws its own custom retro point cursor sprites inside its application window frame, you may feel an input delay as your Windows pointer drags the game's custom cursor over the network video feed.
To restore native, low-latency mouse interactions:

   1. Move your cursor to the left edge of your web browser tab to slide open the hidden Selkies Settings Sidebar menu panel.
   2. Expand the SCREEN SETTINGS or INPUT CONFIG parameters dropdown.
   3. Locate the toggle switch option labeled "Relative Mouse Mode" or "Pointer Lock" and flip it to ON.
   * The Mechanism: This locks your native cursor inside the canvas boundaries and streams raw, ultra-low-latency mouse movement data directly to Wine. This aligns the pointer coordinates perfectly and makes gameplay responsive. (Press the Esc key at any time to unlock your mouse from the browser window).
   4. Go to the sidebar's MOUSE SETTINGS drawer and toggle "Hide Local Cursor" to hide the browser's default white cursor. This leaves only your game's retro cursor visible on the screen.

## Frame Rate (FPS) Boost Settings
If the map viewport frame updates slowly when traversing grid maps, pass the environment flag -e WINE_CSMT=1 during your initialization stage. This instructs the translation engine to decouple rendering calls from the core application logic loops, passing execution blocks cleanly across separate background calculation queues to optimize WebGL video stream rendering speeds.
------------------------------
## Summary Verification Schema

[Windows Host Server Process (Port 2238)]
                     ▲
                     │ (WSL Network Bridge Interface: 172.29.240.1)
                     ▼
[Docker Container Containerized Shell Workspace]
  ├── Wine Subsystem Runtime (Translates Win32 Logic Loops)
  └── Selkies Video Encoder (Captures Engine Render Buffers)
                     ▲
                     │ (Secure WebRTC / WebSocket Link: Port 3001)
                     ▼
[Web Browser Interface Canvas (HTML5 Video Layer Viewport Display)]

This complete report is ready for your project archives. If you decide to look into a automated deployment later, let me know if you want to explore building a production Dockerfile to launch the game client automatically in Kiosk Mode on page load, or how to route the WebSockets securely via an Nginx reverse proxy.

