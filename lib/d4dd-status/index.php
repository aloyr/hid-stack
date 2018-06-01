<a href="/opcache.php">Opcache status</a> <br>
<a href="/redis.php">Redis status</a> <br>
<br>
available sites: <br>
<?php foreach (glob('/var/www/*') as $folder): ?>
  <?php if (explode('/', $folder)[3] !== 'html'): ?>
    <?php $site = explode('/', $folder)[3] . '.test'; ?>
    <?php print '<a href="http://' . $site . '">' . $site . '</a><br>'; ?>
  <?php endif; ?>
<?php endforeach; ?>
 
