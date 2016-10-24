# wpkg

> WPKG est un logiciel de déploiement, de mise à jour et de suppression automatisés des paquetages pour Windows.

## Liens utiles

- [wpkg.org](https://wpkg.org/) :
    [Download](https://wpkg.org/Download),
    [Silent Installers](https://wpkg.org/Category:Silent_Installers)
- [wpkg.ac-creteil.fr](http://wpkg.ac-creteil.fr/)
- [Silently drop a package](http://wpkg-users.wpkg.narkive.com/oXCMUddm/silently-drop-a-package)

## En ligne de commandes

Lancer `cmd` en tant qu'administrateur :

```
cscript \\WPKG-SRV\wpkg\wpkg.js /install:dia
cscript \\WPKG-SRV\wpkg\wpkg.js /check:dia
cscript \\WPKG-SRV\wpkg\wpkg.js /remove:dia
cscript \\WPKG-SRV\wpkg\wpkg.js /synchronize /sendStatus /debug
cscript \\WPKG-SRV\wpkg\wpkg.js /synchronize /quiet /nonotify
```

## Remarques diverses

### Les différents codes d'erreur de `msiexec`

[Cette page](https://msdn.microsoft.com/en-us/library/windows/desktop/aa376931(v=vs.85).aspx) liste les différents codes d'erreurs que l'on peut rencontrer lors de l'installation d'un fichier `.msi` avec `msiexec` et leur signification.

### Récupérer le code produit (product code) d'un logiciel installé

Voir : http://stackoverflow.com/questions/21491631/how-to-uninstall-with-msiexec-using-product-id-guid-without-msi-file-present

> If you get "This action is only valid for products that are currently installed" you have used an unrecognized product or package code, and you must find the right one. Often this can be caused by using a package code instead of a product code to uninstall - a package code changes with every rebuild of an MSI file, and is the only guid you see when you view an msi file's property page. To find the product code you need to open the MSI. The product code is found in the Property table.
> 
> You can also find the product code by perusing the registry from this base key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall`. Press F3 and search for your product name. (If it's a 32-bit installer on a 64-bit machine, it might be under `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall` instead).

On trouve parfois le désinstallateur dans `C:\Windows\Installer`.

Il est nécessaire de récupérer le code produit notamment pour GeoGebra, LibreOffice et Scratch.
De plus il faut bien souvent désinstaller la version précédente avec le fichier MSI utilisé lors de l'installation (et non le nouveau), avant de pouvoir installer la nouvelle version du logiciel !

## Récupérer un fichier MSI à partir d'un fichier EXE

Certains logiciels (comme Java ou SketchUp) nécessitent de récupérer le fichier MSI correspondant à l'exécutable.
Seul le fichier .exe se trouve sur le site officiel.
Pour générer le fichier MSI correspondant, on peut lancer le fichier EXE, puis récupérer le fichier MSI généré dans le dossier `%APPDATA%\..\Local\Temp`.

### Importance de ne pas faire d'erreurs dans le fichier XML

En cas d'erreur sur la commande **remove**, le paquet devient un paquet *zombie* lorsque de la désinstallation échoue (notamment si le check est toujours vérifié après avoir exécuté les commandes de désinstallation). Lors de la désinstallation, wpkg se base sur la version locale du fichier XML donc gare aux erreurs !

Attention, les instructions **check** sont essentielles, cela permet de tester la version si besoin de mettre à jour plus tard. Bien souvent, on fait appel à la variable `%version%` dans le test (en effet définir une telle variable n'a aucun intérêt si on ne l'appelle jamais).

Les commandes **upgrade** peuvent être rectifiées, car lors d'une mise à jour, le client récupère la nouvelle version du fichier XML et exécute les commandes (contrairement à un `remove`). En cas d'erreur dans la commande `remove`, on peut faire un `upgrade` et rectifier la commande `remove`…
