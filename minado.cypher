//Minado 1, NodeSimilariy
CALL gds.graph.project.cypher(
  'meal_similarity',
  'MATCH (m:Meal) RETURN id(m) AS id',
  'MATCH (m1:Meal)-[:CONTAINS_INGREDIENT]->(i:Ingredient)<-[:CONTAINS_INGREDIENT]-(m2:Meal)
   WHERE id(m1) < id(m2)
   RETURN id(m1) AS source, id(m2) AS target'
)


CALL gds.nodeSimilarity.write('meal_similarity', {
  writeRelationshipType: 'SIMILAR_TO',
  writeProperty: 'score',
  similarityCutoff: 0.3
})
YIELD nodesCompared, relationshipsWritten, similarityDistribution;


MATCH (m1:Meal)-[r:SIMILAR_TO]->(m2:Meal)
RETURN m1.name AS Meal1, m2.name AS Meal2, r.score
ORDER BY r.score DESC
LIMIT 20;


//Minado 2, Louvain
CALL gds.graph.project(
  'meal_communities',
  'Meal',
  {
    SIMILAR_TO: {
      type: 'SIMILAR_TO',
      properties: 'score'
    }
  }
);


CALL gds.louvain.write('meal_communities', {
  writeProperty: 'community'
})
YIELD communityCount, modularity, modularities;


MATCH (m:Meal)
RETURN m.community AS comunidad, count(*) AS total
ORDER BY total DESC;


MATCH (m:Meal)
WHERE m.community = 0
RETURN m.name
LIMIT 20;


//Minado 3, Page Rank
CALL gds.graph.project(
  'ingredient_rank',
  ['Meal', 'Ingredient'],
  {
    CONTAINS_INGREDIENT: {
      type: 'CONTAINS_INGREDIENT',
      orientation: 'UNDIRECTED'
    }
  }
);




CALL gds.pageRank.write('ingredient_rank', {
  writeProperty: 'pagerank'
})
YIELD nodePropertiesWritten, ranIterations, didConverge;




MATCH (i:Ingredient)
RETURN i.name, i.pagerank
ORDER BY i.pagerank DESC
LIMIT 20;



