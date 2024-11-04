DROP DATABASE Biblioteca;
CREATE DATABASE IF NOT EXISTS Biblioteca;
USE Biblioteca;

CREATE TABLE IF NOT EXISTS Livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    ano_publicacao INT,
    preco DECIMAL(5,2)
);

CREATE TABLE IF NOT EXISTS Emprestimos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_livro INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    FOREIGN KEY (id_livro) REFERENCES Livros(id)
);

INSERT INTO Livros (titulo, autor, ano_publicacao, preco)
VALUES
('1984', 'George Orwell', 1949, 29.90),
('O senhor dos anéis', 'J.R.R. Tolkien', 1954, 49.90),
('Dom Casmurro', 'Machado de Asis', 1899, 19.90),
('Cem Anos de Solidão', 'Gabriel Garcia Marquez', 1967, 39.90);

SELECT * FROM Livros;

INSERT INTO Emprestimos (id_livro, data_emprestimo, data_devolucao)
VALUES
(1, '2024-10-01', '2024-10-15'),
(2, '2024-10-05', NULL),
(1, '2024-09-20', '2024-10-05'),
(3, '2024-10-10', NULL);

INSERT INTO Livros(titulo, autor, ano_publicacao, preco)
VALUES
('Orgulho e Preconceito', 'Jane Austen', 1813,  29.90),
('Grande Sertão: Veredas', 'João Guimarães Rosa', 1956,  45.00),
('A Metamorfose', 'Franz Kafka', 1915,  19.90),
('O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 1943, 18.90),
('A Revolução dos Bichos', 'George Orwell', 1945,  24.90),
('Moby Dick', 'Herman Melville', 1851,  35.00),
('O Estrangeiro', 'Albert Camus', 1942,  28.00),
('Hamlet', 'William Shakespeare', 1603,  25.00),
('Em Busca do Tempo Perdido', 'Marcel Proust', 1913,  49.90),
('A Montanha Mágica', 'Thomas Mann', 1924,  42.00);


INSERT INTO Emprestimos(id_livro, data_emprestimo, data_devolucao)
VALUES
(4, '2024-09-12', '2024-09-20'),
(7, '2024-10-08', NULL),
(1, '2024-09-25', '2024-10-01'),
(10, '2024-10-02', '2024-10-18'),
(3, '2024-09-15', '2024-09-29'),
(5, '2024-10-12', NULL),
(9, '2024-09-30', '2024-10-10'),
(2, '2024-10-03', '2024-10-17'),
(8, '2024-09-28', NULL),
(6, '2024-10-05', '2024-10-15'),
(10, '2024-09-18', '2024-09-30'),
(1, '2024-09-25', NULL),
(7, '2024-10-10', '2024-10-20'),
(5, '2024-10-01', '2024-10-11'),
(2, '2024-09-20', NULL),
(9, '2024-10-06', '2024-10-14'),
(3, '2024-09-17', '2024-10-01'),
(6, '2024-10-09', NULL),
(8, '2024-09-23', '2024-09-30'),
(4, '2024-10-07', '2024-10-18');

UPDATE Emprestimos
SET data_devolução = '2024-11-03'
WHERE id = 2;

UPDATE Livros
SET preco = '25.00'
WHERE id = 3;

SELECT DATEDIFF('2024-10-01', '2024-10-15') AS DiferenciaDias;
SELECT ABS(-14) AS ValorAbsoluto;

SELECT COUNT(*) AS total_emprestimos FROM Emprestimos;

CREATE VIEW resumo_livros AS
SELECT 
    titulo,
    autor,
    ano_publicacao,
    preco,
    ROUND(preco * 0.90, 2) AS preco_com_desconto  
FROM 
    Livros;
    SELECT * FROM resumo_livros;

CREATE VIEW livros_emprestados AS
SELECT 
    L.titulo,
    L.autor,
    E.data_emprestimo,
    E.data_devolucao
FROM 
    Emprestimos E
JOIN 
    Livros L ON E.id_livro = L.id
WHERE 
    E.data_devolucao IS NULL;
    SELECT * FROM livros_emprestados;

    CREATE VIEW estatisticas_emprestimos AS
SELECT 
    E.id_livro,
    COUNT(E.id) AS total_emprestimos,
    SUM(CASE WHEN E.data_devolucao IS NULL THEN 1 ELSE 0 END) AS emprestimos_em_aberto
FROM 
    Emprestimos E
GROUP BY 
    E.id_livro;
    SELECT * FROM estatisticas_emprestimos;

    CREATE OR REPLACE VIEW estatisticas_emprestimos AS
SELECT 
    E.id_livro,
    COUNT(E.id) AS total_emprestimos,
    SUM(CASE WHEN E.data_devolucao IS NULL THEN 1 ELSE 0 END) AS emprestimos_em_aberto
FROM 
    Emprestimos E
GROUP BY 
    E.id_livro
HAVING 
    emprestimos_em_aberto > 0;
    SELECT * FROM estatisticas_emprestimos;


    SELECT * FROM resumo_livros ORDER BY ano_publicacao DESC;
    

    CREATE VIEW emprestimos_por_mes AS
SELECT MONTH(data_emprestimo) AS numero_mes,
    COUNT(*) AS quantidade_emprestimos
FROM 
    Emprestimos
WHERE 
    YEAR(data_emprestimo) = 2024
GROUP BY 
    MONTH(data_emprestimo)
ORDER BY 
    numero_mes;
    SELECT * FROM emprestimos_por_mes;

    SELECT  MONTH(data_emprestimo) AS numero_mes,
    COUNT(*) AS quantidade_emprestimos
FROM 
    Emprestimos
GROUP BY 
    MONTH(data_emprestimo)
HAVING 
    COUNT(*) > 2
ORDER BY 
    numero_mes;