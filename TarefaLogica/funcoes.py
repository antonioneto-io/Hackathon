# Funções
def menu_principal():
    # Montagem do menu de opções
    print('\n################################')
    print('Olá, sem bem vindo(a)!')
    print('################################\n')
    print('Qual opção você deseja acessar?')
    print('1 - Lista de Asteriscos')
    print('2 - Par de números')
    print('3 - Subconjuntos de um conjunto de números')
    print('4 - Sair')
    print('\n################################\n')

    # Solicita a opção do menu
    opc_menu = int(input('Opção: '))

    # Verifica se digitou uma opção válida. Se não digitou, o laço de repetição vai rodar até o usuário digitar uma opção válida.
    while (opc_menu < 1 or opc_menu > 4):
        print('Opção inválida. Digite uma opção de 1 a 4.')
        opc_menu = int(input('Opção: '))

    opcoes_menu(opc_menu)
def opcoes_menu(opc):
    if opc == 1: # Lista de asteriscos
        # Solicita o valor para gerar a lista
        valor = int(input("Digite o número de asteriscos: "))
        # Valida se o valor digitado é maior que 0
        if(valor < 0):
            print("O número de asteriscos precisa ser um número maior que 0.")
            return
        lista_asteriscos(valor)
    elif opc == 2: #  Par de números
        valor = input("Quais números inteiros o array deve conter? Digite eles separados por espaço: ")
        pares_duplicados = int(input("Os pares podem conter valores duplicados? Digite 1 para Sim e 0 para Não: "))
        # verifica se o valor digitado é 1 ou 0. Se for um número diferente, o laço de repetição vai rodar até o usuário digite corretamente
        while (pares_duplicados != 0 and pares_duplicados != 1):
            pares_duplicados = int(input("Opção inválida. Digite 1 para Sim ou 0 para Não. "))

        pares_sorteados = int(input("Os pares devem estar ordenados em ordem crescente? Digite 1 para Sim e 0 para Não: "))
        while (pares_sorteados != 0 and pares_sorteados != 1):
            pares_sorteados = int(input("Opção inválida. Digite 1 para Sim ou 0 para Não. "))

        pares_unicos = int(input("A função deve retornar apenas pares únicos? Digite 1 para Sim e 0 para Não: "))
        while (pares_unicos != 0 and pares_unicos != 1):
            pares_unicos = int(input("Opção inválida. Digite 1 para Sim ou 0 para Não. "))
        # Passa os valores como True ou False para a função
        diferenca_numeros(valor, True if pares_duplicados == 1 else False, True if pares_sorteados == 1 else False, True if pares_unicos == 1 else False)
    elif opc == 3: # Subconjuntos de um conjunto de números
        valor = input("Digite os números separados por espaço: ")
        # Opção que limita o tamanho máximo dos subconjuntos
        max_size = int(input("Os subconjuntos devem ter um tamanho máximo? Se sim, digite o valor: "))
        while (max_size < 0):
            max_size = int(input("Opção inválida. Digite um valor maior que 0: "))

        # Opção que limita o tamanho mínimo dos subconjuntos
        min_size = int(input("Os subconjuntos devem ter um tamanho mínimo? Se sim, digite o valor: "))
        while (min_size < 0):
            min_size = int(input("Opção inválida. Digite um valor maior que 0: "))

        distinct_only = int(input("Os subconjuntos não podem conter elementos duplicados? Digite 1 para Sim e 0 para Não: "))
        # verifica se o valor digitado é 1 ou 0. Se for um número diferente, o laço de repetição vai rodar até o usuário digite corretamente
        while (distinct_only != 0 and distinct_only != 1):
            distinct_only = int(input("Opção inválida. Digite 1 para Sim ou 0 para Não. "))

        sort_subsets = int(input("Os subconjuntos e os conjuntos devem estar em ordem crescente? Digite 1 para Sim e 0 para Não: "))
       
        while (sort_subsets != 0 and sort_subsets != 1):
            sort_subsets = int(input("Opção inválida. Digite 1 para Sim ou 0 para Não. "))

        subconjuntos(valor, max_size, min_size, True if distinct_only == 1 else False, True if sort_subsets == 1 else False)
    elif opc == 4: # Sair
        print("\n--- Finalizando programa....")
        exit()

def lista_asteriscos(valor):
    array_asteriscos = []
    # O primeiro for vai de 1 até o valor digitado para montar as posições do array.
    for i in range(1, valor + 1):
        asteriscos = ''
        # O segundo for vai de 1 até o i (para cada posição do array) para montar os asteriscos.
        for j in range(1, i + 1):
            asteriscos += '*'
        array_asteriscos.append(asteriscos)

    print(f'\nLista gerada: {array_asteriscos}')
    print('------------------------------------------------------------')
    retorna_menu_inicial()

def diferenca_numeros(valor, allow_duplicates=True, sorted_pairs=False, unique_pairs=False):
    # divide a string peelos espaços
    array = valor.split()
    # convertendo cada item do array para inteiro
    array_numeros = []
    for num in array:
        array_numeros.append(int(num))

    # Faz a ordenação do array se o parâmetro sorted_pairs=True
    if sorted_pairs:
        array_numeros.sort()
    # array que vai armazenar os pares com a menor diferença
    pares_diferenca_absoluta = []
    # inicializa a menor diferença dos números com infinito
    menor_diferenca = float('inf')

    # Percorre o array de números
    for i in range(len(array_numeros) - 1):
        # Converte o número atual e o próximo número para inteiro
        numero = int(array_numeros[i])
        proximo_numero = int(array_numeros[i+1])

        # Faz a diferença do número atual com o número da próxima posição
        diferenca = abs(numero - proximo_numero)

        # Se a diferença for menor que a menor diferença já encontrada, atualiza a menor diferença e o array dos pares
        if diferenca < menor_diferenca:
            menor_diferenca = diferenca
            pares_diferenca_absoluta = [(numero, proximo_numero)]
        # Se a diferença for menor que a menor diferença, o array do par é adicionado na lista
        elif diferenca == menor_diferenca:
            # Flag para fazer o controle da adição dos pares
            flag = True

            # Se o parâmetro allow_duplicates=True, retira os pares duplicados
            if not allow_duplicates:
                if ((numero, proximo_numero) in pares_diferenca_absoluta):
                    flag = False

            # Se o parâmetro unique_pairs=True, deixa somente os pares únicos       
            if unique_pairs:
                if((numero, proximo_numero) in pares_diferenca_absoluta or (proximo_numero, numero) in pares_diferenca_absoluta):
                    flag = False
            
            # Se não atender nenhuma das condições acima, o par é inserido normalmente
            if flag:
                pares_diferenca_absoluta.append((numero, proximo_numero))

    if sorted_pairs:
        print(f'\nArray ordenado: {array_numeros}')

    print(f'\nPares com a menor diferença absoluta: {pares_diferenca_absoluta}')       
    print('------------------------------------------------------------')
    retorna_menu_inicial()
def subconjuntos(valor, max_size=None, min_size=None, distinct_only=False, sort_subsets=False):
    # divide a string peelos espaços
    array = valor.split()
    # convertendo cada item do array para inteiro
    array_conjuntos = []
    for num in array:
        array_conjuntos.append(int(num))
    
    # Faz a ordenação do array se o parametros sort_subsets=True
    if sort_subsets:
        array_conjuntos.sort()

    array_sub_conjuntos = []

    # montagem dos subconjuntos
    for i in range(len(array_conjuntos)): 
        # Coloca cada item separadamente no array
        valor_sozinho = []
        valor_sozinho.append(array_conjuntos[i])
        # flag para fazer o controlar da adição dos subconjuntos
        flag = True

        # se o parametro distinct_only=True, não pode conter elementos repetidos
        if distinct_only:
            if valor_sozinho in array_sub_conjuntos:
                flag = False

        # o parametro min_size limita o tamanho mínimo dos subconjuntos
        if min_size and len(valor_sozinho) < min_size:
            flag = False
        
        if flag:
            array_sub_conjuntos.append(valor_sozinho)

        # Coloca os demais itens no array
        for j in range(i + 1, len(array_conjuntos)):
            subconjunto = array_conjuntos[i:j+1]
            # flag para fazer o controlar da adição dos subconjuntos
            flag = True
            # se o parametro distinct_only=True, não pode conter elementos repetidos
            if distinct_only:
                if subconjunto in array_sub_conjuntos:
                    flag = False

            # o parametro max_size limita o tamanho máximo dos subconjuntos
            if max_size and len(subconjunto) > max_size:
                flag = False

            # o parametro min_size limita o tamanho mínimo dos subconjuntos
            if min_size and len(subconjunto) < min_size:
                flag = False
            
            if flag:
                array_sub_conjuntos.append(subconjunto)

    print(f'\nArray de subconjuntos: {array_sub_conjuntos}')
    print('------------------------------------------------------------')
    retorna_menu_inicial()

# Função para retornar para o menu inicial ou para finalizar o programa.
def retorna_menu_inicial():
    print('\n################################')
    menu = int(input('Digite 1 para voltar ao menu inicial ou 0 para finalizar o programa: '))
    if(menu == 1):
        menu_principal()
        return
    
    print('Opção inválida! Finalizando sistema...')
    exit()