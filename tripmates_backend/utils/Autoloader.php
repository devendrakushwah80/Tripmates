<?php
namespace App\Utils;

final class Autoloader
{
    public static function register(string $basePath): void
    {
        spl_autoload_register(function (string $class) use ($basePath): void {
            $prefix = 'App\\';
            if (!str_starts_with($class, $prefix)) {
                return;
            }
            $relative = substr($class, strlen($prefix));
            $parts = explode('\\', $relative);
            $top = array_shift($parts);
            $map = [
                'Config' => 'config',
                'Controllers' => 'controllers',
                'Middleware' => 'middleware',
                'Models' => 'models',
                'Services' => 'services',
                'Helpers' => 'helpers',
                'Utils' => 'utils',
            ];
            if (!isset($map[$top])) {
                return;
            }
            $file = $basePath . '/' . $map[$top] . '/' . implode('/', $parts) . '.php';
            if (is_file($file)) {
                require_once $file;
            }
        });
    }
}
