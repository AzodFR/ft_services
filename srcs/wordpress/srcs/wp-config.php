<?php
/**
 * Custom WordPress configurations on "wp-config.php" file.
 *
 * This file has the following configurations: MySQL settings, Table Prefix, Secret Keys, WordPress Language, ABSPATH and more.
 * For more information visit {@link https://codex.wordpress.org/Editing_wp-config.php Editing wp-config.php} Codex page.
 * Created using {@link http://generatewp.com/wp-config/ wp-config.php File Generator} on GenerateWP.com.
 *
 * @package WordPress
 * @generator GenerateWP.com
 */


/* MySQL settings */
define( 'DB_NAME',     'wordpress' );
define( 'DB_USER',     'root' );
define( 'DB_PASSWORD', 'root' );
define( 'DB_HOST',     'mysql-service' );
define( 'DB_CHARSET',  'utf8' );


/* MySQL database table prefix. */
$table_prefix = 'wp_';


/* Authentication Unique Keys and Salts. */
/* https://api.wordpress.org/secret-key/1.1/salt/ */
define('AUTH_KEY',         '642=N_=BiVbn=)!<ZH/J|dBs!K/OH=COUCOUxBpC^x!4Q:3n*`g|*&yxNTeO~3e-');
define('SECURE_AUTH_KEY',  'QK)SH-Jwt.o=hWFdTNb- @uI[m=[1d<TOI({-Ok+A?pvvQ(5,b.1H-HJ-m#5H~a5');
define('LOGGED_IN_KEY',    'jL|-<7G3cLs#ngB(|#?yu[#Dztx@B>PITIE!TF#O?@7A+h%j:;-r_o|k!Ru]B}zR');
define('NONCE_KEY',        '8;:+i]WX-=4G};@rl|H<osPI*BZ@SAUVE-MOI@|4vpsdG&^N *6dWbq@~wCeT^hF');
define('AUTH_SALT',        ']%%h|kh?u9AEqH@INa:n]!psgj|6(-=DE-CE=UF)?`{+yM)ZTsa]t;:bn1,6qqaR');
define('SECURE_AUTH_SALT', 'IxWY#w|R-o?bN-1lYl}qa?.,^9|Z^PROJET<aEt<k4/%`3`n51%y35X8/tvC[%_c');
define('LOGGED_IN_SALT',   ':?1EY1(|lf9r_C7L[(lz_Fk|OH[JE PIGE R :()<2|mIG(b+LPx:(.c}[[3|<uS');
define('NONCE_SALT',       '}`+MI!,Ol-r1v<[Lk|#UaYliU5R *LARMES*b]z~S9Wmv|L$k6o Ihf?h3NM)I9q');
define( 'CONCATENATE_SCRIPTS', false ); 
define( 'SCRIPT_DEBUG', true );

/* Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/* Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');