<?php
namespace App\Models;

class VehicleModel extends BaseModel
{
    public function upsert(int $userId, array $data): int
    {
        $existing = $this->findByUser($userId);
        if ($existing) {
            $stmt = $this->db->prepare('UPDATE vehicles SET car_model=:car_model, car_color=:car_color, seat_count=:seat_count, rc_number=:rc_number, rc_image_path=COALESCE(:rc_image_path, rc_image_path), updated_at=NOW() WHERE user_id=:user_id');
            $stmt->execute([
                'car_model' => $data['car_model'],
                'car_color' => $data['car_color'],
                'seat_count' => $data['seat_count'],
                'rc_number' => $data['rc_number'],
                'rc_image_path' => $data['rc_image_path'] ?? null,
                'user_id' => $userId,
            ]);
            return (int) $existing['id'];
        }
        $stmt = $this->db->prepare('INSERT INTO vehicles (user_id,car_model,car_color,seat_count,rc_number,rc_image_path) VALUES (:user_id,:car_model,:car_color,:seat_count,:rc_number,:rc_image_path)');
        $stmt->execute([
            'user_id' => $userId,
            'car_model' => $data['car_model'],
            'car_color' => $data['car_color'],
            'seat_count' => $data['seat_count'],
            'rc_number' => $data['rc_number'],
            'rc_image_path' => $data['rc_image_path'] ?? null,
        ]);
        return (int) $this->db->lastInsertId();
    }

    public function findByUser(int $userId): ?array
    {
        $stmt = $this->db->prepare('SELECT * FROM vehicles WHERE user_id = :user_id ORDER BY id DESC LIMIT 1');
        $stmt->execute(['user_id' => $userId]);
        return $stmt->fetch() ?: null;
    }
}
