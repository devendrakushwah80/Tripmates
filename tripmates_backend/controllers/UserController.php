<?php
namespace App\Controllers;

use App\Helpers\Response;
use App\Middleware\AuthMiddleware;
use App\Models\DriverDocumentModel;
use App\Models\VehicleModel;

final class UserController
{
    public function me(): void
    {
        $user = AuthMiddleware::user();
        unset($user['password_hash']);
        $docs = (new DriverDocumentModel())->findByUser((int) $user['id']);
        $vehicle = (new VehicleModel())->findByUser((int) $user['id']);
        Response::success('Profile fetched successfully', ['user' => $user, 'driver_documents' => $docs, 'vehicle' => $vehicle]);
    }
}
