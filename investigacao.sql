CREATE DATABASE investigacao;
USE investigacao;

#Criação da tabela investigadores
CREATE TABLE investigadores (
	id INT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    idade INT NOT NULL,
    etnia VARCHAR(10) NOT NULL,
    genero VARCHAR(20) NOT NULL);

#Criação da tabela suspeitos
CREATE TABLE suspeitos (
	id INT PRIMARY KEY, 
	nome VARCHAR(60) NOT NULL, 
    idade INT NOT NULL, 
    etnia VARCHAR(10) NOT NULL, 
    genero VARCHAR(20) NOT NULL);
#Ver a tabela suspeitos
DESC suspeitos;
#Ver os dados da tabela suspeitos
SELECT * FROM suspeitos;

#Criação da tabela vítimas
CREATE TABLE vitimas (id INT PRIMARY KEY,
	nome VARCHAR(60) NOT NULL,
    idade INT NOT NULL,
    etnia VARCHAR(10) NOT NULL,
    genero VARCHAR(20) NOT NULL);
#Ver a tabela vitimas
DESC vitimas;
#Ver os dados da tabela vitimas
SELECT * FROM vitimas;

#Criação da tabela localizações
CREATE TABLE localizacoes (id INT PRIMARY KEY,
	cidade VARCHAR(50) NOT NULL,
    estado VARCHAR(2) NOT NULL);
#Ver a tabela localizações
DESC localizacoes;
#Ver os dados da tabela localizações
SELECT * FROM localizacoes;

#Criação da tabela testemunhas
CREATE TABLE testemunhas (id INT PRIMARY KEY,
	relato TEXT NOT NULL);
#Ver a tabela testemunhas
DESC testemunhas;
#Para ver os dados da tabela testemunhas
SELECT * FROM testemunhas;

#Criação da tabela casos
CREATE TABLE casos (id INT PRIMARY KEY,
	descricao TEXT NOT NULL,
    evidencia TEXT, data date,
    idSuspeito INT NOT NULL,
    FOREIGN KEY (idSuspeito) REFERENCES suspeitos(id), 
	idVitima INT NOT NULL,
    FOREIGN KEY (idVitima) REFERENCES vitimas(id),
    idTestemunha INT, 
    FOREIGN KEY (idTestemunha) REFERENCES testemunhas(id),
    idLocalizacao INT NOT NULL,
    FOREIGN KEY (idLocalizacao) REFERENCES localizacoes(id)); 
    
#Ver a tabela casos
DESC casos;
#Ver os dados da tabela casos
SELECT * FROM casos;

#Tabela de associação para casos e investigadores (N:N)
CREATE TABLE investigadores_tem_casos(id INT PRIMARY KEY,
	idInvestigador INT NOT NULL,
    FOREIGN KEY (idInvestigador) REFERENCES investigadores(id),
    idCaso INT NOT NULL,
    FOREIGN KEY (idCaso) REFERENCES casos(id));
#Ver a tabela investigadores_tem_casos
desc investigadores_tem_casos;
#Ver a tabela casos
DESC casos;
#Ver os dados da tabela casos
SELECT * FROM casos;

#Inserção de dados da tabela investigadores
INSERT INTO investigadores (id, nome, idade, etnia, genero) VALUES
	(1, "Tomás Peralta", 18, "Branco", "Masculino"),
    (2, "Gabriely Santiago", 20, "Branco", "Feminino"),
    (3, "João Jeffords", 25, "Negro", "Masculino"),
    (4, "Felipe Boyle", 16, "Branco", "Masculino");

#Inserção de dados da tabela suspeitos
INSERT INTO suspeitos (id, nome, idade, etnia, genero) VALUES 
	(1, "João", 26, "Branco", "Masculino"), 
	(2, "Felipe", 45, "Branco", "Masculino"),
    (3, "Maria", 31, "Amarelo", "Feminino"),
    (4, "Shirley", 37,"Branco", "Feminino");

#Inserção de dados da tabela vítimas
INSERT INTO vitimas (id, nome, idade, etnia, genero) VALUES 
	(1, "Pedro", 17, "Indígena", "Masculino"), 
	(2, "José", 56, "Negro","Masculino"),
    (3, "Marcia", 29, "Amarelo","Feminino"),
    (4, "Vitoria", 22, "Branco", "Feminino");

#Inserção de dados da tabela testemunhas
INSERT INTO testemunhas (id, relato) VALUES (1, "Estava a caminho do ponto de ônibus, 
	por volta das 04 horas da manhã e escutei um breve pedido de socorro, 
	como se fosse um sussurro. Olhei em volta e não vi ninguém, então continuei meu caminho. 
    Porém eu escutei de novo a mesma voz implorando por socorro. 
    Então percebi que de fato havia escutado algo. 
    Ao olhar ao redor me deparei com um beco escuro e pequeno, e a voz aparentava vir daquela direção. 
    Ao chegar lá me deparei com aquele homem jogado no chão, seu rosto irreconhecível. 
    Foi quando liguei pedindo ajuda, pois ele estava perdendo muito sangue.");

#Inserção de dados da tabela localizações
INSERT INTO localizacoes (id, cidade, estado) VALUES 
	(1, "Balneário Camboriú", "SC"),
	(2, "Curitiba", "PR"),
    (3, "Rio Negrinho", "SC"),
    (4, "Jaraguá do Sul", "SC");

#Inserção de dados da tabela casos
INSERT INTO casos (id, descricao, evidencia, data, idSuspeito, idVitima, idTestemunha, idLocalizacao) VALUES
	(1, "Vítima foi encontrada com diversas perfurações pelo corpo e com a ausência do dedo indicador da mão direita.", 
	"Encontrado fios de cabelo na cena do crime e digitais pelo corpo da vítima.", 
	'2023-01-01', 1, 1, NULL, 1),
    (2, "O suspeito deferiu diversos golpes que a vítima teve seu rosto desfigurado, causando uma hemorragia interna e não suportou a chegada do resgate. A vítima também foi encontrada sem o dedo indicador direito.",
    "Encontrado gotas de sangue pela cena.",
    '2023-02-01', 2, 2, 1, 2), 
    (3, "Vítima recorreu a delegacia para denunciar o criminoso, relatou que foi sofreu uma tentativa de estrangulamento com uma gravata vermelha e teve seu dedo indicador esquerdo amputado.",
    "Digitais do(a) suspeito(a) no corpo da vítima.", 
	'2023-04-01', 3, 3, NULL, 3),
    (4, "A vítima foi enterrada viva em meios as árvores de uma área isolada do parque. Vitória foi encontrada 1 mês após o início das buscas com a ausência do seu dedo indicador direito.",
    "Testemunha relatou ver a vítima entrando no parque com uma mulher.",
    '2023-06-01', 4, 4, NULL, 4);
    
INSERT INTO investigadores_tem_casos (id, idInvestigador, idCaso) VALUES
	(1, 4, 1), (2, 1, 1), (3, 3, 1), (4, 2, 2), (5, 2, 3), (6, 1, 4);

#Ver o primeiro caso
SELECT casos.id AS "Nº do caso",
	GROUP_CONCAT(investigadores.nome) AS "Investigadores responsáveis",
	casos.descricao AS "Descrição",
	casos.evidencia AS "Evidência",
	vitimas.nome AS "Nome da vítima",
	suspeitos.nome AS "Nome do suspeito",
	casos.data AS "Data do caso"
	FROM casos
	JOIN suspeitos ON casos.idSuspeito = suspeitos.id
	JOIN vitimas ON casos.idVitima = vitimas.id
	JOIN investigadores_tem_casos ON casos.id = investigadores_tem_casos.idCaso
	JOIN investigadores ON investigadores_tem_casos.idInvestigador = investigadores.id
	WHERE casos.data = "2023-01-01"
	GROUP BY casos.id, casos.descricao, casos.evidencia, vitimas.nome, casos.data;

#Ver o segundo caso
SELECT casos.id AS "Nº do caso",
	GROUP_CONCAT(investigadores.nome) AS "Investigadores responsáveis",
	casos.descricao AS "Descrição",
	casos.evidencia AS "Evidência",
	vitimas.nome AS "Nome da vítima",
	suspeitos.nome AS "Nome do suspeito",
	casos.data AS "Data do caso"
	FROM casos
	JOIN suspeitos ON casos.idSuspeito = suspeitos.id
	JOIN vitimas ON casos.idVitima = vitimas.id
	JOIN investigadores_tem_casos ON casos.id = investigadores_tem_casos.idCaso
	JOIN investigadores ON investigadores_tem_casos.idInvestigador = investigadores.id
	WHERE casos.data = "2023-02-01"
	GROUP BY casos.id, casos.descricao, casos.evidencia, vitimas.nome, casos.data;

#Ver o segundo caso com o relato da testemunha
SELECT casos.id AS "Nº do caso",
	GROUP_CONCAT(investigadores.nome) AS "Investigadores responsáveis",
	casos.descricao AS "Descrição",
	casos.evidencia AS "Evidência",
	vitimas.nome AS "Nome da vítima",
	suspeitos.nome AS "Nome do suspeito",
	testemunhas.relato AS "Relato da testemunha",
	casos.data AS "Data do caso"
	FROM casos
	JOIN testemunhas ON casos.idTestemunha = testemunhas.id
	JOIN suspeitos ON casos.idSuspeito = suspeitos.id
	JOIN vitimas ON casos.idVitima = vitimas.id
	JOIN investigadores_tem_casos ON casos.id = investigadores_tem_casos.idCaso
	JOIN investigadores ON investigadores_tem_casos.idInvestigador = investigadores.id
	WHERE casos.data = "2023-02-01"
	GROUP BY casos.id, casos.descricao, casos.evidencia, vitimas.nome, casos.data;

#Ver o primeiro e segundo caso juntos
SELECT casos.id AS "Nº do caso",
	GROUP_CONCAT(investigadores.nome) AS "Investigadores responsáveis",
	casos.descricao AS "Descrição",
	casos.evidencia AS "Evidência",
	vitimas.nome AS "Nome da vítima",
	suspeitos.nome AS "Nome do suspeito",
	casos.data AS "Data do caso"
	FROM casos
	JOIN suspeitos ON casos.idSuspeito = suspeitos.id
	JOIN vitimas ON casos.idVitima = vitimas.id
	JOIN investigadores_tem_casos ON casos.id = investigadores_tem_casos.idCaso
	JOIN investigadores ON investigadores_tem_casos.idInvestigador = investigadores.id
	WHERE casos.data <= "2023-02-01"
	GROUP BY casos.id, casos.descricao, casos.evidencia, vitimas.nome, casos.data;

#Ver se houve caso no dia 2023-03-01
SELECT casos.id AS "Nº do caso",
	GROUP_CONCAT(investigadores.nome) AS "Investigadores responsáveis",
	casos.descricao AS "Descrição",
	casos.evidencia AS "Evidência",
	vitimas.nome AS "Nome da vítima",
	suspeitos.nome AS "Nome do suspeito",
	casos.data AS "Data do caso"
	FROM casos
	JOIN suspeitos ON casos.idSuspeito = suspeitos.id
	JOIN vitimas ON casos.idVitima = vitimas.id
	JOIN investigadores_tem_casos ON casos.id = investigadores_tem_casos.idCaso
	JOIN investigadores ON investigadores_tem_casos.idInvestigador = investigadores.id
	WHERE casos.data = "2023-03-01"
	GROUP BY casos.id, casos.descricao, casos.evidencia, vitimas.nome, casos.data;

#Ver o terceiro caso
SELECT casos.id AS "Nº do caso",
	GROUP_CONCAT(investigadores.nome) AS "Investigadores responsáveis",
	casos.descricao AS "Descrição",
	casos.evidencia AS "Evidência",
	vitimas.nome AS "Nome da vítima",
	suspeitos.nome AS "Nome do suspeito",
	casos.data AS "Data do caso"
	FROM casos
	JOIN suspeitos ON casos.idSuspeito = suspeitos.id
	JOIN vitimas ON casos.idVitima = vitimas.id
	JOIN investigadores_tem_casos ON casos.id = investigadores_tem_casos.idCaso
	JOIN investigadores ON investigadores_tem_casos.idInvestigador = investigadores.id
	WHERE casos.data = "2023-04-01"
	GROUP BY casos.id, casos.descricao, casos.evidencia, vitimas.nome, casos.data;

#Ver todos os casos até o terceiro
SELECT casos.id AS "Nº do caso",
	GROUP_CONCAT(investigadores.nome) AS "Investigadores responsáveis",
	casos.descricao AS "Descrição",
	casos.evidencia AS "Evidência",
	vitimas.nome AS "Nome da vítima",
	suspeitos.nome AS "Nome do suspeito",
	casos.data AS "Data do caso"
	FROM casos
	JOIN suspeitos ON casos.idSuspeito = suspeitos.id
	JOIN vitimas ON casos.idVitima = vitimas.id
	JOIN investigadores_tem_casos ON casos.id = investigadores_tem_casos.idCaso
	JOIN investigadores ON investigadores_tem_casos.idInvestigador = investigadores.id
	WHERE casos.data <= "2023-04-01"
	GROUP BY casos.id, casos.descricao, casos.evidencia, vitimas.nome, casos.data;

#Ver o quarto caso
SELECT casos.id AS "Nº do caso",
	GROUP_CONCAT(investigadores.nome) AS "Investigadores responsáveis",
	casos.descricao AS "Descrição",
	casos.evidencia AS "Evidência",
	vitimas.nome AS "Nome da vítima",
	suspeitos.nome AS "Nome do suspeito",
	casos.data AS "Data do caso"
	FROM casos
	JOIN suspeitos ON casos.idSuspeito = suspeitos.id
	JOIN vitimas ON casos.idVitima = vitimas.id
	JOIN investigadores_tem_casos ON casos.id = investigadores_tem_casos.idCaso
	JOIN investigadores ON investigadores_tem_casos.idInvestigador = investigadores.id
	WHERE casos.data = "2023-06-01"
	GROUP BY casos.id, casos.descricao, casos.evidencia, vitimas.nome, casos.data;

#Ver o suspeito do quarto caso encontrado nas câmeras após o relato da testemunha
SELECT suspeitos.nome AS "Nome da suspeita", suspeitos.idade AS "Idade da suspeita", suspeitos.etnia AS "Etnia da suspeita", suspeitos.genero AS "Gênero da suspeita" FROM suspeitos WHERE id = 4;

#Ver todos os casos
SELECT casos.id AS "Nº do caso",
	GROUP_CONCAT(investigadores.nome) AS "Investigadores responsáveis",
	casos.descricao AS "Descrição",
	casos.evidencia AS "Evidência",
	vitimas.nome AS "Nome da vítima",
	suspeitos.nome AS "Nome do suspeito",
	casos.data AS "Data do caso"
	FROM casos
	JOIN suspeitos ON casos.idSuspeito = suspeitos.id
	JOIN vitimas ON casos.idVitima = vitimas.id
	JOIN investigadores_tem_casos ON casos.id = investigadores_tem_casos.idCaso
	JOIN investigadores ON investigadores_tem_casos.idInvestigador = investigadores.id
	GROUP BY casos.id, casos.descricao, casos.evidencia, vitimas.nome, casos.data;

#Ver todas as vítimas
SELECT vitimas.nome AS "Nome das vítimas", vitimas.idade "Idade das vítimas" FROM vitimas;

#Ver todos os suspeitos
SELECT suspeitos.nome AS "Nome dos suspeitos", suspeitos.idade AS "Idade dos suspeitos" FROM suspeitos ORDER BY suspeitos.nome ASC;


