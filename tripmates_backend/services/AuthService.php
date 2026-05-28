<?php
namespace App\Services;

use App\Config\Env;
use App\Helpers\JwtHelper;
use App\Models\RefreshTokenModel;
use App\Models\SessionModel;
use App\Models\UserModel;

final class AuthService
{
    public function requestPasswordReset(string $email): array
    {
        $user = (new UserModel())->findByEmail($email);
        if (!$user) {
            return ['user_exists' => false];
        }

        $otp = (new OtpService())->generate((int) $user['id'], 'password_reset', (string) $user['email']);

        return [
            'user_exists' => true,
            'user_id' => (int) $user['id'],
            'otp' => $otp,
        ];
    }

    public function issueTokens(int $userId, ?string $deviceInfo = null): array
    {
        $jwtId = bin2hex(random_bytes(16));
        $ttl = (int) Env::get('JWT_TTL_SECONDS', 3600);
        $access = JwtHelper::encode(['sub' => $userId, 'jti' => $jwtId], $ttl);
        $refresh = bin2hex(random_bytes(40));
        $refreshDays = (int) Env::get('REFRESH_TOKEN_TTL_DAYS', 30);
        $refreshExpires = date('Y-m-d H:i:s', strtotime("+{$refreshDays} days"));
        (new RefreshTokenModel())->create($userId, $refresh, $refreshExpires);
        (new SessionModel())->create($userId, $deviceInfo, $jwtId, date('Y-m-d H:i:s', time() + $ttl));

        return [
            'access_token' => $access,
            'refresh_token' => $refresh,
            'token_type' => 'Bearer',
            'expires_in' => $ttl,
        ];
    }

    public function rotateRefreshToken(string $refreshToken, ?string $deviceInfo = null): array
    {
        $model = new RefreshTokenModel();
        $existing = $model->findValid($refreshToken);
        if (!$existing) {
            throw new \RuntimeException('Invalid refresh token');
        }
        $model->revoke($refreshToken);
        return $this->issueTokens((int) $existing['user_id'], $deviceInfo);
    }
}
