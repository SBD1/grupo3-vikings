# Normalização do Modelo Relacional

## Primeira Forma Normal

Dada a inexistência de atributos multivalorados dentro do nosso modelo, a primeira forma normal está aplicada.

## Segunda Forma Normal

Visto que não existem atributos compostos e os atributos são sempre dependentes das chaves, nosso modelo está cumprindo a segunda forma normal.

## Terceira Forma Normal

Conforme a Terceira Forma Normal, as entidades e seus respectivos tipos foram desenhados justamente para não conflitar com nenhuma objeção das primeiras e segundas formas normais, e respeitar as particularidades da terceira forma normal, a partir da [versão 0.3](./prev/vikings_MRel_Normalizado-v0.3.png) do Modelo Relacional Normalizado.

## Forma Normal de Boyce-Codd

Analisando o modelo relacional, é possível perceber que todo atributo não primo depende funcionalmente da chave primária nas tabelas, com isso concluímos que se enquadra na forma normal de boyce-codd.

## Quarta Forma Normal

Conforme a Quarta Forma Normal, não existem campos que se repetem em relação a chave primária e gerem uma redundância desnecessária nas tabelas.
