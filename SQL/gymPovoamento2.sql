USE ginasio;



-- povoamento da tabela "TiposAula"
INSERT INTO `ginasio`.`tiposaula`
(Duracao, Lotacao, Sala, Descricao)
	VALUES
	( 120, 100, 'A1', 'Cardio/Musculação'),
    ( 45, 50,  'A2', 'Cycling'),
    ( 45, 80,  'B1', 'Body Combat'),
    ( 55, 80,  'B2', 'Body Pump'),
    ( 45, 50,  'C1', 'Cross Training');
    

UPDATE TiposAula
SET Descricao = 'Cardio/Musculação'
	WHERE TiposAula.Id = 0;

SELECT * FROM TIPOSAULA;





-- povoamento da tabela "Localidade"
INSERT INTO Localidade
(Localidade)
	VALUES
	( 'Fafe'),
	( 'Famalicao'),
	( 'Ruilhe'),
	( 'Póvoa de Lanhoso'),
	( 'Penafiel'),
	( 'Boavista'),
	( 'Vila Franca'),
	( 'Figueira da Foz'),
	( 'Vila Verde'),
	( 'Ílhavo'),
    ( 'Maia');
    
SELECT * FROM LOCALIDADE;



-- povoamento da tabela "Morada"
INSERT INTO `ginasio`.`morada`
(CodigoPostal, Localidade_id, Rua)
	VALUES
	('4683-542', 1, 'Rua de Fafe'),
	('4199-256', 2, 'Rua de VNF'),
	( '7863-651', 3, 'Rua da Capital'),
	( '4157-816', 4, 'Rua da PVL'),
	( '4689-478', 5, 'Rua da Pena'),
	( '4736-951', 6, 'Rua do Bessa'),
	( '4453-451', 7, 'Rua da Vila'),
	( '4224-337', 8, 'Rua da Figueira'),
	( '5445-787', 9, 'Avenida 25 de Abril'),
	( '4561-152', 10, 'Rua da Gafanha'),
    ( '7547-854', 11, 'Rua da Maia');
    
SELECT * FROM MORADA;




-- povoamento da tabela "Professor"
INSERT INTO `ginasio`.`professor`
	(Nome, Nascimento, Telefone, Morada_id)
	VALUES
		( 'Pedro Alves',  '1990-02-03', '912567885', 11),
        ( 'João Antunes', '1989-10-11', '934425877', 10),
        ( 'Inácio Costa', '1991-04-19', '936547215', 9),
        ( 'Helena Ester', '1987-01-27', '921574698', 8),
		( 'Júlia Simões', '1989-11-07', '912324535', 6);

SELECT * FROM PROFESSOR
	INNER JOIN Morada ON Professor.Id = Morada.Id;




-- Povoamento da tabela 'Contrato'
INSERT INTO `ginasio`.`contrato`
	( Descricao, Entrada, Saida, Mensalidade, Inicio, Fim)
	VALUES
		( 'Acesso Livre', '09:00:00', '17:00:00', 50, '2017-11-01', '2017-02-28'),
		( 'Acesso Livre', '08:00:00', '22:00:00', 95, '2017-11-01', '2017-02-28'),
        ( 'Cardio-Musculaçao 1', '08:00:00', '22:00:00', 40, '2017-11-01', '2018-02-28'),
        ( 'Cardio-Musculaçao 2', '09:00:00', '17:00:00', 15, '2017-11-01', '2018-02-28'),
        ( 'Body Combat & Body Pump', '09:00:00', '17:00:00', 35, '2017-11-01', '2017-02-28'),
        ( 'Cycling & Cross Training & Body Combat', '08:00:00', '22:00:00', 50, '2017-11-01', '2018-02-28');
        
SELECT * FROM CONTRATO;



SELECT * from contrato
	left join podeparticipar ON contrato.id = podeparticipar.contrato
    where podeparticipar.contrato is null;




-- Povoamento da tabela "Cliente"
INSERT INTO Cliente
	( Nome, Nascimento, Cartao, ContactoEmergencia, Telefone, Email, TotalPago, PagoAte, Contrato_id, Morada_id)
	VALUES
		( 'Catarina Sousa',   '1993-02-01', 100,  '913265485', '252365751', 'nacional@uminho.pt',   35, '2017-09-01', 5, 1),
        ( 'Paulo Dinis',      '1994-03-02', 101,  '923524556', '253633124', 'manetes@uminho.pt',    15, '2017-09-01', 4, 2),
		( 'Joaquim Oliveira', '1995-04-03', 102,  '935174219', '253962235', 'quim@uminho.pt',       40, '2017-09-01', 3, 3),
        ( 'André Pereira',    '1996-05-04', 103,  '968125753', '253752149', 'watson@uminho.pt',     95, '2017-09-01', 2, 4),
        ( 'Eduardo Silva',    '1997-06-05', 104,  '924324387', '257868325', 'dusilva@hotmail.com',  50, '2017-09-01', 1, 5),
        ( 'Sandra Ribeiro',   '1998-03-22', 105,  '914353455', '253752149', 'ribas@gmail.com',      50, '2017-09-01', 6, 6),
        ( 'António Freitas',  '1999-08-16', 106,  '962345678', '274873267', 'af123@live.pt',        95, '2017-09-01', 2, 7),
        ( 'Luana Lopes',      '1998-09-05', 107,  '914567824', '255873245', 'luslo12_21@uminho.pt', 40, '2017-09-01', 3, 8),
        ( 'Diogo Lopes',      '1994-10-09', 108,  '914567824', '253654762', 'diblue@uminho.pt',     15, '2017-09-01', 4, 9),
        ( 'Sara Antunes',     '1990-04-30', 109,  '968769434', '253254675', 'tunexs@gmail.pt',      35, '2017-09-01', 5, 10),
        ( 'José Tinoco',      '1997-03-21', 110,  '912435673', '254356245', 'timtim29tim@gmail.pt', 50, '2017-09-01', 1, 11);

SELECT * FROM CLIENTE;




-- Povoamento da tabela "Aula"
INSERT INTO AULA
( Dia, Professor_id, TiposAula_id)
	VALUES
	( '2017-11-10 09:00:00',1,1),
    ( '2017-11-01 14:00:00',1,1),
    ( '2017-11-11 11:00:00',1,5),
    ( '2017-11-02 19:30:00',1,5),
    
    ( '2017-12-05 10:00:00',2,2),
    ( '2017-11-10 11:30:00',2,3),
    ( '2018-01-11 12:00:00',2,3),
	( '2018-01-15 20:30:00',2,4),
    
    ( '2018-01-07 16:00:00',3,1),
    ( '2018-01-08 17:00:00',3,3),
   ( '2018-01-09 14:30:00',3,4),
   ( '2018-01-10 15:45:00',3,5),
   
   ( '2017-12-02 15:00:00',4,2),
   ( '2017-12-10 16:00:00',4,2),
   ( '2017-12-17 15:00:00',4,2),
   ( '2017-12-21 17:00:00',4,4),
   
   ( '2018-01-21 17:00:00',4,3);
   

SELECT * FROM AULA;
    


SELECT * FROM aula	
	INNER JOIN Professor ON Professor.Id = Aula.professor_id
    INNER JOIN TiposAula ON TiposAula.Id = Aula.TiposAula_id;

-- Povoamento da tabela 'PodeParticipar'
INSERT INTO PODEPARTICIPAR
	(Contrato, TiposAula)
	VALUES
		(1,1),
        (1,2),
        (1,3),
        (1,4),
        (1,5),
        
        (2,1),
        (2,2),
        (2,3),
        (2,4),
        (2,5),
        
        (3,1),
        (4,1),
        
        (5,3),
        (5,4),
        
        (6,2),
        (6,3),
        (6,5);

SELECT * FROM PODEPARTICIPAR;




-- Povoamento da tabela "Entrada"
INSERT INTO `ginasio`.`entrada`
	(HoraEntrada, HoraSaida, Cliente_id, Aula_id)
	VALUES
		('2018-01-04 12:12:39', '2018-01-04 13:01:04', 1, 10),
        ('2018-01-04 15:31:42', '2018-01-04 16:40:56', 2, 11),
        ('2018-01-04 19:25:52', '2018-01-04 21:01:14', 3, 12),
        ('2018-01-04 12:24:25', '2018-01-04 13:01:45', 4, 13),
        
		('2018-01-02 12:12:39', '2018-01-02 13:01:04', 1, 6),
        ('2018-01-02 15:31:42', '2018-01-02 16:40:56', 2, 7),
        ('2018-01-02 19:25:52', '2018-01-02 21:01:14', 3, 8),
        ('2018-01-02 12:24:25', '2018-01-02 13:01:45', 4, 9),
        
		('2017-01-01 12:12:39', '2017-01-01 13:01:04', 1, 4),
        ('2017-01-01 15:31:42', '2017-01-01 16:40:56', 2, 1),
        ('2017-01-01 19:25:52', '2017-01-01 21:01:14', 3, 1),
        ('2017-01-01 12:24:25', '2017-01-01 13:01:45', 4, 4),
        ('2017-01-01 15:37:31', '2017-01-01 15:51:23', 5, 3),
        ('2017-01-01 09:24:13', '2017-01-01 10:21:53', 6, 2),
        ('2017-01-01 19:14:49', '2017-01-01 20:11:14', 7, 5),
        ('2017-01-01 13:26:56', '2017-01-01 16:09:07', 8, 1),
        ('2017-01-01 09:01:14', '2017-01-01 10:07:34', 9, 1),
        ('2017-01-01 13:12:41', '2017-01-01 14:03:40', 10, 4),
        ('2017-01-01 16:09:13', '2017-01-01 16:50:02', 11, 5);
        
SELECT * FROM ENTRADA;

SELECT Cliente.Nome, TiposAula.Descricao FROM ENTRADA
	INNER JOIN CLiente ON Cliente.Id = Entrada.Cliente_id
    INNER JOIN Aula ON Aula.Id = Entrada.Aula_id
    INNER JOIN TiposAula ON TiposAula.Id = Aula.TiposAula_id;




SELECT TABLE_NAME, table_rows, data_length / 1024 'Dados (KB)',
	   index_length / 1024 'Indices (KB)',
       round(((data_length + index_length) / 1024 / 1024),5) 'Size in MB'
       FROM information_schema.TABLES
	WHERE table_schema = 'Ginasio';




SELECT table_schema 'Ginasio',
	   SUM(data_length + index_length) / 1024 / 1024 'DB Size in MB'
	   FROM information_schema.tables
	WHERE table_schema = 'Ginasio';







-- QUERIES



-- Consultar a lista dos 5 clientes que mais dinheiro pagaram ao ginásio.

SELECT Cliente.Id, Cliente.Nome, Localidade.Localidade, Cliente.TotalPago FROM CLIENTE
	INNER JOIN Morada ON Cliente.Morada_id = Morada.Id
    INNER JOIN Localidade ON Morada.localidade_id = Localidade.Id
    ORDER BY Cliente.TotalPago, Cliente.Id;
    


-- Ver quais as aulas que um cliente pode frequentar que irão ocorrer dentro de uma hora

SELECT DISTINCT Cliente.Id, Cliente.Nome, TiposAula.Descricao, Aula.Dia FROM CLIENTE 
	INNER JOIN podeparticipar ON CLiente.Contrato_id = podeParticipar.Contrato
    INNER JOIN TiposAula ON TiposAula = podeParticipar.TiposAula
	INNER JOIN Aula ON Aula.TiposAula_id = TiposAula.id
    WHERE ( Aula.Dia >= CURDATE()) 
    ORDER BY Cliente.Id, Aula.Dia;



-- Ver as horas com maior afluência de clientes;

SELECT CONCAT_WS('', HOUR(Entrada.HoraEntrada), 'h') AS 'Horas', COUNT(HoraEntrada) AS 'Número' FROM Entrada
	GROUP BY HOUR(Entrada.HoraEntrada)
	ORDER BY 2 DESC ,1 ASC;
    


-- Tempo que os clientes estiveram no ginasio

SELECT Cliente.Id, Cliente.Nome, Localidade.Localidade, SUM(Entrada.HoraSaida-Entrada.HoraEntrada) AS 'Duracao' FROM Cliente
	INNER JOIN Morada ON Morada.Id = Cliente.Morada_id
    INNER JOIN Localidade ON Localidade.Id = Morada.Localidade_id
    INNER JOIN Entrada ON Cliente.Id = Entrada.Cliente_id
    WHERE Entrada.HoraSaida IS NOT NULL
	GROUP BY Cliente.Id
    ORDER BY 4 DESC, 1 ASC;
    
    


-- Os professores que tiveram mais audiências nas suas aulas

-- versao 0
SELECT Professor.Nome AS 'Professor', COUNT(Entrada.Aula_id), SUM(1/TiposAula.Lotacao) AS '% Alunos p/ sala' FROM Entrada
	INNER JOIN Aula ON Aula.Id = Entrada.Aula_id
	INNER JOIN Professor ON Professor.Id = Aula.Professor_id
    INNER JOIN TiposAula ON TiposAula.Id = Aula.TiposAula_id
	GROUP BY Professor.Id
    ORDER BY 2 DESC;

-- versao FINAL
SELECT Professor.Nome,  IFNULL(SUM( (Cliente_id/Cliente_id) / TiposAula.Lotacao),0) AS '% Alunos p/ sala' FROM AULA
	LEFT JOIN Entrada ON Aula.Id = Entrada.Aula_id
	RIGHT JOIN Professor ON Professor.Id = Aula.Professor_id
    LEFT JOIN TiposAula ON TiposAula.Id = Aula.TiposAula_id
	GROUP BY Professor.Id
    ORDER BY 2 DESC;

SELECT * FROM PROFESSOR;


-- Criacao de VISTA (tabela de clientes que ainda nao deram check-out no ginasio)

-- SELECT DISTINCT Cliente.Id, Cliente.Nome, Morada.Localidade, Entrada.HoraEntrada, TiposAula.Descricao FROM Cliente
CREATE VIEW A_TREINAR AS
SELECT DISTINCT Cliente.Id AS 'cID', Cliente.Nome, Entrada.HoraEntrada,
				TiposAula.Id AS 'tID', TiposAula.Descricao, TiposAula.Lotacao
                FROM Cliente
	INNER JOIN Morada ON Cliente.Morada_id = Morada.Id
    INNER JOIN Entrada ON Cliente.Id = Entrada.Cliente_id
    INNER JOIN Aula ON Aula.Id = Entrada.Aula_id
    INNER JOIN TiposAula ON Aula.TiposAula_id = TiposAula.Id
    WHERE Entrada.HoraSaida = NULL;
    

SELECT * FROM A_TREINAR;
DROP VIEW A_TREINAR;



DELIMITER $
CREATE FUNCTION a_treinar_aula(aula INT)
	RETURNS INT
BEGIN
	DECLARE treinar INT;
    SET treinar =  (SELECT COUNT(*) FROM A_TREINAR
		WHERE tID = aula);
    RETURN treinar;
END
$


-- transaçao (mostra no ecra quais as aulas disponiveis quando um cliente entrar no ginasio)
DELIMITER $
CREATE PROCEDURE CHECK_IN (IN id_cliente INT)
BEGIN 

DECLARE id_aula INT;
DECLARE id_contrato INT;
DECLARE pago_ate DATE;
DECLARE c_entrada TIME;
DECLARE c_saida TIME;
DECLARE ErroTransacao BOOL DEFAULT 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ErroTransacao = 1;


SELECT Cliente.Contrato_id, Cliente.PagoAte, Contrato.Entrada, Contrato.Saida INTO id_contrato, pago_ate, c_entrada, c_saida FROM Cliente
	INNER JOIN Contrado ON Cliente.Contrato_id = Contrato.Id
	WHERE Cliente.Id = id_cliente;


-- Verifica restrição da mensalidade
IF ( DATE(NOW()) > pago_ate ) THEN 
	ROLLBACK;
END IF;


-- Verifica restrição horária
IF (TIME(NOW()) < c_entrada  OR  TIME(NOW()) > c_saida) THEN 
	ROLLBACK;
END IF;



-- Quais as aulas disponiveis, quando um utilizador faz check-in no ginasio
SELECT Cliente.Id, Cliente.Nome, Professor.Nome, TiposAula.Descricao, Aula.Dia FROM Cliente
	INNER JOIN podeParticipar ON Cliente.Contrato_id = podeParticipar.Contrato
	INNER JOIN Aula ON Aula.Id = podeParticipar.TiposAula
    INNER JOIN Professor ON Aula.Professor_id = Professor.Id
	INNER JOIN TiposAula ON TiposAula.Id = Aula.TiposAula_id
	WHERE ( CURDATE() < DATE_ADD(Aula.Dia, INTERVAL TiposAula.Duracao MINUTE ) AND
			CURDATE() > DATE_ADD(AUla.Dia, INTERVAL -1 HOUR	) AND
            TiposAula.Lotacao - a_treinar_aula(Aula.Id) AND
            Cliente.Id = id_cliente
		  );




-- Verificação da ocorrência de um erro.
IF ErroTransacao THEN
		-- Desfazer as operações realizadas.
	ROLLBACK;
ELSE
		-- Confirmar as operações realizadas.
	COMMIT;
END IF;

END
$
