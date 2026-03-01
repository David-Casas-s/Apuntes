# Git - Apuntes Básicos

## Configuración inicial
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

---

## Crear o clonar un repositorio
```bash
git init                        # Inicia un repo nuevo en la carpeta actual
git clone https://url/repo.git  # Clona un repo existente
```

---

## Flujo básico de trabajo
```bash
git status                      # Ver el estado de los archivos
git add archivo.txt             # Agregar un archivo al staging
git add .                       # Agregar todos los archivos modificados
git commit -m "descripción"     # Confirmar los cambios
git log                         # Ver historial de commits
git log --oneline               # Historial resumido
```

---

## Ramas (branches)
```bash
git branch                      # Ver ramas existentes
git branch nueva-rama           # Crear una rama
git checkout nueva-rama         # Cambiar a una rama
git checkout -b nueva-rama      # Crear y cambiar en un paso
git merge nueva-rama            # Fusionar una rama con la actual
git branch -d nueva-rama        # Eliminar una rama
```

---

## Repositorios remotos (GitHub)
```bash
git remote add origin https://github.com/usuario/repo.git  # Vincular remoto
git remote -v                                               # Ver remotos vinculados
git remote set-url origin https://github.com/usuario/repo.git  # Corregir URL remota
git push -u origin master       # Primer push (vincula la rama)
git push                        # Push siguientes
git pull origin master          # Descargar y fusionar cambios
git fetch                       # Solo descargar sin fusionar
```

---

## Otros comandos útiles
```bash
git diff                        # Ver cambios no confirmados
git stash                       # Guardar cambios temporalmente
git stash pop                   # Recuperar cambios guardados
git reset --hard HEAD           # Deshacer todos los cambios locales
git restore archivo.txt         # Descartar cambios de un archivo
```

---

## Quitar Git de una carpeta
```bash
# Git Bash
rm -rf .git

# CMD
rmdir /s /q .git

# PowerShell
Remove-Item -Recurse -Force .git
```

---

## Renombrar rama master a main
```bash
git branch -m master main
git push -u origin main
```

---

## Flujo típico del día a día
```bash
git pull            # 1. Traer últimos cambios
# ... editas tus archivos ...
git add .           # 2. Preparar cambios
git commit -m ""    # 3. Confirmar
git push            # 4. Subir al remoto
```