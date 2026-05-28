<?php
namespace App\Controllers;

use App\Helpers\Request;
use App\Helpers\Response;
use App\Helpers\Validator;
use App\Middleware\AuthMiddleware;
use App\Models\ActivityLogModel;
use App\Models\DriverDocumentModel;
use App\Models\UserModel;
use App\Models\VehicleModel;
use App\Services\UploadService;

final class DriverController
{
    public function uploadDocuments(): void
    {
        $user = AuthMiddleware::user();
        $service = new UploadService();
        $payload = ['review_status' => 'pending'];
        if ($file = $this->optionalFile(['dl_front', 'dl_front_image', 'front'])) {
            $payload['dl_front_path'] = $service->store((int) $user['id'], 'dl', $file)['path'];
        }
        if ($file = $this->optionalFile(['dl_back', 'dl_back_image', 'back'])) {
            $payload['dl_back_path'] = $service->store((int) $user['id'], 'dl', $file)['path'];
        }
        if (empty($payload['dl_front_path']) || empty($payload['dl_back_path'])) {
            Response::error('DL front and back images are required', 422);
        }
        (new DriverDocumentModel())->upsert((int) $user['id'], $payload);
        Response::success('Driver documents uploaded', $payload);
    }

    public function uploadRc(): void
    {
        $user = AuthMiddleware::user();
        $file = $this->requiredFile(['rc', 'rc_image', 'file', 'image']);
        $saved = (new UploadService())->store((int) $user['id'], 'rc', $file);
        (new DriverDocumentModel())->upsert((int) $user['id'], ['rc_path' => $saved['path'], 'review_status' => 'pending']);
        Response::success('RC uploaded', ['path' => $saved['path']]);
    }

    public function vehicleDetails(): void
    {
        $user = AuthMiddleware::user();
        $data = Request::input();
        $errors = Validator::validate($data, [
            'car_model' => 'required|max:120',
            'car_color' => 'required|max:60',
            'seat_count' => 'required|int',
            'rc_number' => 'required|max:80',
        ]);
        if ($errors) {
            Response::error('Validation failed', 422, ['errors' => $errors]);
        }
        if ($file = $this->optionalFile(['rc', 'rc_image', 'file', 'image'])) {
            $data['rc_image_path'] = (new UploadService())->store((int) $user['id'], 'rc', $file)['path'];
            (new DriverDocumentModel())->upsert((int) $user['id'], ['rc_path' => $data['rc_image_path'], 'review_status' => 'pending']);
        }
        $vehicleId = (new VehicleModel())->upsert((int) $user['id'], [
            'car_model' => $data['car_model'],
            'car_color' => $data['car_color'],
            'seat_count' => (int) $data['seat_count'],
            'rc_number' => $data['rc_number'],
            'rc_image_path' => $data['rc_image_path'] ?? null,
        ]);
        (new ActivityLogModel())->create((int) $user['id'], 'vehicle_details_saved');
        Response::success('Vehicle details saved', ['vehicle_id' => $vehicleId]);
    }

    public function completeProfile(): void
    {
        $user = AuthMiddleware::user();
        (new UserModel())->completeProfile((int) $user['id']);
        (new ActivityLogModel())->create((int) $user['id'], 'complete_profile');
        Response::success('Profile submitted for review');
    }

    private function optionalFile(array $names): ?array
    {
        foreach ($names as $name) {
            if (!empty($_FILES[$name]) && ($_FILES[$name]['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE) {
                return $_FILES[$name];
            }
        }
        return null;
    }

    private function requiredFile(array $names): array
    {
        return $this->optionalFile($names) ?? Response::error('Upload file is required', 422);
    }
}
