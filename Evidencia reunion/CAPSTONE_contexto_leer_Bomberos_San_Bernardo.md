# ACTA CONSOLIDADA DE LEVANTAMIENTO DE REQUERIMIENTOS
## Proyecto Capstone – Bomberos de San Bernardo
**Tipo de documento:** Acta técnica / consolidado de reunión y levantamiento de requerimientos  
**Uso:** Documento interno para el equipo de Capstone  
**Estado:** Borrador consolidado sujeto a validación con Bomberos  
**Fecha de elaboración:** 4 de septiembre de 2026  

> **Importante:** Este documento no es una transcripción literal palabra por palabra. Es una consolidación detallada de las conversaciones compartidas por el equipo, organizada para transformar lo planteado por Bomberos en problemáticas, requerimientos, reglas y tareas de proyecto. Los puntos marcados “por validar” no deben considerarse datos definitivos hasta confirmarlos con Bomberos.

## 1. Objetivo de la reunión
La reunión buscó generar el primer contacto entre Bomberos de San Bernardo y los equipos de estudiantes de Capstone, conocer problemáticas reales y definir una solución que pueda desarrollarse durante el proyecto. El trabajo posterior debe realizarse de forma iterativa: los estudiantes presentan avances y mockups, Bomberos entrega retroalimentación y el equipo ajusta la solución antes de continuar.

## 2. Resumen ejecutivo
La reunión tuvo como objetivo presentar a los equipos de estudiantes el contexto real de Bomberos de San Bernardo y levantar problemáticas que puedan transformarse en una solución de software para el proyecto Capstone. La necesidad principal planteada por Bomberos no es únicamente contar con un inventario, sino disponer de un sistema de gestión centralizado que permita mantener trazabilidad de artículos y equipamiento, administrar inventarios separados por compañía, controlar entregas y devoluciones, registrar préstamos entre compañías, gestionar activos y costos, y apoyar el mantenimiento preventivo y correctivo de carros, camiones y otros equipos mediante check-in diarios, kilometraje, horas de uso y alertas. La Comandancia requiere una visión global de todas las compañías, mientras que cada compañía debe conservar su propio inventario y registros sin mezclar información con las demás.

## 3. Problemáticas principales detectadas
- **Información descentralizada:** Gran parte de los inventarios se mantiene actualmente en planillas Excel, computadores y correos propios de cada compañía. No existe un sistema general equivalente al sistema de despacho.
- **Falta de trazabilidad:** No siempre es posible saber con claridad quién recibió un elemento, en qué estado salió, cuándo volvió, por qué se reemplazó, perdió o dio de baja, ni qué documento respalda ese cambio.
- **Inventarios no consolidados:** Cada compañía puede conocer su información, pero Comandancia necesita una visión general y actualizada sin esperar levantamientos manuales periódicos.
- **Riesgo de duplicidad o modificación sin historial:** Se mencionó que al trabajar con planillas pueden repetirse registros o modificarse cantidades sin dejar evidencia clara de lo ocurrido.
- **Dificultad para compartir recursos:** Si una compañía se queda sin un material, hoy no existe una búsqueda central simple que permita saber rápidamente qué otra compañía dispone de ese elemento y registrar formalmente un préstamo.
- **Mantenimiento reactivo:** Bomberos busca reducir reparaciones correctivas y tiempos fuera de servicio, anticipando revisiones, cambios de aceite y otros procedimientos antes de que aparezca una falla grave.
- **Seguimiento insuficiente de uso:** El kilometraje por sí solo no representa el desgaste real: bombas, escalas mecánicas, brazos u otros equipos pueden funcionar con el vehículo detenido, por lo que también se necesitan horas de uso.
- **Poca información para decisiones de inversión:** Se necesita conocer valor, vida útil, depreciación, vencimientos, historial de fallas y costos para justificar compras, reposiciones y priorización presupuestaria.

## 4. Visión de la solución solicitada
La visión que se desprende de la reunión es un **sistema centralizado de gestión de inventario, trazabilidad, activos y mantenimiento**, con inventarios independientes por compañía y una vista global para Comandancia. La solución debe permitir pasar desde registros dispersos y reactivos a un control histórico, trazable y preventivo.

## 5. Alcance funcional consolidado por módulos

### Módulo 1 – Inventario general
- Registrar artículos, materiales, uniformes y equipamiento.
- Mantener un catálogo maestro con códigos comunes para todas las compañías.
- Registrar cantidades disponibles por compañía o dependencia.
- Permitir búsqueda por código, nombre, categoría u otros datos relevantes.
- Mostrar a Comandancia en qué compañía existe disponibilidad de un artículo.

### Módulo 2 – Trazabilidad individual de equipos
- Registrar el número de serie que ya trae el equipo cuando corresponda; no asumir que el sistema debe inventarlo.
- Registrar estado del elemento (por ejemplo: nuevo, usado, roto u otro estado definido por Bomberos).
- Agregar observaciones de recepción, entrega y devolución.
- Mantener historial de cambios de estado, reemplazos, pérdidas, bajas y movimientos.
- Asociar documentación, informes, notas o investigación cuando exista una pérdida o baja.

### Módulo 3 – Asignación a bomberos
- Registrar qué uniforme o equipo se entrega a cada bombero.
- Guardar fecha de entrega, estado de salida y observaciones.
- Registrar devolución y estado en que regresa el elemento.
- Saber exactamente qué elementos debe devolver un bombero al retirarse o cambiar de condición.
- Mantener historial si un elemento asignado fue reemplazado por daño, desgaste u otra causa.

### Módulo 4 – Gestión por compañías y roles
- Mantener inventarios separados por compañía.
- Evitar que los datos operativos de una compañía se mezclen con los de otra.
- Contar con usuarios u operadores asociados a cada compañía.
- Contar con un superusuario o rol de Comandancia con visión global.
- Permitir reportes diarios, mensuales y generales desde la vista de Comandancia.
- Registrar logs o historial de acciones para conservar trazabilidad.

### Módulo 5 – Préstamos entre compañías
- Permitir localizar un artículo disponible en otra compañía.
- Registrar compañía que entrega y compañía que recibe.
- Registrar artículo, cantidad, fecha de préstamo, responsable y devolución.
- Mantener el estado del préstamo (pendiente, devuelto, vencido u otro).
- Conservar historial para saber dónde estuvo cada recurso.

### Módulo 6 – Unidades, carros y activos automotrices
- Registrar carros bomba, camiones, camionetas u otras unidades definidas por Bomberos.
- Guardar antecedentes de identificación, especificaciones, documentación, fechas relevantes y otros datos de cada unidad.
- Separar conceptualmente la información automotriz del inventario general cuando corresponda.
- Mantener historial de mantenciones y reparaciones por unidad.

### Módulo 7 – Check-in / checklist diario
- Permitir que la compañía registre la revisión diaria de una unidad.
- Registrar kilometraje al inicio o momento definido por Bomberos.
- Registrar horas de uso de bombas, escalas, brazos u otros componentes cuando corresponda.
- Registrar fallas u observaciones detectadas por el cuartelero o responsable.
- Permitir a Comandancia identificar qué compañía o unidad no realizó el check-in esperado.

### Módulo 8 – Mantenimiento preventivo y correctivo
- Configurar mantenimientos por fecha, kilometraje, horas de uso u otra condición.
- Considerar que los intervalos pueden variar según modelo o tipo de unidad.
- Generar alertas antes de llegar al límite definido para cambio de aceite, revisión técnica u otro procedimiento.
- Registrar mantenciones realizadas, fallas, reparaciones, costos y tiempos fuera de servicio.
- Distinguir mantenimiento preventivo de correctivo.
- Usar historial para detectar fallas repetitivas y apoyar decisiones sobre mecánicos, conductores, capacitación u otras medidas.

### Módulo 9 – Valorización, vida útil y reposición
- Registrar valor referencial o valorizado de activos cuando Bomberos lo requiera.
- Mantener datos de vida útil, vencimiento y condición del elemento.
- Apoyar cálculo o registro de depreciación/amortización según la definición que valide Bomberos.
- Permitir estimar necesidades futuras de reposición.
- Facilitar reportes que sirvan para auditorías, justificación presupuestaria o decisiones de inversión.

### Módulo 10 – Reportes y consulta consolidada
- Generar reportes de inventario por compañía y consolidados.
- Consultar cantidades, ubicación, estado y movimientos de artículos.
- Consultar cumplimiento de check-in diarios.
- Consultar historial de mantenciones, fallas, costos y disponibilidad de unidades.
- Dejar preparada la información para análisis y estadísticas futuras.

## 6. Roles y perfiles de usuario identificados
| Rol | Función esperada |
|---|---|
| **Superusuario / Comandancia** | Visualización global de todas las compañías, reportes consolidados, búsqueda transversal, control de cumplimiento y visión general del sistema. |
| **Usuario/operador de compañía** | Mantención del inventario y registros propios de su compañía, check-in diario, movimientos y operaciones autorizadas. |
| **Responsables de Material Mayor / Material Menor** | Actores clave para validar categorías, materiales, movimientos y reglas del inventario. Sus permisos definitivos deben acordarse. |
| **Responsable de mantenimiento / área automotriz** | Actor a definir para validar unidades, mantenimiento, kilometraje, horas, fallas, costos y alertas. |
| **Bombero receptor de equipamiento** | Principalmente entidad asociada a entregas y devoluciones. No se confirmó que necesite acceso directo al sistema. |

## 7. Reglas de negocio importantes
- El mismo tipo de artículo debe conservar el mismo código maestro en todas las compañías.
- El número de serie de un equipo debe registrarse desde el identificador real del elemento cuando éste exista.
- Los inventarios de las compañías deben mantenerse separados, aunque Comandancia pueda consultarlos de forma consolidada.
- Toda baja, pérdida, reemplazo, préstamo, devolución o cambio relevante debe dejar historial y responsable.
- No se debería eliminar o modificar información crítica sin trazabilidad de qué ocurrió.
- Las alertas de mantenimiento deben poder configurarse según el tipo/modelo de unidad y no utilizar un único intervalo para todos.
- El mantenimiento debe considerar kilometraje y, cuando corresponda, horas de uso de bombas u otros componentes.
- El check-in diario debe permitir identificar quién registró la revisión y cuándo se realizó.
- Los préstamos entre compañías deben mantener trazabilidad hasta la devolución.
- Las fórmulas o reglas de depreciación, amortización y vida útil deben validarse con Bomberos antes de implementarse como cálculo oficial.

## 8. Flujos de trabajo que el sistema debería soportar
- **Alta de artículo/equipo:** Seleccionar o crear tipo en catálogo maestro → registrar código común → ingresar datos del elemento → número de serie si existe → estado y observaciones → asignar compañía/dependencia.
- **Entrega a bombero:** Seleccionar elemento disponible → seleccionar bombero → registrar fecha, estado y observaciones de entrega → confirmar responsable → dejar movimiento en historial.
- **Devolución de equipamiento:** Buscar asignación → registrar fecha de devolución → indicar estado de retorno y observaciones → dejar disponible, en reparación, dado de baja u otro estado validado.
- **Préstamo entre compañías:** Comandancia/usuario autorizado busca disponibilidad → selecciona compañía origen y destino → registra préstamo → sistema descuenta/compromete disponibilidad → registra devolución posterior.
- **Check-in diario de unidad:** Seleccionar unidad → registrar kilometraje → registrar horas de uso relevantes → completar revisión/observaciones → reportar fallas → confirmar check-in.
- **Alerta de mantenimiento:** Sistema compara fecha/kilometraje/horas con regla configurada → genera aviso previo → responsable programa intervención → se registra mantenimiento realizado → se recalcula próximo vencimiento.
- **Baja o pérdida:** Seleccionar elemento → indicar motivo → adjuntar/registrar antecedente → identificar responsable/autorización → cambiar estado sin borrar historial.

## 9. Datos principales que probablemente deberá manejar la base de datos

### Compañía / dependencia
ID, número, nombre, color (por validar), especialidad (por validar), estado, responsables.

### Catálogo maestro de artículos
código común, nombre, categoría, subcategoría, unidad de medida, descripción, requiere serie sí/no.

### Elemento físico / activo
ID interno, código de producto, número de serie, compañía, estado, condición, origen, fecha de ingreso, valor, vida útil/vencimiento, observaciones.

### Asignación a bombero
bombero, elemento, fecha entrega, estado de entrega, observación de entrega, fecha devolución, estado devolución, observación devolución.

### Préstamo
compañía origen, compañía destino, elemento/cantidad, fecha, responsables, fecha esperada devolución, fecha real devolución, estado.

### Unidad / vehículo
identificador, tipo, marca/modelo, año, matrícula/patente si corresponde, kilometraje, horas de uso relevantes, revisión técnica/fechas, estado operativo, observaciones.

### Check-in
unidad, fecha/hora, responsable, kilometraje, horas de bomba, horas de escala/brazo si aplica, fallas, observaciones, resultado.

### Mantenimiento
unidad/equipo, tipo preventivo/correctivo, fecha, causa, trabajo realizado, kilometraje, horas, costo, proveedor/taller, tiempo fuera de servicio, repuestos, próximo mantenimiento.

## 10. Situación tecnológica actual informada por Bomberos
- Bomberos ya dispone de un servidor local para el sistema de despacho y utiliza esos datos para estadísticas operativas.
- No se confirmó una base de datos central equivalente para inventario y mantenimiento.
- Muchas compañías trabajan con Excel, archivos locales, correos y computadores propios.
- Bomberos indicó que puede compartir planillas Excel actuales y ejemplos de inventario para apoyar el levantamiento.
- Se ofreció la posibilidad de conocer físicamente una unidad para comprender mejor el checklist y uso real de las máquinas.
- Se planteó incorporar en futuras reuniones a personal de Material Mayor y Material Menor para validar el diseño.

## 11. Requerimientos no funcionales / cualidades esperadas
Los siguientes puntos se desprenden de lo conversado. Cuando se indica “recomendación técnica derivada”, no corresponde a una solicitud textual de Bomberos, sino a una necesidad lógica para cumplir lo pedido.

| Cualidad | Justificación |
|---|---|
| **Trazabilidad/Auditoría** | Derivada directamente de la preocupación por pérdidas, modificaciones y control. Debe quedar historial de cambios, usuario, fecha y motivo. |
| **Separación lógica de datos** | Cada compañía debe trabajar con sus datos sin mezclarlos, mientras Comandancia visualiza el consolidado. |
| **Usabilidad** | El sistema debe ser entendible para personal operativo y administrativo; se espera validación mediante mockups y retroalimentación. |
| **Disponibilidad de información** | Comandancia busca información actualizada y consulta en tiempo real o cercana al tiempo real, evitando esperar inventarios trimestrales. |
| **Respaldo e integridad** | Recomendación técnica derivada del valor económico de los datos; la estrategia concreta debe definirse al revisar el servidor. |
| **Escalabilidad funcional** | La solución debe poder incorporar varias compañías/dependencias y potencialmente crecer a más áreas sin rediseñar todo el sistema. |

## 12. Datos cuantitativos mencionados durante la reunión (POR VALIDAR)
Estas cifras sirven para entender la magnitud del problema, pero no deben utilizarse en documentación formal, cálculos o presentaciones sin confirmación de Bomberos.

| Tema | Lo mencionado / observación |
|---|---|
| **Número de compañías** | Se habló de nueve compañías bajo la estructura operativa; sin embargo, durante la conversación se mencionaron numeraciones hasta la Décima. La estructura exacta debe confirmarse. |
| **Presupuesto anual** | Se mencionó verbalmente un presupuesto anual del orden de miles de millones de pesos. La cifra exacta debe validarse antes de usarla formalmente. |
| **Gasto en reparaciones** | Se indicó que las reparaciones han consumido una proporción importante del presupuesto; se mencionó aproximadamente 25% en la conversación. Validar. |
| **Uniformes** | Se mencionó una inversión reciente cercana a 200–210 millones de pesos. Validar monto y periodo. |
| **Equipos de respiración** | Se mencionaron aproximadamente 300 equipos circulando y compras de cilindros; validar inventario real. |
| **Costo de equipos** | Se mencionaron valores de varios millones de pesos para equipos de respiración y cientos de miles para botas. Deben considerarse ejemplos referenciales hasta recibir información oficial. |
| **Unidades/material mayor** | Se mencionó un orden de decenas de unidades (alrededor de 50 en una parte de la conversación). Validar alcance exacto. |

## 13. Priorización propuesta para el equipo (NO es decisión final de Bomberos)
Esta priorización es una propuesta para que el grupo pueda acotar el trabajo dentro de los tres meses de Capstone. Debe validarse con el docente y con Bomberos.

### Prioridad 1 – Esencial para demostrar la solución
- Usuarios/roles básicos y separación por compañía.
- Catálogo maestro común de artículos.
- Inventario por compañía.
- Número de serie, estado y observaciones.
- Asignación y devolución de equipamiento a bomberos.
- Registro básico de unidades.
- Check-in diario con kilometraje/horas y observaciones.
- Mantenimiento programado y alertas básicas.
- Vista global de Comandancia y reportes básicos.

### Prioridad 2 – Alto valor si el tiempo lo permite
- Préstamos entre compañías.
- Bajas/pérdidas con documentación.
- Historial detallado de mantenimiento y costos.
- Valorización, vida útil y vencimientos.
- Reportes consolidados más completos.

### Prioridad 3 – Evolución futura
- Analítica avanzada y dashboards históricos.
- Cálculos formales complejos de depreciación/amortización una vez validados.
- Integraciones con otros sistemas de Bomberos, incluido despacho, solo si se solicita y se cuenta con acceso.
- Automatizaciones adicionales, notificaciones multicanal o acceso externo avanzado.

## 14. Puntos pendientes por validar con Bomberos
- [ ] Confirmar el número exacto de compañías y dependencias que estarán dentro de la primera versión.
- [ ] Confirmar nombres, colores y especialidades oficiales de cada compañía. El audio contiene asociaciones parciales y confusas.
- [ ] Definir el alcance mínimo obligatorio (MVP) para los tres meses de Capstone y separar funciones futuras.
- [ ] Recibir las planillas Excel actuales de inventario y las planillas/registros automotrices.
- [ ] Definir campos exactos del checklist diario y quién debe completarlo.
- [ ] Definir qué unidades y componentes usarán kilometraje, horas de uso o ambos.
- [ ] Definir reglas de alerta: cuánta anticipación, canal de notificación y quién recibe el aviso.
- [ ] Definir permisos de cada rol: lectura, creación, edición, baja, préstamo, aprobación y reportes.
- [ ] Definir flujo formal de baja/pérdida y documentos obligatorios.
- [ ] Definir reglas formales de valorización, depreciación y amortización según las necesidades de auditoría.
- [ ] Revisar la infraestructura del servidor local, tecnologías disponibles, respaldo, red y acceso entre compañías.
- [ ] Confirmar si el sistema funcionará solo en red local, VPN, internet u otra arquitectura.
- [ ] Definir si se requiere migración de datos históricos desde Excel y cuántos años de información deben conservarse.
- [ ] Definir reportes prioritarios para Comandancia y responsables de compañías.
- [ ] Definir si los bomberos individuales tendrán cuenta propia o solo serán registros asociados a equipamiento.

## 15. Límites y cosas que NO debemos asumir todavía
- No se solicitó reemplazar el sistema de despacho existente; se mencionó solo como ejemplo de un área que ya está automatizada y genera estadísticas.
- No se confirmó que el nuevo sistema deba integrarse inmediatamente con el sistema de despacho.
- No se confirmó una migración a nube. Bomberos indicó que actualmente dispone de un servidor local para despacho.
- No se debe asumir una fórmula oficial de depreciación/amortización hasta que Bomberos entregue el criterio que utiliza en auditorías.
- Los colores y especialidades de las compañías no deben cargarse como dato definitivo hasta ser confirmados.

## 16. Próximas acciones recomendadas para el equipo
1. Compartir este documento con todo el grupo y usarlo como base común del levantamiento.
2. Solicitar a Bomberos las planillas Excel de inventario y, si existe, la documentación/planilla de mantenimiento automotriz.
3. Preparar un primer modelo de módulos y flujos para revisión con el docente.
4. Crear mockups de inventario, asignación, check-in, mantenimiento y panel de Comandancia.
5. Realizar una nueva sesión de validación con Bomberos y, de ser posible, con Material Mayor y Material Menor.
6. Visitar o revisar una unidad real para documentar el checklist diario y las variables de uso.
7. Definir MVP del proyecto considerando el plazo académico hasta el 11 de diciembre.
8. Registrar por escrito los cambios que Bomberos apruebe o rechace en cada iteración.

## 17. Criterios de éxito iniciales del proyecto
Una primera versión del sistema debería considerarse exitosa si logra, como mínimo, demostrar que:
- Cada compañía puede mantener su inventario sin mezclar datos con las demás.
- Comandancia puede consultar una visión consolidada y localizar recursos disponibles.
- Los elementos con serie pueden rastrearse desde su ingreso hasta asignaciones, devoluciones, préstamos, bajas o pérdidas.
- El sistema permite registrar check-in de unidades y usar kilometraje/horas para anticipar mantenimiento.
- Las alertas preventivas pueden configurarse de acuerdo con la realidad de cada unidad o equipo.
- Los cambios importantes quedan registrados con responsable, fecha y motivo.
- Bomberos puede revisar mockups/avances, entregar observaciones y el equipo puede iterar sobre ellas.

## 18. Conclusión del levantamiento
La reunión muestra que la necesidad de Bomberos de San Bernardo es transversal: inventario, trazabilidad, control económico, mantenimiento y gestión multi-compañía están hoy fragmentados. El valor principal del proyecto será centralizar la información sin perder la independencia de cada compañía y transformar registros manuales/reactivos en datos trazables que permitan actuar antes de una pérdida, una falta de stock o una falla mecánica. Para el equipo de Capstone, la prioridad inmediata es validar el MVP con Bomberos, recibir las planillas actuales y convertir estos requerimientos en mockups, modelo de datos y casos de uso.