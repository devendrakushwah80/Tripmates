<?php
use App\Controllers\AuthController;
use App\Controllers\DriverController;
use App\Controllers\UploadController;
use App\Controllers\UserController;

return [
    'POST' => [
        'register.php' => [AuthController::class, 'register'],
        'login.php' => [AuthController::class, 'login'],
        'verify_otp.php' => [AuthController::class, 'verifyOtp'],
        'resend_otp.php' => [AuthController::class, 'resendOtp'],
        'forgot_password.php' => [AuthController::class, 'forgotPassword'],
        'reset_password.php' => [AuthController::class, 'resetPassword'],
        'change_password.php' => [AuthController::class, 'changePassword'],
        'refresh_token.php' => [AuthController::class, 'refresh'],
        'upload_profile.php' => [UploadController::class, 'profile'],
        'upload_selfie.php' => [UploadController::class, 'selfie'],
        'upload_driver_documents.php' => [DriverController::class, 'uploadDocuments'],
        'upload_rc.php' => [DriverController::class, 'uploadRc'],
        'vehicle_details.php' => [DriverController::class, 'vehicleDetails'],
        'complete_profile.php' => [DriverController::class, 'completeProfile'],
        'logout.php' => [AuthController::class, 'logout'],
    ],
    'GET' => [
        'me.php' => [UserController::class, 'me'],
        'health.php' => static function (): void {
            \App\Helpers\Response::success('TripMates API is healthy', ['time' => date('c')]);
        },
    ],
];
