<?php
namespace App\Models;

class DriverDocumentModel extends BaseModel
{
    public function upsert(int $userId, array $data): void
    {
        $stmt = $this->db->prepare(
            'INSERT INTO driver_documents (user_id,dl_front_path,dl_back_path,rc_path,review_status,rejection_reason,uploaded_at)
             VALUES (:user_id,:dl_front_path,:dl_back_path,:rc_path,:review_status,:rejection_reason,NOW())
             ON DUPLICATE KEY UPDATE
               dl_front_path = COALESCE(VALUES(dl_front_path), dl_front_path),
               dl_back_path = COALESCE(VALUES(dl_back_path), dl_back_path),
               rc_path = COALESCE(VALUES(rc_path), rc_path),
               review_status = VALUES(review_status),
               rejection_reason = VALUES(rejection_reason),
               uploaded_at = NOW(),
               updated_at = NOW()'
        );
        $stmt->execute([
            'user_id' => $userId,
            'dl_front_path' => $data['dl_front_path'] ?? null,
            'dl_back_path' => $data['dl_back_path'] ?? null,
            'rc_path' => $data['rc_path'] ?? null,
            'review_status' => $data['review_status'] ?? 'pending',
            'rejection_reason' => $data['rejection_reason'] ?? null,
        ]);
    }

    public function findByUser(int $userId): ?array
    {
        $stmt = $this->db->prepare('SELECT * FROM driver_documents WHERE user_id = :user_id LIMIT 1');
        $stmt->execute(['user_id' => $userId]);
        return $stmt->fetch() ?: null;
    }
}
