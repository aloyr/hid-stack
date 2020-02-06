<!DOCTYPE html>
<html>
<head>
  <link href="https://fonts.googleapis.com/css?family=Montserrat|Raleway" rel="stylesheet">
  <style>
    * { font-family: 'Raleway', sans-serif; }
    html { font-size: 16px; }
    h1, h2, h3, h4, h5, h6, .nav-item a { font-family: 'Montserrat', sans-serif; }
    body {
      margin: 0 auto;
      padding: 0;
    }
    .content {
      margin: 0 auto;
      max-width: 1200px;
    }
    .content-frame {
      height: auto;
      width: 100%;
    }
    .nav-wrapper {
      background: #f0f0f0;
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
    }
    .nav {
      display: flex;
      flex: 1 1 auto;
      list-style: none;
      margin: auto;
      max-width: 1200px;
      padding: 0;
      width: 100%;
    }
    .nav-item {
      background: #ddd;
      display: flex;
      margin-right: 20px;
      transition: 0.5s;
    }
    .nav-item:hover {
      background: #fafafa;
      box-shadow: 0 0 60px rgba(0,0,0,0.1) inset;
    }
    .nav-item a {
      color: #1f98e4;
      font-size: 1.2rem;
      font-weight: bold;
      padding: 20px 40px;
      text-decoration: none;
      text-shadow: 0 0 5px white, 0 0 2px white;
    }
    .site-wrapper {
      display: flex;
      flex-wrap: wrap;
    }
    .site {
      background: #f0f0f0;
      border-radius: 2px;
      box-shadow: none;
      color: #006eb3;
      font-size: 1.1rem;
      margin: 0 10px 10px 0;
      min-width: 150px;
      padding: 20px 10px;
      text-align: center;
      text-decoration: none;
      transition: 0.5s;
    }
    .site:hover {
      background: #fff;
      box-shadow: 0 0 5px #1f98e4;
    }
  </style>
</head>
<body>
  <div class="content-wrapper nav-wrapper">
      <ul class="nav content">
      <li class="nav-item nav-title"><a href="#">D4DD</a></li>
  <!--    <li class="nav-item"><a href="/opcache.php" target="content-frame">Opcache status</a></li>
      <li class="nav-item"><a href="/redis.php" target="content-frame">Redis status</a></li> -->
      <li class="nav-item"><a href="/opcache.php" id="opcache">Opcache status</a></li>
      <li class="nav-item"><a href="/redis.php" id="redis">Redis status</a></li>
      <li class="nav-item"><a href="#">Sites</a></li>
    </ul>
  </div>
  <br>
  <div class="content-wrapper">
    <div class="content">
      <h2>Available Sites:</h2>
      <section class="site-wrapper">
        <?php foreach (glob('/var/www/*') as $folder): ?>
          <?php if (explode('/', $folder)[3] !== 'html'): ?>
            <?php $site = explode('/', $folder)[3] . '.test'; ?>
            <?php print '<a class="site" href="http://' . $site . '">' . $site . '</a>'; ?>
          <?php endif; ?>
        <?php endforeach; ?>
      </section>
      <div id="support"></div>
    </div>
  </div>

  <!-- <iframe class="content-frame" name="content-frame" src="https://www.hidglobal.com" /> -->
  <script>
    (function() {
      function showRedis(e) {
        e.preventDefault();
        var xhr= new XMLHttpRequest();
        xhr.open('GET', 'redis.php', true);
        xhr.onreadystatechange= function() {
          if (this.readyState!==4) return;
            if (this.status!==200) return; // or whatever error handling you want
            document.getElementById('support').innerHTML= this.responseText;
        };
        xhr.send();
      }
      function showOpcache(e) {
        e.preventDefault();
        var xhr= new XMLHttpRequest();
        xhr.open('GET', 'opcache.php', true);
        xhr.onreadystatechange= function() {
          if (this.readyState!==4) return;
            if (this.status!==200) return; // or whatever error handling you want
            document.getElementById('support').innerHTML= this.responseText;
        };
        xhr.send();
      }

      var opcache = document.getElementById('opcache');
      var redis = document.getElementById('redis');
//      opcache.addEventListener('click', showOpcache);
//      redis.addEventListener('click', showRedis);
    })();
  </script>
</body>
</html>
