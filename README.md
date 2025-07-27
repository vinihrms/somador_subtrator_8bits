# Somador-Subtrator de 8 bits - NEANDER

## Descrição do Projeto

Este projeto implementa um **circuito combinacional somador-subtrator de 8 bits** desenvolvido em VHDL como parte da Atividade Avaliativa 02 da disciplina de Sistemas Digitais - Unioeste/Cascavel.

O circuito é capaz de realizar operações de **adição** e **subtração** em duas palavras de 8 bits (X e Y), utilizando um sinal de controle para alternar entre as operações.

## Objetivos

- Implementar um circuito que opere adição (ADD) ou subtração (SUB) em palavras de 8 bits
- Utilizar um sinal de operação `op` para escolha entre as operações
- Implementar detecção de overflow/carry-out
- Simular o funcionamento com casos de teste específicos
- Implementar versão com latência de portas lógicas

## Especificações Técnicas

### Sinais de Controle
- **op = '0'** → Operação de ADIÇÃO (ADD)
- **op = '1'** → Operação de SUBTRAÇÃO (SUB)

### Interface do Circuito
- **Entradas:**
  - `a[7:0]`: Palavra X (8 bits) - `bit_vector(7 downto 0)`
  - `b[7:0]`: Palavra Y (8 bits) - `bit_vector(7 downto 0)`
  - `sel`: Sinal de operação (1 bit)
  
- **Saídas:**
  - `s[7:0]`: Resultado da operação (8 bits)
  - `overflow`: Sinal de overflow/carry-out

## Arquitetura do Sistema

O projeto utiliza uma arquitetura modular baseada no **método do complemento de 2** para implementar a subtração, permitindo reutilizar o mesmo hardware de soma para ambas as operações.

### Componentes Principais

1. **`somador_subtrator_8bits.vhdl`** - Módulo principal que integra todos os componentes
2. **`soma_8b.vhdl`** - Somador carry-ripple de 8 bits
3. **`somador_1bit.vhdl`** - Full-adder básico (unidade fundamental)
4. **`mux2x8.vhdl`** - Multiplexador 2x8 para seleção entre B e ~B
5. **`inversor_8bits.vhdl`** - Inversor para geração do complemento de 1
6. **`tb_somador_subtrator_8bits.vhdl`** - Testbench para simulação

### Funcionamento

#### Adição (op = '0'):
```
Resultado = A + B + 0
```

#### Subtração (op = '1'):
```
Resultado = A + (~B) + 1 = A - B (complemento de 2)
```

## Casos de Teste

### Simulação 01 - Sem Latência
O testbench implementa os seguintes casos obrigatórios:

| Operação | A (hex) | B (hex) | Esperado | Descrição |
|----------|---------|---------|----------|-----------|
| ADD | 0x00 | 0xFF | 0xFF | Adição básica |
| SUB | 0x00 | 0xFF | 0x01 | Subtração com "empréstimo" |
| ADD | 0xFF | 0x01 | 0x00 + Overflow | Overflow na adição |
| SUB | 0xFF | 0x01 | 0xFE | Subtração normal |
| ADD | 0xFE | 0xFE | 0xFC + Overflow | Adição com overflow |
| ADD | 0xFF | 0xFF | 0xFE + Overflow | Máximo + máximo |
| Intermediários | Vários | Vários | - | Casos adicionais |

### Simulação 02 - Com Latência
- Mesmos casos da Simulação 01
- **Latência de 4ns** para cada porta lógica
- Implementação: `sinal <= expressao after 4 ns;`

## Estrutura de Arquivos

```
somador_subtrator_pronto/
  simulacao1/
    ├── somador_subtrator_8bits.vhdl        # Módulo principal: somador-subtrator de 8 bits
    ├── soma_8b.vhdl                        # Somador de 8 bits
    ├── somador_1bit.vhdl                   # Full-adder de 1 bit
    ├── mux2x8.vhdl                         # Multiplexador 2x8
    ├── inversor_8bits.vhdl                 # Inversor de 8 bits
    ├── tb_somador_subtrator_8bits.vhdl     # Testbench
    ├── simulacao1.ghw                      # Arquivo de simulação
    ├── simulacao1_VISUAL.gtkw                  # Configuração GTKWave para melhor visualização
    └── work-obj93.cf                       # Arquivo de compilação GHDL
  simulacao1/
    ├── latencia_somador_subtrator_8bits.vhdl
    ├── latencia_soma_8b.vhdl
    ├── latencia_somador_1bit.vhdl
    ├── latencia_mux2x8.vhdl
    ├── latencia_inversor_8bits.vhdl
    ├── latencia_tb_somador_subtrator_8bits.vhdl
    ├── latencia_simulacao2.ghw
    ├── latencia_simulacao2_VISUAL.gtkw
    └── latencia_work-obj93.cf
  ├── README.md                           # Documentação do projeto

```

## Análise dos Resultados

### Verificação de Funcionamento
- Adições simples funcionam corretamente
- Subtrações implementadas via complemento de 2
- Detecção de overflow operacional
- Multiplexação entre B e ~B funcional
- Propagação de carry adequada

## Conceitos Implementados

- **Aritmética Binária:** Adição e subtração em complemento de 2
- **Arquitetura Carry-Ripple:** Propagação sequencial de carry
- **Multiplexação:** Seleção condicional de sinais
- **Modularidade:** Design hierárquico de componentes
- **Reutilização:** Mesmo hardware para operações diferentes

## Desenvolvimento
**Autores:** João Pedro Rojas, Rafael Mendonça Vaz, Vinícius Almeida Hermes  
**Curso:** Ciência da Computação  
**Instituição:** Unioeste - Campus Cascavel  
**Disciplina:** Sistemas Digitais  
**Período:** 1º Período - 2025  

## Licença

Este projeto foi desenvolvido para fins acadêmicos como parte das atividades da disciplina de Sistemas Digitais.

---

> **Nota:** Este projeto demonstra os fundamentos de aritmética digital e design de circuitos combinacionais, sendo uma base essencial para o desenvolvimento de processadores e sistemas digitais mais complexos.
