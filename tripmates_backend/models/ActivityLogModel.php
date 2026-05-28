<?php
namespace App\Models;

class ActivityLogModel extends BaseModel
{
    public function create(?int $userId, string $action, array $metadata = []): void
    {
        $stmt = $this->db->prepare('INSERT INTO activity_logs (user_id,action,ip_address,user_agent,metadata) VALUES (:user_id,:action,:ip_address,:user_agent,:metadata)');
        $stmt->execute([
            'user_id' => $userId,
            'action' => $action,
            'ip_address' => $_SERVER['REMOTE_ADDR'] ?? null,
            'user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? null,
            'metadata' => json_encode($metadata, JSON_UNESCAPED_SLASHES),
        ]);
    }
}
