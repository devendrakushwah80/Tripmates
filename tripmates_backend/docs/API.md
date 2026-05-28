# TripMates API

Base URL for XAMPP: `http://localhost/tripmates_backend`

All responses follow:

```json
{"status": true, "message": "Message", "data": {}}
```

Protected endpoints require `Authorization: Bearer <access_token>`.

## Auth

### POST `/register.php`
JSON/body fields: `full_name`, `email`, `phone`, `password`, `role` (`driver` or `passenger`), optional `device_info`.

### POST `/login.php`
Fields: `login` (email or phone), `password`, optional `device_info`.

### POST `/verify_otp.php`
Fields: `user_id`, `otp`, optional `purpose` (`phone_verification`, `email_verification`, `password_reset`).

### POST `/resend_otp.php`
Fields: `user_id`, optional `purpose`.

### POST `/forgot_password.php`
Fields: `email`.

Local environment behavior (`APP_ENV=local`): unknown email returns `404` with `{"status":false,"message":"User not found"}`.

Production behavior (`APP_ENV=production`): unknown email returns the generic success message `If account exists, reset instructions were sent` and does not generate an OTP.

### POST `/reset_password.php`
Fields: `user_id`, `otp`, `password`.

### POST `/change_password.php`
Protected. Fields: `current_password`, `new_password`.

### POST `/refresh_token.php`
Fields: `refresh_token`, optional `device_info`.

### POST `/logout.php`
Protected. Optional field: `refresh_token`. Without it, all user refresh tokens/sessions are revoked.

## Profile

### GET `/me.php`
Protected. Returns user, driver documents, and vehicle data.

### POST `/upload_profile.php`
Protected multipart. File field: `profile_photo`, `profile`, `file`, or `image`.

### POST `/upload_selfie.php`
Protected multipart. File field: `selfie`, `selfie_image`, `file`, or `image`.

## Driver Flow

### POST `/upload_driver_documents.php`
Protected multipart. File fields: `dl_front` required, `dl_back` optional.

### POST `/upload_rc.php`
Protected multipart. File field: `rc`, `rc_image`, `file`, or `image`.

### POST `/vehicle_details.php`
Protected JSON, form, or multipart. Fields: `car_model`, `car_color`, `seat_count`, `rc_number`; optional RC file.

### POST `/complete_profile.php`
Protected. Marks profile as `under_review`.

## Local OTP Behavior

The current OTP service stores hashed OTPs and returns `otp_for_local_testing` in local API responses so the Flutter flow can be tested without SMS/email. Replace that return behavior with an SMS/email provider adapter before production.
