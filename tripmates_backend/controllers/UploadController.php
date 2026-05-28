<?php
namespace App\Controllers;

use App\Helpers\Response;
use App\Middleware\AuthMiddleware;
use App\Models\UserModel;
use App\Services\UploadService;

final class UploadController
{
    public function profile(): void
    {
        $user = AuthMiddleware::user();
        $file = $this->file(['profile_photo', 'profile', 'file', 'image']);
        $saved = (new UploadService())->store((int) $user['id'], 'profile', $file);
        (new UserModel())->updateImage((int) $user['id'], 'profile_photo_path', $saved['path']);
        Response::success('Profile photo uploaded', ['path' => $saved['path']]);
    }

    public function selfie(): void
    {
        $user = AuthMiddleware::user();
        $file = $this->file(['selfie', 'selfie_image', 'file', 'image']);
        $saved = (new UploadService())->store((int) $user['id'], 'selfie', $file);
        (new UserModel())->updateImage((int) $user['id'], 'selfie_image_path', $saved['path']);
        Response::success('Selfie uploaded', ['path' => $saved['path']]);
    }

    private function file(array $names): array
    {
        foreach ($names as $name) {
            if (!empty($_FILES[$name])) {
                return $_FILES[$name];
            }
        }
        Response::error('Upload file is required', 422);
    }
}
