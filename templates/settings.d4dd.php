<?php
$conf['search_api_solr_overrides'] = array(
  'pantheon_solr' => array(
    'name' => 'pantheon_solr',
    'options' => array(
      'host' => 'solr',
      'port' => 8983,
      'path' => '/solr',
    ),
  ),
);

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

if (!array_key_exists('hash_salt', $settings)) {
  $settings['hash_salt'] = 'changeme';
}

