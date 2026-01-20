# 🎬 ToDo List

Aplicação Flutter que ajuda o usuário a organizar seus afazeres.

## ✅ O que foi entregue

- ✅ Cadastro da tarefa(Com banco local);
- ✅ Listagem das tarefas;
- ✅ Filtrar tarefas por status;
- ✅ Exclusão de uma tarefa;
- ✅ Arquitetura limpa e escalável;
- ✅ testes unitários;
- ✅ Tratamento de erros
- ✅ Rate limiting (300 req/min)

## 🚀 Quick Start

```bash
# Instalar dependências
flutter pub get

# Executar
flutter run

# Rodar testes
flutter test
```

## 📁 Estrutura

```
lib/
├── domain/          # Models, enums e Dtos
├── data/            # Repositórios
├── ui/
│     ├── core/      # Temas e widgets
|     |-- pages/     # Telas
└── core/            # Serviços, utilidades e providers
```

## 🛠 Tech Stack

- Flutter 3.35.7 | Dart 3.9.2
- Sqflite (Banco local)
- GetIt (Dependency Injection)
- Mocktail (Testes)

## 🏗 Arquitetura

3 camadas bem separadas:
- **Domain**: Modelos, enums e dtos
- **Data**: Repositórios
- **Core**: Serviços, utilidades e providers
- **UI**: Controllers com ValueNotifier, StatePattern, widgets, telas e temas


## 🔒 Tratamento de Erros

- TimeoutException → "Tempo esgotado"
- TypeError → "Erro de tipo"
- Erros customizados tratados

## ⏱ Rate Limiting

Máximo 300 requisições/minuto. Reseta automaticamente a cada minuto.

## 📞 Autor

- 🔗 [LinkedIn](https://www.linkedin.com/in/lucas-gean-dos-santos/)

## 🎥 Demonstração

Assista ao vídeo de demonstração da aplicação:



https://github.com/user-attachments/assets/bdf39826-af57-41a2-a648-853af67b4c68





---


