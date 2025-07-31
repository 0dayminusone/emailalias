# Email Alias Manager

## Features

### Completed Features

- **Email Alias Generation**: Automatically generate unique email aliases using the POP/ IMAP backend, or from a well known endpoint provider (ddg)
- **Alias Assignment**: Assign aliases with labels & put them into "folders" (just an sqlite db)
- **DB Encryption**: Utilises the SQLite DB encryption extentions
- **Real-time Multi-Device Sync**: Seamless synchronization, utilises existing well known conflict resolution algos
- **Cross-Platform Support**: (Flutter) build supports targets: linux, android, IOS, (NOT MAC) right now
- **Containerized Deployment**: Docker support for easy deployment and scaling for centralisation of DB sync

#### TODO

- [ ] Advanced filtering and search capabilities
- [ ] Bulk alias operations
- [ ] Import/Export functionality
- [ ] Backup and restore functionality

## Tech Stack

- **Stack**: Flutter & Dart, the server uses java & C#
- **Database**: SQLite (main)
- **Containerization**: Docker

### Repo

This repository contains 2 git submodules that handle different aspects of the email alias management system:

```
./
├── [main-EA]     # main standalone codebase (can run on its own)
├── [server]     # centralised (docker supported) sync server 
```

## Quick Start

### Prerequisites

- Flutter SDK (android studio)
- Docker (for the server, you dont need to install the JDK sdk since its all in docker)

### Installation

1. Clone the repository with submodules:

```bash
git clone --recursive https://[clonedurl]/emailalias.git
cd emailalias
```

2. Initialize submodules (if not cloned recursively):

```bash
git submodule update --init --recursive
```

3. Build and run with Docker:

```bash
docker-compose up --build
```

### Docker Src Build

```bash
docker build -t email-alias-manager # DOESN'T WORK ON ARM
docker run -p 8080:8080 email-alias-manager # beware listens on 0.0.0.0
```
