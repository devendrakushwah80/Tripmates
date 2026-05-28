<?php
namespace App\Helpers;

final class Response
{
    public static function json(bool $status, string $message, array $data = [], int $code = 200): void
    {
        if (!headers_sent()) {
            http_response_code($code);
            header('Content-Type: application/json; charset=utf-8');
            header('X-Content-Type-Options: nosniff');
        }
        echo json_encode(['status' => $status, 'message' => $message, 'data' => $data], JSON_UNESCAPED_SLASHES);
        exit;
    }

    public static function success(string $message, array $data = [], int $code = 200): void
    {
        self::json(true, $message, $data, $code);
    }

    public static function error(string $message, int $code = 400, array $data = []): void
    {
        self::json(false, $message, $data, $code);
    }
}
