# Solução utilizando capacidades de Machine Learning

## Entrega:
    - Definição e justificativa da tecnologia de dados;
    - Sugestão de modelo de dados e formas de uso da ferramenta;

### 1 - Definição e justificativa da tecnologia de dados;
    Para gerar valor através dos dados dos clientes é necessário aprofundar análises de informações que muitas vezes não se encontram prontas no banco de dados.
    
    Essas análises de informações passam por processos de captura, limpeza e análise, que identificam aquilo que é realmente relevante para o negócio através de processos de machine learning.

    Para gerenciar e armazenar grandes quantidades de informações(BIG DATA) sugerimos o HIVE por seu foco em analytics.
    
    O hive vai proporcionar um acesso de qualidade a informações com baixa integridade, baixo custo de armazenamento e escalabilidade.

    Seu acesso é facilitado pelo Spark ou Hue. 
    
    Para armazenar as informações de maneira a otimizar leitura, escrita e processamento utlizaremos ORC. Caso seja um grande volume de dados, podemos particionar em diretórios HDFS.

### 2 - Sugestão de modelo de dados e formas de uso da ferramenta;
    
    Sugerimos utilizar o Hive com uma modelagem Star Schema baseado em tabelas FATO, acessando via Hue que já possui uma interface que utiliza HiveQl de fácil usabilidade.
