/* Nombre de la base que acabas de crear: */
$cfg['Servers'][$i]['pmadb'] = 'phpmyadmin';

/* Usuario de control (debe existir en MySQL y tener permisos sobre esa base) */
$cfg['Servers'][$i]['controluser'] = 'pma';
$cfg['Servers'][$i]['controlpass'] = 'TU_CONTRASEÑA_PMA';

/* Indica que phpMyAdmin puede usar tablas sin contraseña */
$cfg['Servers'][$i]['AllowNoPassword'] = true;
