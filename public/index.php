<?php

use Illuminate\Foundation\Application;
use Illuminate\Http\Request;

define('LARAVEL_START', microtime(true));
define('ROOT_PATH', realpath(__DIR__ . '/../'));

// Determine if the application is in maintenance mode...
if (file_exists($maintenance = ROOT_PATH . '/storage/framework/maintenance.php')) {
    require $maintenance;
}

// Register the Composer autoloader...
require_once ROOT_PATH . '/vendor/autoload.php';

// Bootstrap Laravel and handle the request...
/** @var Application $app */
$app = require_once ROOT_PATH . '/bootstrap/app.php';

$app->handleRequest(Request::capture());
