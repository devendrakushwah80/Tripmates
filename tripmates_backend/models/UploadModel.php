<?php
namespace App\Models;

class UploadModel extends BaseModel
{
    public function create(int $userId, string $type, array $file): int
    {
        $stmt = $this->db->prepare('INSERT INTO uploads (user_id,upload_type,file_path,original_name,mime_type,file_size) VALUES (:user_id,:upload_type,:file_path,:original_name,:mime_type,:file_size)');
        $stmt->execute([
            'user_id' => $userId,
            'upload_type' => $type,
            'file_path' => $file['path'],
            'original_name' => $file['original_name'],
            'mime_type' => $file['mime_type'],
            'file_size' => $file['size'],
        ]);
        return (int) $this->db->lastInsertId();
    }
}
