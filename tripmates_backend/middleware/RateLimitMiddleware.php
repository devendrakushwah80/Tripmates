<?php
namespace App\Middleware;

use App\Config\Env;
use App\Helpers\Request;
use App\Helpers\Response;

final class RateLimitMiddleware
{
    public static function handle(): void
    {
        $limit = (int) Env::get('RATE_LIMIT_PER_MINUTE', 60);
        $key = preg_replace('/[^a-zA-Z0-9_.-]/', '_', Request::clientIp());
        $file = BASE_PATH . '/storage/rate_limits/' . $key . '.json';
        $now = time();
        $bucket = ['window' => $now, 'count' => 0];
        if (is_file($file)) {
            $bucket = json_decode(file_get_contents($file) ?: '{}', true) ?: $bucket;
        }
        if (($bucket['window'] ?? 0) < $now - 60) {
            $bucket = ['window' => $now, 'count' => 0];
        }
        $bucket['count']++;
        file_put_contents($file, json_encode($bucket), LOCK_EX);
        if ($bucket['count'] > $limit) {
            Response::error('Too many requests. Please try again later.', 429);
        }
    }
}
