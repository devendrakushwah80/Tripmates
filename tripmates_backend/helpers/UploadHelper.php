<?php
namespace App\Helpers;

use App\Config\Env;

final class UploadHelper
{
    private const ALLOWED = [
        'image/jpeg' => 'jpg',
        'image/png' => 'png',
        'image/webp' => 'webp',
    ];

    public static function save(array $file, string $type): array
    {
        if (($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK) {
            throw new \RuntimeException('Upload failed');
        }
        $maxBytes = (int) Env::get('MAX_UPLOAD_MB', 5) * 1024 * 1024;
        if (($file['size'] ?? 0) > $maxBytes) {
            throw new \RuntimeException('File exceeds maximum allowed size');
        }

        $folders = ['profile' => 'profile', 'selfie' => 'selfie', 'dl' => 'dl', 'rc' => 'rc'];
        if (!isset($folders[$type])) {
            throw new \RuntimeException('Invalid upload type');
        }

        $tmp = (string) $file['tmp_name'];
        $mime = (new \finfo(FILEINFO_MIME_TYPE))->file($tmp);
        if (!isset(self::ALLOWED[$mime])) {
            throw new \RuntimeException('Invalid file type');
        }
        if (@getimagesize($tmp) === false) {
            throw new \RuntimeException('Invalid image file');
        }

        $filename = bin2hex(random_bytes(18)) . '.jpg';
        $dir = BASE_PATH . '/uploads/' . $folders[$type];
        if (!is_dir($dir)) {
            mkdir($dir, 0755, true);
        }
        $target = $dir . '/' . $filename;
        self::compressToJpeg($tmp, $mime, $target);

        return [
            'path' => 'uploads/' . $folders[$type] . '/' . $filename,
            'original_name' => basename((string) $file['name']),
            'mime_type' => 'image/jpeg',
            'size' => filesize($target) ?: 0,
        ];
    }

    private static function compressToJpeg(string $tmp, string $mime, string $target): void
    {
        $image = match ($mime) {
            'image/png' => imagecreatefrompng($tmp),
            'image/webp' => imagecreatefromwebp($tmp),
            default => imagecreatefromjpeg($tmp),
        };
        if (!$image) {
            throw new \RuntimeException('Could not process image');
        }
        imagejpeg($image, $target, 82);
        imagedestroy($image);
        chmod($target, 0644);
    }
}
