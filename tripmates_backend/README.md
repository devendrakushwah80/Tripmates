# TripMates Backend

Core PHP 8 + MySQL REST API for the TripMates Flutter app. The backend is isolated from the Flutter project in `tripmates_backend`.

## XAMPP Setup

1. Copy or keep `tripmates_backend` under `htdocs`, for example `C:\xampp\htdocs\tripmates_backend`.
2. Start Apache and MySQL in XAMPP.
3. Create/import the database:
   - Open phpMyAdmin.
   - Import `database/schema.sql`.
   - Optionally import `database/seeds/seed.sql`.
4. Update `.env` with your DB credentials and a long `JWT_SECRET`.
5. Ensure PHP extensions are enabled: `pdo_mysql`, `fileinfo`, `gd`.
6. Test: `GET http://localhost/tripmates_backend/health.php`.

## Important URLs

- Base URL: `http://localhost/tripmates_backend`
- API docs: `docs/API.md`
- Postman collection: `docs/TripMates.postman_collection.json`

## Upload Folders

Uploaded files are stored under:

- `uploads/profile`
- `uploads/selfie`
- `uploads/dl`
- `uploads/rc`

Relative paths are saved in MySQL.

## Production Notes

- Set `APP_DEBUG=false`.
- Replace `JWT_SECRET`.
- Restrict `CORS_ALLOWED_ORIGINS`.
- Move uploads to private/object storage when deploying to VPS, AWS, DigitalOcean, or Docker.
- Put Apache/Nginx document root on `public` for stronger isolation.
