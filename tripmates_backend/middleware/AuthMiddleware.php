<?php
namespace App\Middleware;

use App\Helpers\JwtHelper;
use App\Helpers\Request;
use App\Helpers\Response;
use App\Models\UserModel;

final class AuthMiddleware
{
    public static function user(): array
    {
        $token = Request::bearerToken();
        if (!$token) {
            Response::error('Authentication token required', 401);
        }
        try {
            $payload = JwtHelper::decode($token);
            $user = (new UserModel())->findById((int) ($payload['sub'] ?? 0));
            if (!$user || $user['account_status'] !== 'active') {
                Response::error('Unauthorized', 401);
            }
            return $user;
        } catch (\Throwable $e) {
            Response::error($e->getMessage(), 401);
        }
    }
}
