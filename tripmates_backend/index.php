<?php
require_once __DIR__ . '/config/bootstrap.php';

use App\Helpers\Request;
use App\Helpers\Response;

$routes = require BASE_PATH . '/routes/api.php';
$method = Request::method();
$path = parse_url($_SERVER['REQUEST_URI'] ?? '', PHP_URL_PATH) ?: '';
$endpoint = basename($path);

if ($endpoint === '' || $endpoint === 'tripmates_backend' || $endpoint === 'index.php') {
    Response::success('TripMates backend ready', ['docs' => 'docs/API.md']);
}

$handler = $routes[$method][$endpoint] ?? null;
if (!$handler && !str_ends_with($endpoint, '.php')) {
    $phpEndpoint = str_replace('-', '_', $endpoint) . '.php';
    $handler = $routes[$method][$phpEndpoint] ?? null;
}
if (!$handler) {
    Response::error('Endpoint not found', 404);
}

if (is_callable($handler)) {
    $handler();
}

[$class, $action] = $handler;
(new $class())->{$action}();
