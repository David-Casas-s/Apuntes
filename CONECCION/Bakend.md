# Resumen Completo: Spring Boot + PostgreSQL desde Cero

> **Fecha:** Marzo 2026  
> **IDE:** IntelliJ IDEA Community Edition 2025.2.6  
> **JDK:** Oracle OpenJDK 21.0.9  
> **Base de datos:** PostgreSQL 18  
> **Spring Boot:** 3.5.11  

---

## 1. Herramientas Necesarias

Antes de comenzar, se necesitan tener instalados:

- **IntelliJ IDEA Community Edition** (gratuito)
- **JDK 21** (Java Development Kit)
- **PostgreSQL 18**
- **pgAdmin** (viene incluido con PostgreSQL)

IntelliJ IDEA Community es la versión gratuita del IDE. No incluye el panel de Database nativo, por lo que se instaló el plugin **Database Navigator** desde `File > Settings > Plugins` para poder visualizar la base de datos directamente desde el IDE.

---

## 2. Crear el Proyecto con Spring Initializr

La forma más fácil de crear un proyecto Spring Boot es usando Spring Initializr en: https://start.spring.io

**Configuración usada:**

| Campo | Valor |
|---|---|
| Project | Maven |
| Language | Java |
| Spring Boot | 3.5.11 (versión estable) |
| Group | com.example |
| Artifact | demo |
| Java | 21 |

> **Nota sobre versiones:**
> - `SNAPSHOT` = versión en desarrollo, puede tener bugs
> - `M2` = milestone, pre-release, no es versión final
> - La versión **estable** es la recomendada para proyectos reales

---

## 3. Dependencias Seleccionadas

### 🌐 Spring Web
Permite crear aplicaciones web y APIs REST usando Spring MVC. Incluye el servidor Apache Tomcat internamente, por lo que no necesitas instalar ningún servidor por separado. Con esta dependencia puedes crear endpoints HTTP (GET, POST, PUT, DELETE).

### 🗄️ Spring Data JPA
Es el puente principal entre tu código Java y la base de datos. Usa Hibernate internamente para traducir tus clases Java a tablas SQL de forma automática. En lugar de escribir SQL manualmente, trabajas con clases Java normales llamadas "entidades".

```
Tu código Java → Spring Data JPA → Hibernate → SQL → Base de datos
```

### 🐘 PostgreSQL Driver
Es el conector que permite a Java comunicarse con PostgreSQL. Sin este driver, la aplicación no sabría cómo conectarse ni interpretar las respuestas de la base de datos. Spring Data JPA lo usa internamente para enviar y recibir datos.

### 🔗 Rest Repositories (Spring Data REST)
Expone tus repositorios JPA como endpoints REST de forma automática, sin necesidad de crear controladores manualmente. Es muy útil para prototipos rápidos ya que con solo crear el repositorio ya tienes una API funcional.

### ✂️ Lombok
Elimina código repetitivo (boilerplate). Con simples anotaciones genera automáticamente:

| Anotación | Genera |
|---|---|
| `@Data` | getters, setters, toString, equals, hashCode |
| `@Getter` | solo getters |
| `@Setter` | solo setters |
| `@NoArgsConstructor` | constructor sin argumentos |
| `@AllArgsConstructor` | constructor con todos los argumentos |

Sin Lombok tendrías que escribir manualmente todos estos métodos.

### 🔧 Spring Boot DevTools
Mejora la experiencia de desarrollo con:
- Reinicio automático cuando guardas cambios en el código
- Recarga de recursos estáticos sin reiniciar
- Configuraciones por defecto optimizadas para desarrollo

> **Nota:** DevTools solo debe usarse en desarrollo, no en producción.

---

## 4. Abrir el Proyecto en IntelliJ

1. Descargar el `.zip` desde Spring Initializr
2. Descomprimirlo
3. Abrir IntelliJ → `File > Open` → seleccionar la carpeta
4. IntelliJ detectará que es Maven y descargará dependencias
5. Configurar el JDK: `File > Project Structure > SDK` → JDK 21
6. Cambiar Language Level a **21**

> **Problema común:** Si IntelliJ no reconoce el proyecto como Maven (no aparece opción Run, no hay ícono de Maven), abrir el proyecto seleccionando directamente el archivo `pom.xml` y elegir **"Open as Project"**.

**Para correr el proyecto desde la terminal:**
```bash
cd nombre-del-proyecto
.\mvnw spring-boot:run    # Windows PowerShell
./mvnw spring-boot:run    # Mac/Linux
```

---

## 5. Configurar application.properties

**Ubicación:** `src/main/resources/application.properties`

Este archivo es el centro de configuración de Spring Boot. Aquí le decimos cómo conectarse a la base de datos y cómo comportarse.

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/PruebaDeConexion
spring.datasource.username=postgres
spring.datasource.password=tu_contraseña

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

**Explicación línea por línea:**

**`spring.datasource.url`** — Le dice a Spring dónde está la base de datos:
- `jdbc:postgresql://` → protocolo de conexión (siempre debe empezar con `jdbc`)
- `localhost` → la BD está en tu misma máquina
- `5432` → puerto por defecto de PostgreSQL
- `PruebaDeConexion` → nombre de la base de datos

**`spring.datasource.username / password`** — Las credenciales de PostgreSQL. Son las mismas que usas en pgAdmin. El usuario por defecto es `postgres`.

**`spring.jpa.hibernate.ddl-auto`** — Define qué hace Spring con las tablas al iniciar:

| Valor | Comportamiento |
|---|---|
| `update` | Crea si no existe, actualiza si hay cambios ✅ Recomendado en desarrollo |
| `create` | Borra y recrea las tablas cada vez que inicia ⚠️ Peligroso, pierdes datos |
| `validate` | Solo verifica que las tablas coincidan, no toca nada |
| `none` | No hace nada, tú manejas todo manualmente ✅ Recomendado en producción |

**`spring.jpa.show-sql=true`** — Muestra en la consola el SQL que Hibernate genera internamente. Muy útil para depurar y entender qué está haciendo Spring.

---

## 6. Crear la Base de Datos en PostgreSQL

Antes de correr el proyecto, se debe crear la base de datos en PostgreSQL. Desde pgAdmin:

1. Abrir pgAdmin
2. Panel izquierdo: `Servers > PostgreSQL`
3. Clic derecho sobre **"Databases"**
4. `Create > Database`
5. Escribir el nombre: `PruebaDeConexion`
6. Guardar

> **Nota:** El nombre en pgAdmin debe coincidir exactamente con el que pusiste en `spring.datasource.url` del `application.properties`.

---

## 7. Plugin Database Navigator en IntelliJ

Como IntelliJ Community no tiene panel de Database nativo, se instaló el plugin **Database Navigator**.

**Instalación:**
1. `File > Settings > Plugins`
2. Buscar **"Database Navigator"**
3. Instalar y reiniciar IntelliJ

**Uso:**
1. `View > Tool Windows > DB Browser`
2. Clic en `+` para agregar conexión
3. Seleccionar PostgreSQL
4. Llenar: Host=`localhost`, Port=`5432`, Database, User, Password
5. Test Connection → OK

> **Limitación:** El comando `CREATE DATABASE` no funciona desde este plugin porque se ejecuta dentro de una transacción y PostgreSQL no lo permite. Es mejor crear las bases de datos desde pgAdmin.

---

## 8. Estructura del Proyecto

```
src/
  main/
    java/
      com/example/demo/
        DemoApplication.java         ← Clase principal (no modificar)
        modelo/
          Persona.java               ← Entidad (tabla en la BD)
        repositorio/
          PersonaRepository.java     ← Acceso a datos
        controlador/
          PersonaController.java     ← Endpoints REST
    resources/
      application.properties         ← Configuración
  test/
    java/                            ← Pruebas unitarias
pom.xml                              ← Dependencias Maven
```

---

## 9. Crear una Entidad (Tabla)

Una entidad es una clase Java que representa una tabla en la BD. Spring Boot la lee y crea la tabla automáticamente al iniciar.

```java
package com.example.demo.modelo;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "Persona")
public class Persona {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long ID;

    private String nombre;
    private int edad;
}
```

**Explicación de las anotaciones:**

| Anotación | Descripción |
|---|---|
| `@Data` | Lombok: genera getters, setters, toString, equals, hashCode automáticamente |
| `@Entity` | Le dice a Spring que esta clase representa una tabla en la BD |
| `@Table(name = "Persona")` | Define el nombre exacto de la tabla. Si no se pone, usa el nombre de la clase |
| `@Id` | Marca el campo como llave primaria |
| `@GeneratedValue(strategy = GenerationType.IDENTITY)` | El ID se genera automáticamente de forma incremental (1, 2, 3...) |

> **Nota:** Los campos sin anotación como `nombre` y `edad` se mapean automáticamente como columnas de la tabla con el mismo nombre.
>
> En PostgreSQL moderno el ID aparece como `bigint` en pgAdmin en lugar de `serial`, pero funciona exactamente igual.

---

## 10. Manejo de Cambios en la Base de Datos

Con `ddl-auto=update` el comportamiento es el siguiente:

| Acción | Desde IntelliJ | SQL en pgAdmin |
|---|---|---|
| Agregar columna nueva | ✅ Automático al guardar | `ALTER TABLE t ADD COLUMN col tipo;` |
| Renombrar columna | ❌ Crea columna nueva | `ALTER TABLE t RENAME COLUMN viejo TO nuevo;` |
| Eliminar columna | ❌ La deja intacta | `ALTER TABLE t DROP COLUMN col;` |
| Cambiar tipo de dato | ❌ Puede fallar | `ALTER TABLE t ALTER COLUMN col TYPE nuevo_tipo;` |
| Renombrar tabla | ❌ Crea tabla nueva | `ALTER TABLE viejo RENAME TO nuevo;` |
| Eliminar tabla | ❌ La deja intacta | `DROP TABLE nombre;` |

**Conclusión:**
- ✅ Agregar columnas → desde IntelliJ directamente
- ⚠️ Cualquier otra modificación → desde pgAdmin con SQL

> **Buenas prácticas en producción:** Para proyectos reales se recomienda usar **Flyway** o **Liquibase**, que son herramientas de migración de bases de datos. Funcionan como un "control de versiones" para la BD, llevando un historial ordenado de todos los cambios realizados.

---

## 11. Diagrama E-R en pgAdmin

PostgreSQL con pgAdmin permite generar diagramas E-R:

**Para toda la base de datos:**
1. Abrir pgAdmin
2. Clic derecho sobre la base de datos
3. Seleccionar **Generate ERD**

**Para una tabla específica:**
1. `Schemas > public > Tables`
2. Clic derecho sobre la tabla → **ERD For Table**

> **Importante:** Debes tener tablas creadas primero para que aparezcan en el diagrama. Las tablas se crean cuando corres el proyecto por primera vez con las entidades definidas.

> **Nota:** MySQL Workbench tiene una herramienta de diagramas E-R más visual y conocida. Si los diagramas son muy importantes, también puedes usar **DBeaver** (gratuito) que funciona con PostgreSQL y genera diagramas E-R automáticamente.

---

## 12. MySQL vs PostgreSQL

Desde IntelliJ y Spring Boot, trabajar con MySQL o PostgreSQL es prácticamente igual. El código Java que escribes es idéntico. La diferencia está en la URL y el driver.

**PostgreSQL:**
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/mi_bd
# Driver en pom.xml: org.postgresql:postgresql
```

**MySQL:**
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/mi_bd
# Driver en pom.xml: com.mysql.cj.jdbc.Driver
```

**¿Cuándo elegir cada uno?**

| | PostgreSQL | MySQL |
|---|---|---|
| Ideal para | Proyectos empresariales, datos complejos | Aplicaciones web, proyectos de aprendizaje |
| Diagramas E-R | pgAdmin o DBeaver | MySQL Workbench (más visual y nativo) |
| Tutoriales | Menos | Más disponibles |
| Robustez | Mayor | Menor |

Para aprender, cualquiera de los dos es válido.

---

## 13. Verificar que Todo Funciona

Cuando el proyecto inicia correctamente, en la consola debes ver:

```
HikariPool-1 - Start completed.    ← Conexión exitosa a la BD
Tomcat started on port 8080        ← Servidor iniciado
Started DemoApplication            ← Aplicación corriendo
```

La aplicación seguirá corriendo hasta que la detengas con el botón rojo ⬛ en IntelliJ o con `Ctrl+C` en la terminal.

**Errores comunes y soluciones:**

| Error | Solución |
|---|---|
| `'url' must start with "jdbc"` | La URL en `application.properties` no tiene `jdbc:` al inicio |
| `password authentication failed` | Usuario o contraseña incorrectos en `application.properties` |
| `Project JDK is not defined` | Ir a `File > Project Structure > SDK` y seleccionar JDK 21 |
| No aparece opción Run | Abrir el proyecto seleccionando el `pom.xml` directamente |

---

## 14. Próximos Pasos — CRUD Completo

Para completar un CRUD (Create, Read, Update, Delete) se necesitan 3 componentes:

### 1. Entidad ✅ (ya creada)
Clase Java con `@Entity` que representa la tabla.

### 2. Repositorio
Interface que extiende `JpaRepository` para acceder a los datos:
```java
public interface PersonaRepository extends JpaRepository<Persona, Long> {
}
```

### 3. Controlador
Clase con `@RestController` que define los endpoints REST:

| Método HTTP | Endpoint | Acción |
|---|---|---|
| GET | `/personas` | Listar todas |
| GET | `/personas/{id}` | Buscar por ID |
| POST | `/personas` | Crear nueva |
| PUT | `/personas/{id}` | Actualizar |
| DELETE | `/personas/{id}` | Eliminar |

> **Nota:** Con **Spring Data REST** (dependencia instalada), el repositorio se expone automáticamente como API REST sin necesidad de crear el controlador manualmente.

---

*Resumen generado en Marzo 2026*
