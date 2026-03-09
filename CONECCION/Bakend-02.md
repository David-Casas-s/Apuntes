# Resumen: Modelado de Entidades con JPA y Spring Boot

---

## 1. Herencia entre Entidades

### Concepto general
En JPA es posible aplicar herencia entre clases Java, igual que en la programación orientada a objetos. Una clase hija hereda los atributos de la clase padre. En la base de datos, dependiendo de la estrategia elegida, esto se traduce de diferentes formas.

La anotación que controla esto es:
```java
@Inheritance(strategy = InheritanceType.XXXX)
```

Existen tres estrategias:

| Estrategia | Comportamiento en la BD |
|---|---|
| `JOINED` | Una tabla por clase, se unen por el ID |
| `SINGLE_TABLE` | Todo en una sola tabla con columna discriminadora |
| `TABLE_PER_CLASS` | Una tabla por clase con todas las columnas repetidas |

La más recomendada y limpia es **JOINED** porque evita redundancia y mantiene el modelo organizado.

### ¿Cómo funciona JOINED en la BD?
- La clase padre tiene su propia tabla con sus atributos y el ID
- La clase hija tiene su propia tabla con sus atributos propios
- El ID de la tabla hija es al mismo tiempo **llave primaria** y **llave foránea** que apunta al ID del padre
- JPA crea esta llave foránea automáticamente, no necesitas definirla manualmente

### Ejemplo específico
```java
// Clase padre
@Data
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "PERSONA")
public class Persona {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nombre;
    private int edad;
    private LocalDate fechaNacimiento;

    @Enumerated(EnumType.STRING)
    private Genero genero;
}

// Clase hija
@Entity
@Table(name = "CLIENTE")
public class Cliente extends Persona {
    // Solo atributos propios de Cliente
    // El ID lo hereda de Persona automáticamente
}
```

**En la BD se generan dos tablas:**
```
Tabla PERSONA                          Tabla CLIENTE
-------------------------------        --------------
id | nombre | edad | genero | ...      id |
1  | Juan   | 25   | MASC   | ...      1  |
```

El `id` de `CLIENTE` apunta al `id` de `PERSONA` como llave foránea.

---

## 2. Enumeraciones (Enum)

### Concepto general
Un Enum es un tipo de dato que define un conjunto fijo de valores permitidos. Es útil cuando un atributo solo puede tener ciertos valores predefinidos, evitando errores de escritura o valores inválidos en la BD.

Se crea como una clase Java separada y se usa como tipo de dato en la entidad.

La anotación `@Enumerated` define cómo se guarda en la BD:

| Tipo | Guarda en la BD | Ejemplo |
|---|---|---|
| `EnumType.STRING` | El texto del valor | `"MASCULINO"` |
| `EnumType.ORDINAL` | Un número según posición | `0, 1, 2` |

> **Siempre usar `EnumType.STRING`** porque si cambias el orden del Enum los números cambian y puedes corromper los datos existentes.

### Ejemplo específico
```java
// Archivo Genero.java
package com.example.demo.modelo;

public enum Genero {
    MASCULINO,
    FEMENINO,
    OTRO
}

// Uso en la entidad Persona
@Enumerated(EnumType.STRING)
private Genero genero;
```

En la BD se guarda como texto: `"MASCULINO"`, `"FEMENINO"` u `"OTRO"`. Cualquier otro valor genera un error.

---

## 3. Manejo de Fechas

### Concepto general
Java ofrece varios tipos para manejar fechas y horas. Los más modernos y recomendados vienen del paquete `java.time` introducido en Java 8.

| Tipo | Qué guarda | Tipo en BD | Ejemplo |
|---|---|---|---|
| `LocalDate` | Solo fecha | `DATE` | `2026-03-08` |
| `LocalTime` | Solo hora | `TIME` | `18:05:43` |
| `LocalDateTime` | Fecha y hora | `TIMESTAMP` | `2026-03-08T18:05:43` |

> **No usar `java.util.Date`** ya que es una clase antigua con muchos problemas conocidos.

### Ejemplo específico
```java
// En Persona
private LocalDate fechaNacimiento;  // solo la fecha de nacimiento

// En Ticket
private LocalDateTime fechaYhoraDeSalida;  // fecha y hora exacta del viaje
```

---

## 4. Relaciones entre Entidades

En JPA las relaciones entre tablas se definen con anotaciones directamente en los atributos de las clases Java. No se escribe SQL manualmente, JPA crea las llaves foráneas y tablas intermedias automáticamente.

Existen tres tipos de relaciones:

---

### 4.1 Relación Uno a Muchos / Muchos a Uno (@OneToMany / @ManyToOne)

#### Concepto general
Se usa cuando un registro de una tabla se relaciona con muchos registros de otra tabla. Esta relación siempre tiene **dos lados** que se complementan:

- El lado **"uno"** → la clase que "tiene muchos" de la otra
- El lado **"muchos"** → la clase que "pertenece a uno" de la otra

---

#### Sintaxis base — Lado "muchos" (@ManyToOne)

El lado "muchos" es el que **guarda la llave foránea** en la BD. Siempre lleva dos anotaciones sobre el atributo:

```java
@ManyToOne
@JoinColumn(name = "nombre_columna_fk")
private ClaseUno nombreAtributo;
```

| Parte | Qué hace |
|---|---|
| `@ManyToOne` | Declara que muchos de esta clase pertenecen a uno de la otra |
| `@JoinColumn(name = "...")` | Define el nombre de la columna llave foránea que se creará en esta tabla |
| `private ClaseUno nombreAtributo` | El atributo que representa al objeto del lado "uno" |

> **Regla:** `@ManyToOne` y `@JoinColumn` siempre van juntas, siempre sobre el atributo, nunca sobre la clase.

---

#### Sintaxis base — Lado "uno" (@OneToMany)

El lado "uno" **no crea ninguna columna en la BD**. Solo le dice a JPA que existe una lista de objetos relacionados. Siempre lleva una sola anotación sobre el atributo:

```java
@OneToMany(mappedBy = "nombreAtributoEnClaseMuchos")
private List<ClaseMuchos> nombreLista;
```

| Parte | Qué hace |
|---|---|
| `@OneToMany` | Declara que uno de esta clase tiene muchos de la otra |
| `mappedBy = "..."` | Indica el nombre exacto del atributo en la clase "muchos" que tiene el `@ManyToOne` |
| `private List<ClaseMuchos> nombreLista` | La lista de objetos relacionados (solo existe en Java, no en la BD) |

> **Regla crítica:** El valor de `mappedBy` debe ser exactamente igual al nombre del atributo en la clase del lado "muchos". Si el atributo se llama `cliente`, entonces `mappedBy = "cliente"`. Si se llama `propietario`, entonces `mappedBy = "propietario"`.

---

#### Estructura completa de la relación

```java
// ============================================
// CLASE A — lado "uno"
// ============================================
@Entity
public class ClaseUno {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // otros atributos...

    @OneToMany(mappedBy = "claseUno")   // ← apunta al atributo en ClaseMuchos
    private List<ClaseMuchos> items;
}

// ============================================
// CLASE B — lado "muchos"
// ============================================
@Entity
public class ClaseMuchos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // otros atributos...

    @ManyToOne
    @JoinColumn(name = "id_clase_uno")  // ← nombre de la FK en la BD
    private ClaseUno claseUno;          // ← nombre que usa mappedBy
}
```

---

#### ¿Cómo se ve en la BD?

Las listas en Java (`List<>`) **no existen como columna en la BD**. Se representan con una llave foránea en la tabla del lado "muchos". Cuando consultas la lista, JPA internamente ejecuta `SELECT * FROM clase_muchos WHERE id_clase_uno = X`.

```
Tabla clase_uno          Tabla clase_muchos
----------------         --------------------------------
id | datos               id | datos | id_clase_uno (FK)
1  | ...                 1  | ...   |       1
2  | ...                 2  | ...   |       1
                         3  | ...   |       2
```

---

#### Ejemplo específico del proyecto

Un `Cliente` puede tener muchos `Ticket`, pero cada `Ticket` pertenece a un solo `Cliente`:

```java
// Cliente — lado "uno"
@Entity
@Table(name = "CLIENTE")
public class Cliente extends Persona {

    @OneToMany(mappedBy = "cliente")  // "cliente" es el atributo en Ticket
    private List<Ticket> tickets;
}

// Ticket — lado "muchos"
@Entity
public class Ticket {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idTicket;

    @ManyToOne
    @JoinColumn(name = "id_cliente")  // columna FK que se crea en la tabla ticket
    private Cliente cliente;          // este nombre es el que usa mappedBy

    private double precioTicket;
    private LocalDateTime fechaYhoraDeSalida;
}
```

**Resultado en la BD:**
```
Tabla cliente        Tabla ticket
-------------        ---------------------------------------
id |                 id_ticket | precio | id_cliente (FK)
1  |                 1         | 150.0  |      1
                     2         | 200.0  |      1
                     3         | 300.0  |      2
```

---

### 4.2 Relación Muchos a Muchos (@ManyToMany)

#### Concepto general
Se usa cuando muchos registros de una tabla se relacionan con muchos registros de otra tabla. En SQL esto **no se puede representar con una sola llave foránea**, por lo que JPA crea automáticamente una **tabla intermedia** que conecta ambas tablas.

Esta relación también tiene dos lados:
- La clase **"dueña"** → la que define cómo se crea la tabla intermedia
- La clase **"inversa"** → la que simplemente referencia la relación ya definida

No importa cuál clase sea la dueña, el resultado en la BD es el mismo.

---

#### Sintaxis base — Clase dueña

La clase dueña lleva `@ManyToMany` y `@JoinTable` sobre el atributo. `@JoinTable` es la que le dice a JPA cómo debe llamarse la tabla intermedia y qué columnas debe tener:

```java
@ManyToMany
@JoinTable(
    name = "nombre_tabla_intermedia",
    joinColumns = @JoinColumn(name = "fk_esta_clase"),
    inverseJoinColumns = @JoinColumn(name = "fk_otra_clase")
)
private List<OtraClase> nombreLista;
```

| Parte | Qué hace |
|---|---|
| `@ManyToMany` | Declara la relación de muchos a muchos |
| `@JoinTable(name = "...")` | Define el nombre de la tabla intermedia que se creará en la BD |
| `joinColumns` | Define la columna FK que apunta a **esta** clase (la dueña) |
| `inverseJoinColumns` | Define la columna FK que apunta a la **otra** clase |
| `private List<OtraClase> nombreLista` | La lista de objetos relacionados |

---

#### Sintaxis base — Clase inversa

La clase inversa simplemente referencia el atributo de la clase dueña con `mappedBy`:

```java
@ManyToMany(mappedBy = "nombreAtributoEnClaseDueña")
private List<ClaseDueña> nombreLista;
```

| Parte | Qué hace |
|---|---|
| `@ManyToMany(mappedBy = "...")` | Indica que esta clase es el lado inverso de la relación |
| `mappedBy = "..."` | Nombre exacto del atributo `List<>` en la clase dueña |

> **Regla:** Solo una clase lleva `@JoinTable`. La otra siempre lleva `mappedBy`. Si ambas llevan `@JoinTable` JPA crea dos tablas intermedias duplicadas.

---

#### Estructura completa de la relación

```java
// ============================================
// CLASE A — dueña de la relación
// ============================================
@Entity
public class ClaseA {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // otros atributos...

    @ManyToMany
    @JoinTable(
        name = "tabla_intermedia",          // nombre de la tabla intermedia en BD
        joinColumns = @JoinColumn(name = "id_a"),         // FK hacia esta clase
        inverseJoinColumns = @JoinColumn(name = "id_b")  // FK hacia la otra clase
    )
    private List<ClaseB> elementosB;        // ← este nombre usa mappedBy en ClaseB
}

// ============================================
// CLASE B — inversa de la relación
// ============================================
@Entity
public class ClaseB {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // otros atributos...

    @ManyToMany(mappedBy = "elementosB")   // ← nombre exacto del atributo en ClaseA
    private List<ClaseA> elementosA;
}
```

---

#### ¿Cómo se ve en la BD?

JPA crea tres tablas: las dos entidades y la tabla intermedia con las dos llaves foráneas:

```
Tabla clase_a          Tabla intermedia         Tabla clase_b
--------------         -----------------        --------------
id | datos             id_a  |  id_b            id | datos
1  | ...               1     |  1               1  | ...
2  | ...               1     |  2               2  | ...
                       2     |  1               3  | ...
                       2     |  3
```

La tabla intermedia no tiene datos propios, solo almacena las combinaciones de IDs que representan las relaciones.

---

#### Ejemplo específico del proyecto

Un `Cliente` puede registrarse en muchas `EmpresaDeTransporte`, y una `EmpresaDeTransporte` puede tener muchos `Cliente`:

```java
// EmpresaDeTransporte — clase dueña
@Entity
@Table(name = "EmpresasDeTransporte")
public class EmpresaDeTransporte {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long nitEmpresa;

    private String nombreEmpresa;

    @ManyToMany
    @JoinTable(
        name = "tabla_intermedia",
        joinColumns = @JoinColumn(name = "nit_empresa"),       // FK hacia esta clase
        inverseJoinColumns = @JoinColumn(name = "id_cliente")  // FK hacia Cliente
    )
    private List<Cliente> clientes;   // ← "clientes" es el nombre que usa mappedBy
}

// Cliente — clase inversa
@Entity
@Table(name = "CLIENTE")
public class Cliente extends Persona {

    @ManyToMany(mappedBy = "clientes")  // "clientes" es el atributo en EmpresaDeTransporte
    private List<EmpresaDeTransporte> empresas;

    @OneToMany(mappedBy = "cliente")
    private List<Ticket> tickets;
}
```

**Resultado en la BD:**
```
Tabla empresas_de_transporte       Tabla tabla_intermedia      Tabla cliente
-----------------------------      ----------------------      -------------
nit_empresa | nombre_empresa       nit_empresa | id_cliente    id |
1           | TransMilenio         1           |     1         1  |
2           | Flota Magdalena      1           |     2         2  |
                                   2           |     1
```

Esto significa que el cliente 1 está registrado en ambas empresas, y el cliente 2 solo en la empresa 1.

---

## 5. Reglas y Convenciones Importantes

### Sobre las anotaciones
- `@JoinColumn`, `@ManyToOne`, `@OneToMany`, `@ManyToMany` siempre van sobre el **atributo**, nunca sobre la clase
- `mappedBy` debe coincidir exactamente con el **nombre del atributo** en la otra clase, no con el nombre de la tabla ni de la clase
- Solo **una** de las dos clases en `@ManyToMany` lleva `@JoinTable`, la otra lleva `mappedBy`

### Sobre los nombres
- Los atributos siempre en **minúscula** siguiendo la convención Java: `private List<Ticket> tickets` no `Tickets`
- No usar punto y coma después de las anotaciones: `@ManyToMany(mappedBy = "x")` sin `;` al final

### Sobre la BD
- `@Table` es **opcional** si el nombre de la tabla coincide con el nombre de la clase
- Las listas Java no existen en la BD, solo existen llaves foráneas
- JPA crea todas las llaves foráneas y tablas intermedias automáticamente
- pgAdmin puede no dibujar todas las relaciones en el ERD visual, pero puedes verificarlas en **Properties > Clave Foránea**

---

## 6. Modelo Completo del Proyecto — Agencia de Transporte

```
Persona (clase padre)
├── id (PK, IDENTITY)
├── nombre
├── edad
├── fechaNacimiento (LocalDate)
└── genero (Enum: MASCULINO, FEMENINO, OTRO)

Cliente extends Persona
├── id (PK + FK → Persona)
├── List<Ticket> tickets (@OneToMany)
└── List<EmpresaDeTransporte> empresas (@ManyToMany)

Ticket
├── idTicket (PK, IDENTITY)
├── precioTicket
├── fechaYhoraDeSalida (LocalDateTime)
└── id_cliente (FK → Cliente) (@ManyToOne)

EmpresaDeTransporte
├── nitEmpresa (PK, IDENTITY)
├── nombreEmpresa
└── List<Cliente> clientes (@ManyToMany + @JoinTable)

TablaIntermedia (generada automáticamente)
├── nit_empresa (FK → EmpresaDeTransporte)
└── id_cliente (FK → Cliente)
```

---

*Resumen generado — Marzo 2026*
