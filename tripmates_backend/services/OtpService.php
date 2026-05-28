<?php
namespace App\Services;

use App\Config\Env;
use App\Models\OtpModel;

final class OtpService
{
    public function generate(int $userId, string $purpose, string $destination): array
    {
        $model = new OtpModel();
        $latest = $model->latestPending($userId, $purpose);
        $cooldown = (int) Env::get('OTP_RESEND_COOLDOWN_SECONDS', 60);
        if ($latest && strtotime((string) $latest['created_at']) > time() - $cooldown) {
            throw new \RuntimeException('Please wait before requesting another OTP');
        }

        $otp = (string) random_int(100000, 999999);
        $ttl = (int) Env::get('OTP_TTL_MINUTES', 10);
        $expires = date('Y-m-d H:i:s', strtotime("+{$ttl} minutes"));
        $model->create($userId, $purpose, $destination, password_hash($otp, PASSWORD_DEFAULT), $expires);

        $response = [
            'destination' => $destination,
            'expires_at' => $expires,
        ];
        if (Env::get('APP_ENV', 'production') === 'local' || Env::bool('APP_DEBUG', false)) {
            $response['otp_for_local_testing'] = $otp;
        }
        return $response;
    }

    public function verify(int $userId, string $purpose, string $otp): void
    {
        $model = new OtpModel();
        $row = $model->latestPending($userId, $purpose);
        if (!$row) {
            throw new \RuntimeException('No pending OTP found');
        }
        if (strtotime((string) $row['expires_at']) < time()) {
            throw new \RuntimeException('OTP expired');
        }
        if ((int) $row['attempts'] >= (int) Env::get('OTP_MAX_ATTEMPTS', 5)) {
            throw new \RuntimeException('OTP retry limit exceeded');
        }
        $model->incrementAttempts((int) $row['id']);
        if (!password_verify($otp, (string) $row['otp_hash'])) {
            throw new \RuntimeException('Invalid OTP');
        }
        $model->markVerified((int) $row['id']);
    }
}
