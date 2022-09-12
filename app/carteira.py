from dao.dao_mysql import DAOValores
from dao.dao_mysql import DAOMovimentacoes
from dao.dao_mysql import ConnectionFactory

connectionFactory = ConnectionFactory('localhost', 'root', 'admin', 'bolsa')
daoValores = DAOValores(connectionFactory)
daoMovimentacoes = DAOMovimentacoes(connectionFactory)

def inserirValor():
    data = input('Data (y-m-d): ')
    nome = input('Nome: ')
    quantidade = int(input('Quantidade: '))
    preco = float(input('Preço: '))
    bean = {
        "data": data, 
        "nome": nome, 
        "quantidade": quantidade, 
        "preco": preco
    }
    id = daoValores.insert(bean)
    print(f'Registro #{id} inserido com sucesso')

def inserirValores():
    nomeArquivo = input('Nome do arquivo: ') # 'extratos/Poupança_Financias - Compras Ativos.csv' 
    with open(nomeArquivo, 'r') as arquivo:
        linhas = arquivo.readlines()[1:]
        for linha in linhas:
            lista = linha.strip().split(';')
            dia, mes, ano = lista[0].split('/')
            bean = {
                "data": f'{ano}-{mes}-{dia}', 
                "nome": lista[2],
                "quantidade": lista[4],
                "preco": float(lista[5].replace(',', '.')) * 100
            }
            inserir(daoValores, bean)

def inserir(dao, bean):
    try:
        id = dao.insert(bean)
        print(f'Registro #{id} inserido com sucesso')
    except Exception as e:
        print('Erro:', e, bean)

def inserirMovimentacao():
    data = input('Data (y-m-d): ')
    nome = input('Nome: ')
    valor = float(input('Valor: '))
    bean = {
        "data": data, 
        "nome": nome,
        "valor": valor,
        "saldo": saldo
    }
    inserir(daoMovimentacoes, bean)

def inserirMovimentacoes():
    nomeArquivo = input('Nome do arquivo: ') # 'extratos/Extrato-01-08-2019-a-19-08-2022.csv'
    with open(nomeArquivo, 'r') as arquivo:
        linhas = arquivo.readlines()[6:]
        for linha in linhas:
            lista = linha.strip().split(';')
            dia, mes, ano = lista[0].split('/')
            valor = float(lista[2].replace('.', '').replace(',', '.')) * 100
            saldo = float(lista[3].replace('.', '').replace(',', '.')) * 100
            bean = {
                "data": f'{ano}-{mes}-{dia}', 
                "nome": lista[1],
                "valor": valor,
                "saldo": saldo
            }
            inserir(daoMovimentacoes, bean)

def listarValores():
    beans = daoValores.list()
    for bean in beans:
        print(bean)

def listarMovimentacoes():
    beans = daoMovimentacoes.list()
    for bean in beans:
        print(bean)

def exibeMenu():
    while True:
        print('1. Inserir valor')
        print('2. Inserir valores de planilha')
        print('3. Inserir movimentação')
        print('4. Inserir movimentações de planilha')
        print('5. Listar valores')
        print('6. Listar movimentações')
        opcao = int(input())
        if opcao == 1:
            inserirValor()
        elif opcao == 2:
            inserirValores()
        elif opcao == 3:
            inserirMovimentacao()
        elif opcao == 4:
            inserirMovimentacoes()
        elif opcao == 5:
            listarValores()
        elif opcao == 6:
            listarMovimentacoes()
        else:
            break
            
exibeMenu()
