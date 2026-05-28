<?php
namespace App\Models;

class RefreshTokenModel extends BaseModel
{
    public function create(int $userId, string $plainToken, string $expiresAt): int
    {
        $stmt = $this->db->prepare('INSERT INTO refresh_tokens (user_id, token_hash, expires_at) VALUES (:user_id,:token_hash,:expires_at)');
        $stmt->execute([
            'user_id' => $userId,
            'token_hash' => hash('sha256', $plainToken),
            'expires_at' => $expiresAt,
        ]);
        return (int) $this->db->lastInsertId();
    }

    public function findValid(string $plainToken): ?array
    {
        $stmt = $this->db->prepare('SELECT * FROM refresh_tokens WHERE token_hash = :hash AND revoked_at IS NULL AND expires_at > NOW() LIMIT 1');
        $stmt->execute(['hash' => hash('sha256', $plainToken)]);
        return $stmt->fetch() ?: null;
    }

    public function revoke(string $plainToken): void
    {
        $stmt = $this->db->prepare('UPDATE refresh_tokens SET revoked_at = NOW() WHERE token_hash = :hash AND revoked_at IS NULL');
        $stmt->execute(['hash' => hash('sha256', $plainToken)]);
    }

    public function revokeAllForUser(int $userId): void
    {
        $stmt = $this->db->prepare('UPDATE refresh_tokens SET revoked_at = NOW() WHERE user_id = :user_id AND revoked_at IS NULL');
        $stmt->execute(['user_id' => $userId]);
    }
}
