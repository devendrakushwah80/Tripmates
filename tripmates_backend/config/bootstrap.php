<?php
use App\Config\Env;
use App\Helpers\Logger;
use App\Helpers\Response;
use App\Middleware\CorsMiddleware;
use App\Middleware\RateLimitMiddleware;

define('BASE_PATH', dirname(__DIR__));

require_once BASE_PATH . '/utils/Autoloader.php';
\App\Utils\Autoloader::register(BASE_PATH);

Env::load(BASE_PATH . '/.env');
date_default_timezone_set((string) Env::get('APP_TIMEZONE', 'UTC'));
set_time_limit(30);

set_exception_handler(function (Throwable $e): void {
    Logger::error('Unhandled exception', ['message' => $e->getMessage(), 'file' => $e->getFile(), 'line' => $e->getLine()]);
    $debug = Env::bool('APP_DEBUG', false);
    Response::json(false, $debug ? $e->getMessage() : 'Server error', $debug ? ['trace' => $e->getTrace()] : [], 500);
});

set_error_handler(function (int $severity, string $message, string $file, int $line): bool {
    throw new ErrorException($message, 0, $severity, $file, $line);
});

CorsMiddleware::handle();
RateLimitMiddleware::handle();
Logger::info('API request', [
    'method' => $_SERVER['REQUEST_METHOD'] ?? 'GET',
    'uri' => $_SERVER['REQUEST_URI'] ?? '/',
    'ip' => $_SERVER['REMOTE_ADDR'] ?? null,
]);
