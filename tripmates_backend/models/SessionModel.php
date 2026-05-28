<?php
namespace App\Models;

class SessionModel extends BaseModel
{
    public function create(int $userId, ?string $deviceInfo, string $jwtId, string $expiresAt): void
    {
        $stmt = $this->db->prepare('INSERT INTO user_sessions (user_id,device_info,ip_address,user_agent,jwt_id,expires_at) VALUES (:user_id,:device_info,:ip_address,:user_agent,:jwt_id,:expires_at)');
        $stmt->execute([
            'user_id' => $userId,
            'device_info' => $deviceInfo,
            'ip_address' => $_SERVER['REMOTE_ADDR'] ?? null,
            'user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? null,
            'jwt_id' => $jwtId,
            'expires_at' => $expiresAt,
        ]);
    }

    public function revokeUserSessions(int $userId): void
    {
        $stmt = $this->db->prepare('UPDATE user_sessions SET revoked_at = NOW() WHERE user_id = :user_id AND revoked_at IS NULL');
        $stmt->execute(['user_id' => $userId]);
    }
}
