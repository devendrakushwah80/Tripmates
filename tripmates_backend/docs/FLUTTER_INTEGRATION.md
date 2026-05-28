# Flutter Integration

Use the Core PHP backend base URL:

```bash
flutter run --dart-define=TRIPMATES_API_BASE_URL=http://YOUR_PC_IP/tripmates_backend
```

For the shared Dio client:

```bash
flutter run --dart-define=APP_API_BASE_URL=http://YOUR_PC_IP/tripmates_backend/
```

On Android emulator, `10.0.2.2` can reach the host machine. On a real Android phone, use the PC LAN IP and keep phone and PC on the same Wi-Fi.

The PHP backend accepts direct endpoints like `login.php` and compatibility paths like `auth/login`.
