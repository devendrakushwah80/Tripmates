<?php
namespace App\Models;

class UserModel extends BaseModel
{
    public function create(array $data): int
    {
        $stmt = $this->db->prepare('INSERT INTO users (full_name,email,phone,password_hash,role,device_info) VALUES (:full_name,:email,:phone,:password_hash,:role,:device_info)');
        $stmt->execute([
            'full_name' => $data['full_name'],
            'email' => $data['email'],
            'phone' => $data['phone'],
            'password_hash' => $data['password_hash'],
            'role' => $data['role'] ?? 'passenger',
            'device_info' => $data['device_info'] ?? null,
        ]);
        return (int) $this->db->lastInsertId();
    }

    public function findByEmailOrPhone(string $login): ?array
    {
        $stmt = $this->db->prepare('SELECT * FROM users WHERE email = :email OR phone = :phone LIMIT 1');
        $stmt->execute(['email' => $login, 'phone' => $login]);
        return $stmt->fetch() ?: null;
    }

    public function findByEmail(string $email): ?array
    {
        $stmt = $this->db->prepare('SELECT * FROM users WHERE email = :email LIMIT 1');
        $stmt->execute(['email' => $email]);
        return $stmt->fetch() ?: null;
    }

    public function findById(int $id): ?array
    {
        $stmt = $this->db->prepare('SELECT * FROM users WHERE id = :id LIMIT 1');
        $stmt->execute(['id' => $id]);
        return $stmt->fetch() ?: null;
    }

    public function updateLastLogin(int $id): void
    {
        $stmt = $this->db->prepare('UPDATE users SET last_login_at = NOW(), updated_at = NOW() WHERE id = :id');
        $stmt->execute(['id' => $id]);
    }

    public function updatePassword(int $id, string $hash): void
    {
        $stmt = $this->db->prepare('UPDATE users SET password_hash = :hash, updated_at = NOW() WHERE id = :id');
        $stmt->execute(['hash' => $hash, 'id' => $id]);
    }

    public function updateImage(int $id, string $column, string $path): void
    {
        if (!in_array($column, ['profile_photo_path', 'selfie_image_path'], true)) {
            throw new \RuntimeException('Invalid image column');
        }
        $stmt = $this->db->prepare("UPDATE users SET {$column} = :path, updated_at = NOW() WHERE id = :id");
        $stmt->execute(['path' => $path, 'id' => $id]);
    }

    public function markOtpVerified(int $id, string $purpose): void
    {
        $column = $purpose === 'phone_verification' ? 'phone_verified_at' : 'email_verified_at';
        $stmt = $this->db->prepare("UPDATE users SET {$column} = NOW(), updated_at = NOW() WHERE id = :id");
        $stmt->execute(['id' => $id]);
    }

    public function completeProfile(int $id): void
    {
        $stmt = $this->db->prepare("UPDATE users SET verification_status = 'under_review', updated_at = NOW() WHERE id = :id");
        $stmt->execute(['id' => $id]);
    }
}
