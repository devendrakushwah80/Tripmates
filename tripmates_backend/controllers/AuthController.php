<?php
namespace App\Controllers;

use App\Helpers\Request;
use App\Helpers\Response;
use App\Helpers\Validator;
use App\Config\Env;
use App\Middleware\AuthMiddleware;
use App\Models\ActivityLogModel;
use App\Models\RefreshTokenModel;
use App\Models\SessionModel;
use App\Models\UserModel;
use App\Services\AuthService;
use App\Services\OtpService;

final class AuthController
{
    public function register(): void
    {
        $data = Request::input();
        if (empty($data['full_name']) && !empty($data['name'])) {
            $data['full_name'] = $data['name'];
        }
        $data['role'] = $data['role'] ?? 'passenger';
        $errors = Validator::validate($data, [
            'full_name' => 'required|max:120',
            'email' => 'required|email|max:190',
            'phone' => 'required|max:30',
            'password' => 'required|min:8|max:100',
            'role' => 'required|in:driver,passenger',
        ]);
        if ($errors) {
            Response::error('Validation failed', 422, ['errors' => $errors]);
        }

        $users = new UserModel();
        if ($users->findByEmailOrPhone($data['email']) || $users->findByEmailOrPhone($data['phone'])) {
            Response::error('Email or phone already registered', 409);
        }

        $userId = $users->create([
            'full_name' => $data['full_name'],
            'email' => strtolower($data['email']),
            'phone' => $data['phone'],
            'password_hash' => password_hash($data['password'], PASSWORD_DEFAULT),
            'role' => $data['role'],
            'device_info' => $data['device_info'] ?? null,
        ]);
        $otp = (new OtpService())->generate($userId, 'phone_verification', $data['phone']);
        (new ActivityLogModel())->create($userId, 'register');
        Response::success('Registration successful. OTP generated.', ['user_id' => $userId, 'otp' => $otp], 201);
    }

    public function login(): void
    {
        $data = Request::input();
        if (empty($data['login']) && !empty($data['email'])) {
            $data['login'] = $data['email'];
        }
        $errors = Validator::validate($data, ['login' => 'required|max:190', 'password' => 'required']);
        if ($errors) {
            Response::error('Validation failed', 422, ['errors' => $errors]);
        }
        $user = (new UserModel())->findByEmailOrPhone($data['login']);
        if (!$user || !password_verify($data['password'], $user['password_hash'])) {
            Response::error('Invalid credentials', 401);
        }
        if ($user['account_status'] !== 'active') {
            Response::error('Account is not active', 403);
        }
        (new UserModel())->updateLastLogin((int) $user['id']);
        $tokens = (new AuthService())->issueTokens((int) $user['id'], $data['device_info'] ?? null);
        (new ActivityLogModel())->create((int) $user['id'], 'login');
        unset($user['password_hash']);
        Response::success('Login successful', ['user' => $user, 'tokens' => $tokens]);
    }

    public function verifyOtp(): void
    {
        $data = Request::input();
        $errors = Validator::validate($data, ['user_id' => 'required|int', 'otp' => 'required|min:6|max:6']);
        if ($errors) {
            Response::error('Validation failed', 422, ['errors' => $errors]);
        }
        $purpose = $data['purpose'] ?? 'phone_verification';
        (new OtpService())->verify((int) $data['user_id'], $purpose, $data['otp']);
        (new UserModel())->markOtpVerified((int) $data['user_id'], $purpose);
        (new ActivityLogModel())->create((int) $data['user_id'], 'verify_otp', ['purpose' => $purpose]);
        Response::success('OTP verified successfully');
    }

    public function resendOtp(): void
    {
        $data = Request::input();
        $errors = Validator::validate($data, ['user_id' => 'required|int']);
        if ($errors) {
            Response::error('Validation failed', 422, ['errors' => $errors]);
        }
        $user = (new UserModel())->findById((int) $data['user_id']);
        if (!$user) {
            Response::error('User not found', 404);
        }
        $purpose = $data['purpose'] ?? 'phone_verification';
        $destination = $purpose === 'email_verification' ? $user['email'] : $user['phone'];
        $otp = (new OtpService())->generate((int) $user['id'], $purpose, $destination);
        Response::success('OTP resent successfully', ['otp' => $otp]);
    }

    public function forgotPassword(): void
    {
        $data = Request::input();
        $errors = Validator::validate($data, ['email' => 'required|email']);
        if ($errors) {
            Response::error('Validation failed', 422, ['errors' => $errors]);
        }

        $result = (new AuthService())->requestPasswordReset(strtolower($data['email']));
        if (!$result['user_exists']) {
            if (Env::get('APP_ENV', 'production') === 'local') {
                Response::error('User not found', 404);
            }
            Response::success('If account exists, reset instructions were sent');
        }

        Response::success('Password reset OTP generated', [
            'user_id' => $result['user_id'],
            'otp' => $result['otp'],
        ]);
    }

    public function resetPassword(): void
    {
        $data = Request::input();
        $errors = Validator::validate($data, ['user_id' => 'required|int', 'otp' => 'required|min:6|max:6', 'password' => 'required|min:8|max:100']);
        if ($errors) {
            Response::error('Validation failed', 422, ['errors' => $errors]);
        }
        (new OtpService())->verify((int) $data['user_id'], 'password_reset', $data['otp']);
        (new UserModel())->updatePassword((int) $data['user_id'], password_hash($data['password'], PASSWORD_DEFAULT));
        (new ActivityLogModel())->create((int) $data['user_id'], 'reset_password');
        Response::success('Password reset successful');
    }

    public function changePassword(): void
    {
        $user = AuthMiddleware::user();
        $data = Request::input();
        $errors = Validator::validate($data, ['current_password' => 'required', 'new_password' => 'required|min:8|max:100']);
        if ($errors) {
            Response::error('Validation failed', 422, ['errors' => $errors]);
        }
        if (!password_verify($data['current_password'], $user['password_hash'])) {
            Response::error('Current password is incorrect', 422);
        }
        (new UserModel())->updatePassword((int) $user['id'], password_hash($data['new_password'], PASSWORD_DEFAULT));
        (new ActivityLogModel())->create((int) $user['id'], 'change_password');
        Response::success('Password changed successfully');
    }

    public function refresh(): void
    {
        $data = Request::input();
        $errors = Validator::validate($data, ['refresh_token' => 'required']);
        if ($errors) {
            Response::error('Validation failed', 422, ['errors' => $errors]);
        }
        $tokens = (new AuthService())->rotateRefreshToken($data['refresh_token'], $data['device_info'] ?? null);
        Response::success('Token refreshed', ['tokens' => $tokens]);
    }

    public function logout(): void
    {
        $user = AuthMiddleware::user();
        $data = Request::input();
        if (!empty($data['refresh_token'])) {
            (new RefreshTokenModel())->revoke($data['refresh_token']);
        } else {
            (new RefreshTokenModel())->revokeAllForUser((int) $user['id']);
            (new SessionModel())->revokeUserSessions((int) $user['id']);
        }
        (new ActivityLogModel())->create((int) $user['id'], 'logout');
        Response::success('Logged out successfully');
    }
}
