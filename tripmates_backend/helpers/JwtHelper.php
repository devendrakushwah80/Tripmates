<?php
namespace App\Helpers;

use App\Config\Env;

final class JwtHelper
{
    public static function encode(array $payload, ?int $ttlSeconds = null): string
    {
        $now = time();
        $payload = array_merge($payload, [
            'iat' => $now,
            'exp' => $now + ($ttlSeconds ?? (int) Env::get('JWT_TTL_SECONDS', 3600)),
            'iss' => Env::get('APP_URL', 'tripmates'),
        ]);
        $header = ['typ' => 'JWT', 'alg' => 'HS256'];
        $segments = [self::b64(json_encode($header)), self::b64(json_encode($payload))];
        $segments[] = self::sign(implode('.', $segments));
        return implode('.', $segments);
    }

    public static function decode(string $jwt): array
    {
        $parts = explode('.', $jwt);
        if (count($parts) !== 3) {
            throw new \RuntimeException('Invalid token');
        }
        [$header, $payload, $signature] = $parts;
        if (!hash_equals(self::sign($header . '.' . $payload), $signature)) {
            throw new \RuntimeException('Invalid token signature');
        }
        $data = json_decode(self::unb64($payload), true);
        if (!is_array($data) || ($data['exp'] ?? 0) < time()) {
            throw new \RuntimeException('Token expired');
        }
        return $data;
    }

    private static function sign(string $data): string
    {
        return self::b64(hash_hmac('sha256', $data, (string) Env::get('JWT_SECRET'), true));
    }

    private static function b64(string $data): string
    {
        return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
    }

    private static function unb64(string $data): string
    {
        return base64_decode(strtr($data, '-_', '+/')) ?: '';
    }
}
