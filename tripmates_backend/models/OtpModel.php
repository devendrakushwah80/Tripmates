<?php
namespace App\Models;

class OtpModel extends BaseModel
{
    public function create(int $userId, string $purpose, string $destination, string $otpHash, string $expiresAt): int
    {
        $stmt = $this->db->prepare('INSERT INTO otp_verifications (user_id,purpose,destination,otp_hash,expires_at) VALUES (:user_id,:purpose,:destination,:otp_hash,:expires_at)');
        $stmt->execute([
            'user_id' => $userId,
            'purpose' => $purpose,
            'destination' => $destination,
            'otp_hash' => $otpHash,
            'expires_at' => $expiresAt,
        ]);
        return (int) $this->db->lastInsertId();
    }

    public function latestPending(int $userId, string $purpose): ?array
    {
        $stmt = $this->db->prepare("SELECT * FROM otp_verifications WHERE user_id = :user_id AND purpose = :purpose AND verified_at IS NULL ORDER BY id DESC LIMIT 1");
        $stmt->execute(['user_id' => $userId, 'purpose' => $purpose]);
        return $stmt->fetch() ?: null;
    }

    public function incrementAttempts(int $id): void
    {
        $stmt = $this->db->prepare('UPDATE otp_verifications SET attempts = attempts + 1 WHERE id = :id');
        $stmt->execute(['id' => $id]);
    }

    public function markVerified(int $id): void
    {
        $stmt = $this->db->prepare('UPDATE otp_verifications SET verified_at = NOW() WHERE id = :id');
        $stmt->execute(['id' => $id]);
    }

    public function cleanupExpired(): void
    {
        $stmt = $this->db->prepare('DELETE FROM otp_verifications WHERE expires_at < DATE_SUB(NOW(), INTERVAL 7 DAY)');
        $stmt->execute();
    }
}
