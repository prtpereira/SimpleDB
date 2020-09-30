##########    Requisitos    ##########
# -Python2.7
# -Configurar pip (opcional)
#   -neo4jrestclient             --> ($ pip install neo4jrestclient)
# -MySQLdb (package python)      --> (Instalar executavel. Disponivel em https://pypi.python.org/pypi/MySQL-python/1.2.5)


# MySQL -> Python
#https://stackoverflow.com/questions/372885/how-do-i-connect-to-a-mysql-database-in-python


# API: Python -> Neo4j
#http://neo4j-rest-client.readthedocs.io/en/latest/elements.html


##########    Conversoes    ##########
# unicode(row, "iso-8859-1")   --> converter row para string com suporte para carateres especiais (iso latino)
# unicode(row)                 --> converter row para string (nao contem carateres especiais)
# row                          --> ee um tipo primitivo (string ou int/float)



import webbrowser
import MySQLdb
from neo4jrestclient.client import GraphDatabase
from datetime import timedelta


#conectar SQL
db_sql = MySQLdb.connect(host="localhost",     # host, normalmente localhost
                         user="root",          # username
                         passwd="admin",       # password
                         db="ginasio")         # nome da base de dados


#conectar neo4J
db_neo = GraphDatabase("http://localhost:7474",
                       username="admin",
                       password="admin")


#Criar um cursor(Objeto) para permitir executar queries sobre ele (relativo ao SQL)
cur = db_sql.cursor()


#enviar query para a BD nao relacional
#limpar a base de dados antes de a popular (previne que haja deuplicacao de dados ao executar a script multiplas vezes)
apagar = 'MATCH (n) DETACH DELETE n'
db_neo.query(apagar)




################### POPULAR NEO4J ###################


# =============================    AULA    =============================


#comunicar com o mysql executando queries sobre ela
cur.execute("SELECT * FROM Aula \
             INNER JOIN TiposAula ON TiposAula.Id = Aula.TiposAula_id")

#cria noo no grafo do tipo "Aula"
aula = db_neo.labels.create("Aula")

# chave: idAula; valor: objeto aula
aulas={}
# chave: objeto aula;  valor: idProfessor que da aula
aulasO={}

for row in cur.fetchall():

        print row

        au = db_neo.nodes.create(
                                dia = int(unicode(row[1].date()).replace("-","")),
                                hora = int(unicode(row[1].time()).replace(":","")),
                                descricao = unicode(row[5], "iso-8859-1"),
                                duracao = row[6],
                                lotacao = row[7],
                                sala = unicode(row[8], "iso-8859-1")
                                )
        aulas[row[0]] = au
        aulasO[au] = row[2]
        aula.add(au)





# =============================    CLIENTE    =============================

cur.execute("SELECT * FROM Cliente \
             INNER JOIN Morada ON Cliente.Morada_id = Morada.Id \
             INNER JOIN Localidade ON Morada.Localidade_id = Localidade.Id")

cliente = db_neo.labels.create("Cliente")

#chave: objeto cliente; valor: id_contrato
clientesO={}

for row in cur.fetchall():

        print row

        cl = db_neo.nodes.create(
                                id = unicode(row[0]),
                                nascimento = int(unicode(row[2]).replace("-","")),
                                cartao = row[3],
                                contacoEmergencia = unicode(row[4]),
                                telefone = unicode(row[5]),
                                email = unicode(row[6], "iso-8859-1"),
                                totalPago = row[7],
                                pagoAte = unicode(row[8]),
                                codigoPostal = unicode(row[12]),
                                rua = unicode(row[13], "iso-8859-1"),
                                localidade = unicode(row[16], "iso-8859-1"),
                                nome = unicode(row[1], "iso-8859-1")
                                )
        clientesO[cl] = [row[0],row[9]] #row[9] = cliente, contrato_id
        cliente.add(cl)





# =============================    CONTRATO    =============================

#novo cursor para correr duas queries em simultaneo
cur2 = db_sql.cursor()

cur.execute("SELECT * FROM Contrato")

contrato = db_neo.labels.create("Contrato")
# chave: id contrato;  valor: objeto contrato
contratos={}

for row in cur.fetchall():

        print row
        tiposaula=[]

        cur2.execute("SELECT * FROM podeParticipar \
                      INNER JOIN TiposAula ON TiposAula.Id = podeParticipar.TiposAula \
                      WHERE podeParticipar.Contrato = " + unicode(row[0]) # = numero de contrato, id
                    )

        for row2 in cur2.fetchall():

            print "#############", row2[3]
            tiposaula.append(unicode(row2[3], "iso-8859-1"))

        co = db_neo.nodes.create(
                                entrada = unicode(row[2]).replace(":",""),
                                saida = unicode(row[3]).replace(":",""),
                                mensalidade = row[4],
                                inicio = unicode(row[5]).replace("-",""),
                                fim = unicode(row[6]).replace("-",""),
                                descricao = unicode(row[1], "iso-8859-1"),
                                tiposAula = tiposaula
                                )

        contrato.add(co)
        contratos[row[0]] = co





# =============================    PROFESSOR    =============================

cur.execute("SELECT * FROM Professor \
             INNER JOIN Morada ON Professor.Morada_id = Morada.Id \
             INNER JOIN Localidade ON Morada.Localidade_id = Localidade.id")

professor = db_neo.labels.create("Professor")
professores={}

for row in cur.fetchall():

        print row

        pr = db_neo.nodes.create(
                                nome = unicode(row[1], "iso-8859-1"),
                                nascimento = unicode(row[2]).replace("-",""),
                                telefone = unicode(row[3]),
                                codigoPostal = unicode(row[6]),
                                rua = unicode(row[7], "iso-8859-1"),
                                localidade = unicode(row[10], "iso-8859-1")
                                )
        professor.add(pr)
        professores[row[0]] = pr









# =============================    RELACOES    =============================

# (cliente)-[r:tem_contrato]->(contrato)
# (cliente)-[r:check_in]->(aula)
# (aula)-[r:lecionada_por]->(professor)
for cl in clientesO:

    idcontrato=(clientesO[cl])[1]
    idcliente=(clientesO[cl])[0]
    cl.relationships.create("tem_contrato", contratos[idcontrato])

    cur.execute("SELECT * FROM Entrada \
                 WHERE Entrada.Cliente_id =" + str(idcliente))

    for row in cur.fetchall():


        print row

        cl.relationships.create("check_in", aulas[row[1]],
                                horaEntrada = unicode(row[2].time()),
                                horaSaida = unicode(row[3].time()),
                                dia = unicode(row[2].date()).replace("-","")
                                )

# (aula)-[r:lecionada_por]->(professor)
for au in aulasO:
    au.relationships.create("lecionada_por", professores[aulasO[au]])






#fechar conexao SQL
db_sql.close()

print "\n\n>>>> Migracao para Neo4J completa! <<<<"








MATCH (p:professor)
  WHERE NOT (p)<-[:lecionada_por]-(c)
  RETURN p.nome As Professor, SemAulas as Aula, 0 As Media
union
match (p:professor)<-[l:lecionada_por]-(a:Aula)
	where not (a)<-[ch:check_in]-(c)
	return p.nome As Professor, a.tipo As Aula, 0 As Media
union
match (p:professor)<-[l:lecionada_por]-(a:Aula)<-[ch:check_in]-(c:Cliente)
	return p.nome Professor, a.Tipo As Aula, count(c)/toFloat(a.lotacao) Media





#webbrowser.open_new("http://localhost:7474/browser")




###########

#query 1
# match( a) - [ c:check_in] -> (b)
# return distinct (c.horaEntrada/10000), count((c.horaEntrada)/10000)

#query 2
#
#

#query 3
#
#
