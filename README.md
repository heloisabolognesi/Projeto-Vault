# 🎮 Vault — Catálogo de Jogos

Vault (também identificado no código como **GameCatalog**) é um catálogo de jogos moderno, com visual inspirado em plataformas de streaming (Netflix/Steam), onde é possível navegar, buscar, filtrar por gênero e gerenciar (criar, editar, excluir) jogos e seus respectivos estúdios desenvolvedores. Construído com **Next.js 16 (App Router)**, **React 19**, **TypeScript** e **Supabase** (Postgres).

> Desenvolvido por [Heloísa Bolognesi](https://github.com/heloisabolognesi).

---

## 📋 Sumário

- [Sobre o projeto](#-sobre-o-projeto)
- [Funcionalidades](#-funcionalidades)
- [Tecnologias utilizadas](#-tecnologias-utilizadas)
- [Estrutura do projeto](#-estrutura-do-projeto)
- [Modelo de dados](#-modelo-de-dados)
- [API](#-api)
- [Pré-requisitos](#-pré-requisitos)
- [Como rodar o projeto localmente](#-como-rodar-o-projeto-localmente)
- [Variáveis de ambiente](#-variáveis-de-ambiente)
- [Scripts disponíveis](#-scripts-disponíveis)
- [Roadmap](#-roadmap)
- [Contribuindo](#-contribuindo)
- [Licença](#-licença)
- [Contato](#-contato)

---

## 📖 Sobre o projeto

O **Vault** é uma aplicação web para catalogar jogos, com uma home cinematográfica no estilo de plataformas de streaming: banner de destaque, seções horizontais de rolagem, busca com autocomplete e cards com efeitos de hover. Cada jogo pode ser vinculado a um estúdio desenvolvedor, possui gênero, plataforma, ano de lançamento, descrição e imagem de capa, e pode ser filtrado por gênero diretamente na home.

Todo o CRUD de jogos é feito através de rotas de API internas do Next.js, que se comunicam com um banco Postgres hospedado no Supabase.

---

## ✨ Funcionalidades

- **🏠 Home cinematográfica** — hero banner com jogo em destaque e seções horizontais de rolagem (estilo streaming).
- **🔎 Busca com autocomplete** — pesquisa de jogos pelo nome em tempo real.
- **🏷️ Filtro por gênero** — filtragem rápida entre gêneros como FPS, RPG, Sports, Battle Royale, Metroidvania, Sandbox, Action/Adventure, Strategy, Puzzle, entre outros.
- **➕ Cadastro de jogos** — formulário para adicionar novos jogos (nome, gênero, plataforma, ano de lançamento, descrição, imagem e estúdio).
- **✏️ Edição de jogos** — atualização das informações de um jogo já cadastrado.
- **🗑️ Exclusão com confirmação** — modal de confirmação antes de remover um jogo do catálogo.
- **🏢 Estúdios desenvolvedores** — cada jogo pode estar vinculado a um estúdio (nome + país), com integridade referencial no banco.
- **🎬 Animações suaves** — transições e efeitos com Framer Motion.
- **📱 UI responsiva** — tema escuro, com Tailwind CSS.

---

## 🛠 Tecnologias utilizadas

**Frontend**
- [Next.js 16](https://nextjs.org/) (App Router, Route Handlers)
- [React 19](https://react.dev/)
- [TypeScript](https://www.typescriptlang.org/)
- [Tailwind CSS 4](https://tailwindcss.com/)
- [Framer Motion](https://www.framer.com/motion/) — animações
- [Lucide React](https://lucide.dev/) — ícones

**Backend / Infraestrutura**
- [Supabase](https://supabase.com/) — banco de dados Postgres, com Row Level Security (RLS)
- API própria via Next.js Route Handlers (`app/api`)

**Ferramentas**
- ESLint

---

## 📁 Estrutura do projeto

```
Projeto-Vault/
├── app/
│   ├── api/
│   │   └── games/
│   │       ├── route.ts          # GET (listar/filtrar) e POST (criar) jogos
│   │       └── [id]/
│   │           └── route.ts      # PUT (atualizar) e DELETE (remover) por ID
│   ├── games/
│   │   ├── [id]/                 # Página de detalhes de um jogo
│   │   ├── edit/[id]/            # Página de edição de um jogo
│   │   └── new/                  # Página de cadastro de um novo jogo
│   ├── layout.tsx                # Layout raiz (inclui a Navbar)
│   ├── page.tsx                  # Home — hero, busca, filtros e seções de jogos
│   └── globals.css
├── components/
│   ├── Navbar.tsx
│   ├── HeroSection.tsx           # Banner de destaque da home
│   ├── GameSection.tsx           # Seções horizontais de jogos
│   ├── GameCard.tsx              # Card individual de jogo
│   ├── GameForm.tsx              # Formulário de criação/edição de jogo
│   └── DeleteModal.tsx           # Modal de confirmação de exclusão
├── lib/
│   └── supabase.ts               # Cliente Supabase + tipo `Game`
├── database/
│   └── setup.sql                 # Script de criação das tabelas (games, studios) + RLS
└── package.json
```

---

## 🗄 Modelo de dados

O script `database/setup.sql` cria o schema no Postgres (Supabase) com as tabelas:

| Tabela    | Campos principais                                                                 |
|-----------|-------------------------------------------------------------------------------------|
| `studios` | `id`, `name`, `country`                                                             |
| `games`   | `id`, `name`, `genre`, `platform`, `release_year`, `description`, `image_url`, `studio_id` (FK → `studios.id`, `ON DELETE SET NULL`) |

O script também popula estúdios de exemplo (EA Sports, Riot Games, Epic Games, CD Projekt Red) e um jogo inicial (Cyberpunk 2077), além de habilitar **Row Level Security** na tabela `games`, com políticas públicas de leitura, inserção, atualização e exclusão para o papel `anon` do Supabase — adequado para um projeto de estudo/demonstração, mas vale reforçar as políticas de acesso antes de qualquer uso em produção.

---

## 🔌 API

Rotas internas do Next.js (Route Handlers), consumidas pelo próprio frontend via `fetch`:

| Método | Rota                | Descrição                                                        |
|--------|----------------------|----------------------------------------------------------------------|
| GET    | `/api/games`         | Lista todos os jogos (aceita `?genre=<gênero>` para filtrar)        |
| POST   | `/api/games`         | Cria um novo jogo a partir do corpo da requisição                    |
| PUT    | `/api/games/:id`     | Atualiza os dados de um jogo existente                               |
| DELETE | `/api/games/:id`     | Remove um jogo do catálogo                                           |

Todas as rotas usam o cliente Supabase (`lib/supabase.ts`) para consultar/alterar as tabelas `games` e `studios`.

---

## ✅ Pré-requisitos

- [Node.js](https://nodejs.org/) 18 ou superior
- npm (ou yarn/pnpm, se preferir adaptar os comandos)
- Uma conta e projeto no [Supabase](https://supabase.com/)

---

## 🚀 Como rodar o projeto localmente

1. **Clone o repositório**

   ```bash
   git clone https://github.com/heloisabolognesi/Projeto-Vault.git
   cd Projeto-Vault
   ```

2. **Instale as dependências**

   ```bash
   npm install
   ```

3. **Configure o Supabase**

   - Crie um projeto em [supabase.com](https://supabase.com/).
   - No SQL Editor do Supabase, execute o script `database/setup.sql` para criar as tabelas `studios` e `games`, os dados iniciais e as políticas de RLS.
   - Copie a **Project URL** e a **anon/public key** do seu projeto (em *Project Settings → API*).

4. **Configure as variáveis de ambiente**

   Crie um arquivo `.env.local` na raiz do projeto (veja a seção [Variáveis de ambiente](#-variáveis-de-ambiente)).

5. **Rode o servidor de desenvolvimento**

   ```bash
   npm run dev
   ```

6. Acesse [http://localhost:3000](http://localhost:3000) no navegador.

---

## 🔑 Variáveis de ambiente

Crie um arquivo `.env.local` na raiz do projeto com:

```env
NEXT_PUBLIC_SUPABASE_URL=https://SEU-PROJETO.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=sua-anon-key-aqui
```

> ⚠️ Sem essas variáveis, o cliente Supabase (`lib/supabase.ts`) lança um erro na inicialização. Nunca faça commit do arquivo `.env.local`.

---

## 📜 Scripts disponíveis

| Script        | Descrição                                  |
|---------------|-----------------------------------------------|
| `npm run dev`   | Inicia o servidor de desenvolvimento         |
| `npm run build` | Gera o build de produção                     |
| `npm start`     | Inicia o servidor com o build de produção    |
| `npm run lint`  | Executa o ESLint no projeto                  |

---

## 🗺 Roadmap

Ideias de evolução para o projeto:

- [ ] Autenticação de usuário e políticas de RLS por usuário (hoje o acesso é público via papel `anon`)
- [ ] Upload de imagens de capa para o Supabase Storage (em vez de URL externa)
- [ ] Sistema de avaliação/nota dos jogos (`rating`, já previsto no tipo `Game`)
- [ ] Página de detalhes de estúdio, listando todos os jogos daquele estúdio
- [ ] Paginação/infinite scroll nas seções da home
- [ ] Testes automatizados

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/minha-feature`)
3. Faça commit das suas alterações (`git commit -m 'feat: adiciona minha feature'`)
4. Faça push para a branch (`git push origin feature/minha-feature`)
5. Abra um Pull Request

---

## 📄 Licença

Este projeto ainda não possui uma licença definida. Caso deseje torná-lo open source formalmente, considere adicionar um arquivo `LICENSE` (por exemplo, [MIT](https://choosealicense.com/licenses/mit/)).

---

## 📬 Contato

Desenvolvido por **Heloísa Bolognesi**
GitHub: [@heloisabolognesi](https://github.com/heloisabolognesi)

---

<p align="center">🎮 Seu acervo de jogos, organizado em um só lugar.</p>
