================================================================
   RESUMEN COMPLETO: SPRING BOOT + POSTGRESQL DESDE CERO
================================================================

Fecha: 01 Marzo 2026
IDE: IntelliJ IDEA Community Edition 2025.2.6
JDK: Oracle OpenJDK 21.0.9
Base de datos: PostgreSQL 18
Spring Boot: 3.5.11


================================================================
1. HERRAMIENTAS NECESARIAS
================================================================

Antes de comenzar, se necesitan tener instalados:

- IntelliJ IDEA Community Edition (gratuito)
- JDK 21 (Java Development Kit)
- PostgreSQL 18
- pgAdmin (viene incluido con PostgreSQL)

IntelliJ IDEA Community es la version gratuita del IDE. No incluye
el panel de Database nativo, por lo que se instalo el plugin
"Database Navigator" desde File > Settings > Plugins para poder
visualizar la base de datos directamente desde el IDE.


================================================================
2. CREAR EL PROYECTO CON SPRING INITIALIZR
================================================================

La forma mas facil de crear un proyecto Spring Boot es usando
Spring Initializr en: https://start.spring.io

Configuracion usada:
- Project: Maven
- Language: Java
- Spring Boot: 3.5.11 (version estable, evitar SNAPSHOT y M2)
- Group: com.example
- Artifact: demo
- Java: 21

NOTA SOBRE VERSIONES:
- SNAPSHOT = version en desarrollo, puede tener bugs
- M2 = milestone, pre-release, no es version final
- La version estable es la recomendada para proyectos reales


================================================================
3. DEPENDENCIAS SELECCIONADAS
================================================================

--- Spring Web ---
Permite crear aplicaciones web y APIs REST usando Spring MVC.
Incluye el servidor Apache Tomcat internamente, por lo que no
necesitas instalar ningun servidor por separado. Con esta
dependencia puedes crear endpoints HTTP (GET, POST, PUT, DELETE).

--- Spring Data JPA ---
Es el puente principal entre tu codigo Java y la base de datos.
Usa Hibernate internamente para traducir tus clases Java a tablas
SQL de forma automatica. En lugar de escribir SQL manualmente,
trabajas con clases Java normales llamadas "entidades".

Flujo: Tu codigo Java -> Spring Data JPA -> Hibernate -> SQL -> BD

--- PostgreSQL Driver ---
Es el conector que permite a Java comunicarse con PostgreSQL.
Sin este driver, la aplicacion no sabria como conectarse ni
interpretar las respuestas de la base de datos. Spring Data JPA
lo usa internamente para enviar y recibir datos.

--- Rest Repositories (Spring Data REST) ---
Expone tus repositorios JPA como endpoints REST de forma
automatica, sin necesidad de crear controladores manualmente.
Es muy util para prototipos rapidos ya que con solo crear el
repositorio ya tienes una API funcional.

--- Lombok ---
Elimina codigo repetitivo (boilerplate). Con simples anotaciones
genera automaticamente:
  @Data       -> getters, setters, toString, equals, hashCode
  @Getter     -> solo getters
  @Setter     -> solo setters
  @NoArgsConstructor -> constructor sin argumentos
  @AllArgsConstructor -> constructor con todos los argumentos

Sin Lombok tendrias que escribir manualmente todos estos metodos.

--- Spring Boot DevTools ---
Mejora la experiencia de desarrollo con:
  - Reinicio automatico cuando guardas cambios en el codigo
  - Recarga de recursos estaticos sin reiniciar
  - Configuraciones por defecto optimizadas para desarrollo

NOTA: DevTools solo debe usarse en desarrollo, no en produccion.


================================================================
4. ABRIR EL PROYECTO EN INTELLIJ
================================================================

1. Descargar el .zip desde Spring Initializr
2. Descomprimirlo
3. Abrir IntelliJ -> File > Open -> seleccionar la carpeta
4. IntelliJ detectara que es Maven y descargara dependencias
5. Configurar el JDK: File > Project Structure > SDK -> JDK 21
6. Cambiar Language Level a 21

PROBLEMA COMUN: Si IntelliJ no reconoce el proyecto como Maven
(no aparece opcion Run, no hay icono de Maven), abrir el proyecto
seleccionando directamente el archivo pom.xml y elegir
"Open as Project".

Para correr el proyecto desde la terminal:
  cd nombre-del-proyecto
  .\mvnw spring-boot:run    (Windows PowerShell)
  ./mvnw spring-boot:run    (Mac/Linux)


================================================================
5. CONFIGURAR APPLICATION.PROPERTIES
================================================================

Ubicacion: src/main/resources/application.properties

Este archivo es el centro de configuracion de Spring Boot.
Aqui le decimos como conectarse a la base de datos y como
comportarse.

--- Configuracion completa ---

spring.datasource.url=jdbc:postgresql://localhost:5432/PruebaDeConexion
spring.datasource.username=postgres
spring.datasource.password=tu_contraseña

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

--- Explicacion linea por linea ---

spring.datasource.url
  Le dice a Spring donde esta la base de datos.
  - jdbc:postgresql:// -> protocolo de conexion (siempre debe empezar con "jdbc")
  - localhost          -> la BD esta en tu misma maquina
  - 5432               -> puerto por defecto de PostgreSQL
  - PruebaDeConexion   -> nombre de la base de datos

spring.datasource.username / password
  Las credenciales de PostgreSQL. Son las mismas que usas
  en pgAdmin. El usuario por defecto es "postgres".

spring.jpa.hibernate.ddl-auto
  Define que hace Spring con las tablas al iniciar:
  - update   -> crea si no existe, actualiza si hay cambios (RECOMENDADO en desarrollo)
  - create   -> borra y recrea las tablas cada vez que inicia (PELIGROSO, pierdes datos)
  - validate -> solo verifica que las tablas coincidan, no toca nada
  - none     -> no hace nada, tu manejas todo manualmente (RECOMENDADO en produccion)

spring.jpa.show-sql=true
  Muestra en la consola el SQL que Hibernate genera internamente.
  Muy util para depurar y entender que esta haciendo Spring.


================================================================
6. CREAR LA BASE DE DATOS EN POSTGRESQL
================================================================

Antes de correr el proyecto, se debe crear la base de datos
en PostgreSQL. Desde pgAdmin:

1. Abrir pgAdmin
2. Panel izquierdo: Servers > PostgreSQL
3. Clic derecho sobre "Databases"
4. Create > Database
5. Escribir el nombre: PruebaDeConexion
6. Guardar

NOTA: El nombre en pgAdmin debe coincidir exactamente con el
que pusiste en spring.datasource.url del application.properties.


================================================================
7. PLUGIN DATABASE NAVIGATOR EN INTELLIJ
================================================================

Como IntelliJ Community no tiene panel de Database nativo,
se instalo el plugin "Database Navigator":

Instalacion:
1. File > Settings > Plugins
2. Buscar "Database Navigator"
3. Instalar y reiniciar IntelliJ

Uso:
1. View > Tool Windows > DB Browser
2. Clic en + para agregar conexion
3. Seleccionar PostgreSQL
4. Llenar: Host=localhost, Port=5432, Database, User, Password
5. Test Connection -> OK

LIMITACION: Para crear bases de datos desde este plugin no
funciona el comando CREATE DATABASE dentro de una transaccion.
Es mejor crear las bases de datos desde pgAdmin.


================================================================
8. ESTRUCTURA DEL PROYECTO
================================================================

src/
  main/
    java/
      com/example/demo/
        DemoApplication.java      <- Clase principal (no modificar)
        modelo/
          Persona.java            <- Entidad (tabla en la BD)
        repositorio/
          PersonaRepository.java  <- Acceso a datos
        controlador/
          PersonaController.java  <- Endpoints REST
    resources/
      application.properties      <- Configuracion
  test/
    java/                         <- Pruebas unitarias
pom.xml                           <- Dependencias Maven


================================================================
9. CREAR UNA ENTIDAD (TABLA)
================================================================

Una entidad es una clase Java que representa una tabla en la BD.
Spring Boot la lee y crea la tabla automaticamente al iniciar.

--- Ejemplo: Clase Persona ---

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

--- Explicacion de las anotaciones ---

@Data (Lombok)
  Genera automaticamente getters, setters, toString, equals
  y hashCode. Sin esta anotacion habria que escribirlos a mano.

@Entity
  Le dice a Spring que esta clase representa una tabla en la BD.
  Es obligatoria para que JPA la reconozca.

@Table(name = "Persona")
  Define el nombre exacto de la tabla en la base de datos.
  Si no se pone, usa el nombre de la clase por defecto.

@Id
  Marca el campo como llave primaria de la tabla.

@GeneratedValue(strategy = GenerationType.IDENTITY)
  El ID se genera automaticamente de forma incremental (1, 2, 3...).
  En PostgreSQL esto equivale a un campo SERIAL.
  Nota: En PostgreSQL moderno aparece como "bigint" en pgAdmin
  pero funciona igual que SERIAL.

--- Campos sin anotacion ---
  Los campos como "nombre" y "edad" se mapean automaticamente
  como columnas de la tabla con el mismo nombre.


================================================================
10. MANEJO DE CAMBIOS EN LA BASE DE DATOS
================================================================

Con ddl-auto=update el comportamiento es el siguiente:

ACCION                  | DESDE INTELLIJ        | DESDE PGADMIN (SQL)
------------------------|----------------------|--------------------
Agregar columna nueva   | Automatico al guardar | ALTER TABLE t ADD COLUMN col tipo;
Renombrar columna       | NO funciona (crea nueva columna) | ALTER TABLE t RENAME COLUMN viejo TO nuevo;
Eliminar columna        | NO funciona (la deja) | ALTER TABLE t DROP COLUMN col;
Cambiar tipo de dato    | Puede fallar          | ALTER TABLE t ALTER COLUMN col TYPE nuevo_tipo;
Renombrar tabla         | NO funciona (crea nueva tabla) | ALTER TABLE viejo RENAME TO nuevo;
Eliminar tabla          | NO funciona (la deja) | DROP TABLE nombre;

CONCLUSION:
- Agregar columnas -> desde IntelliJ directamente
- Cualquier otra modificacion -> desde pgAdmin con SQL

BUENAS PRACTICAS EN PRODUCCION:
Para proyectos reales se recomienda usar Flyway o Liquibase,
que son herramientas de migracion de bases de datos. Funcionan
como un "control de versiones" para la BD, llevando un historial
ordenado de todos los cambios realizados.


================================================================
11. DIAGRAMA E-R EN PGADMIN
================================================================

PostgreSQL con pgAdmin permite generar diagramas E-R:

1. Abrir pgAdmin
2. Navegar hasta la base de datos
3. Clic derecho sobre la base de datos -> Generate ERD

O para una tabla especifica:
1. Schemas > public > Tables
2. Clic derecho sobre la tabla -> ERD For Table

IMPORTANTE: Debes tener tablas creadas primero para que aparezcan
en el diagrama. Las tablas se crean cuando corres el proyecto
por primera vez con las entidades definidas.

NOTA: MySQL Workbench tiene una herramienta de diagramas E-R
mas visual y conocida. Si los diagramas son muy importantes,
tambien puedes usar DBeaver (gratuito) que funciona con
PostgreSQL y genera diagramas E-R automaticamente.


================================================================
12. MYSQL VS POSTGRESQL
================================================================

Desde IntelliJ y Spring Boot, trabajar con MySQL o PostgreSQL
es practicamente igual. El codigo Java que escribes es identico.

La diferencia esta en:
- La URL de conexion en application.properties
- El driver en pom.xml

POSTGRESQL:
  spring.datasource.url=jdbc:postgresql://localhost:5432/mi_bd
  Driver: org.postgresql:postgresql

MYSQL:
  spring.datasource.url=jdbc:mysql://localhost:3306/mi_bd
  Driver: com.mysql.cj.jdbc.Driver

CUANDO ELEGIR CADA UNO:
  PostgreSQL -> Proyectos empresariales, datos complejos,
                mayor robustez y cumplimiento de estandares SQL
  MySQL      -> Aplicaciones web, mas tutoriales disponibles,
                MySQL Workbench con diagramas E-R muy visuales

Para aprender, cualquiera de los dos es valido.


================================================================
13. VERIFICAR QUE TODO FUNCIONA
================================================================

Cuando el proyecto inicia correctamente, en la consola debes ver:

  HikariPool-1 - Start completed.   <- Conexion exitosa a la BD
  Tomcat started on port 8080       <- Servidor iniciado
  Started DemoApplication           <- Aplicacion corriendo

Si ves estos mensajes, el proyecto esta funcionando correctamente.
La aplicacion seguira corriendo hasta que la detengas con el
boton rojo en IntelliJ o con Ctrl+C en la terminal.

ERRORES COMUNES Y SOLUCIONES:

Error: 'url' must start with "jdbc"
  -> La URL en application.properties no tiene "jdbc:" al inicio

Error: password authentication failed for user "X"
  -> Usuario o contraseña incorrectos en application.properties

Error: Project JDK is not defined
  -> Ir a File > Project Structure > SDK y seleccionar JDK 21

Error: No se puede correr el proyecto (no aparece opcion Run)
  -> Abrir el proyecto seleccionando el pom.xml directamente


================================================================
14. PROXIMOS PASOS
================================================================

Para completar un CRUD (Create, Read, Update, Delete) se necesita:

1. ENTIDAD (ya creada)
   Clase Java con @Entity que representa la tabla

2. REPOSITORIO
   Interface que extiende JpaRepository para acceder a los datos
   Ejemplo: PersonaRepository extends JpaRepository<Persona, Long>

3. CONTROLADOR
   Clase con @RestController que define los endpoints REST
   Ejemplo:
     GET    /personas      -> listar todas
     GET    /personas/{id} -> buscar por ID
     POST   /personas      -> crear nueva
     PUT    /personas/{id} -> actualizar
     DELETE /personas/{id} -> eliminar

Con Spring Data REST (dependencia instalada), el repositorio
se expone automaticamente como API REST sin necesidad de
crear el controlador manualmente.


================================================================
FIN DEL RESUMEN
================================================================