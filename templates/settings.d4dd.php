<?php

$databases['default']['default'] = array (
  'database' => '##SITENAME##',
  'username' => 'drupal',
  'password' => 'drupal',
  'host' => '127.0.0.1',
  'port' => '3306',
  'driver' => 'mysql',
  'prefix' => '',
  'collation' => 'utf8mb4_general_ci',
);

$override = array_key_exists('WWW_ROOT', $_ENV) ;
if ($override === TRUE) {
  $databases['default']['default']['host'] = 'db';
}
