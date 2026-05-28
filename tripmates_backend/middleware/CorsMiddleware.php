<?php
namespace App\Middleware;

use App\Config\Env;

final class CorsMiddleware
{
    public static function handle(): void
    {
        $allowed = (string) Env::get('CORS_ALLOWED_ORIGINS', '*');
        header('Access-Control-Allow-Origin: ' . $allowed);
        header('Access-Control-Allow-Headers: Authorization, Content-Type, Accept, X-Requested-With');
        header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
        header('Access-Control-Max-Age: 86400');
        if (($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') {
            http_response_code(204);
            exit;
        }
    }
}
