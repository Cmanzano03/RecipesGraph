
# RecipesGraph — Minería de grafos aplicada a recetas

Este proyecto ha sido desarrollado para la asignatura **MDAD (Minería de Datos)** y consiste en una aplicación basada en **Neo4j** que permite analizar y recomendar recetas en función de ingredientes, alergias y dietas mediante el uso de grafos.

---

## Dataset

Se ha utilizado el dataset [Food Ingredients and Allergens](https://www.kaggle.com/datasets/uom190346a/food-ingredients-and-allergens), al que se le han añadido:

- Clasificación del macronutriente principal
- Nivel calórico estimado
- Dietas compatibles (vegana, keto, halal, etc.)

Todo esto se realiza con un notebook de preprocesado (`ETL_Recetas.ipynb`).

---

## Estructura del grafo

El grafo en Neo4j incluye los siguientes tipos de nodos:

- `:Meal`
- `:Ingredient`
- `:Allergen`
- `:Diet`

Y relaciones como:

- `(:Meal)-[:CONTAINS_INGREDIENT]->(:Ingredient)`
- `(:Ingredient)-[:IS_ALLERGEN]->(:Allergen)`
- `(:Meal)-[:COMPATIBLE_WITH]->(:Diet)`

---

## Algoritmos aplicados (minado)

Se han aplicado tres algoritmos de análisis de grafos con la librería **Neo4j Graph Data Science**:

1. **Node Similarity**  
   Detecta similitud entre platos en función de sus ingredientes. Se usa para generar relaciones `:SIMILAR_TO`.

2. **Louvain**  
   Algoritmo de detección de comunidades que agrupa automáticamente platos en clústeres densamente conectados. Permite interpretar conjuntos de recetas similares sin etiquetas previas.

3. **PageRank**  
   Aplicado a los ingredientes para identificar cuáles son los más influyentes o centrales en el conjunto de recetas.

---

## Visualizaciones

- **Pyvis**: grafos interactivos de platos similares y comunidades
- **Seaborn / Matplotlib**: gráficos de barras para comunidades y PageRank

---

## Cómo usar

1. Instala las dependencias:
   ```bash
   pip install -r requirements.txt
   ```

2. Lanza Neo4j localmente (puerto 7689) con el usuario `neo4j` y contraseña `admin123`

3. Ejecuta el notebook `ETL_Recetas.ipynb`:

   * Preprocesa el dataset
   * Carga el grafo en Neo4j
   
4. Ejecuta los comandos del archivo `minado.cypher`:
   ```bash
   cypher-shell -u neo4j -p tu_contraseña -f minado.cypher
   ```

5. Ejecuta los mismos algoritmos desde el notebook mediante la librería de `neo4j` para poder tener una mejor visulización de los datos.

6. Abre los archivos HTML generados (`similitud_meals.html`, `meal_communities.html`) para visualizar los grafos.

---

## Autores

Trabajo académico realizado para la asignatura **Minería de Datos (MDAD)**.
Desarrollado por:

* [Cmanzano03](https://github.com/Cmanzano03)
* [GuiBerm](https://github.com/GuiBerm)


