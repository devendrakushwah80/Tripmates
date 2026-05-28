<?php
namespace App\Services;

use App\Helpers\UploadHelper;
use App\Models\ActivityLogModel;
use App\Models\UploadModel;

final class UploadService
{
    public function store(int $userId, string $type, array $file): array
    {
        $saved = UploadHelper::save($file, $type);
        (new UploadModel())->create($userId, $type, $saved);
        (new ActivityLogModel())->create($userId, 'upload_' . $type, ['path' => $saved['path']]);
        return $saved;
    }
}
