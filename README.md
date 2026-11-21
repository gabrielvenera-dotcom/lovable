# G&G Empréstimos

Painel inicial de administração e gestão de convites para cadastro de clientes.

## Arquivos
- `index.html`: interface administrativa responsiva, autenticação Supabase, visão geral, clientes, solicitações e convites.
- `supabase/migrations/202611210001_registration_invites.sql`: criação da tabela de convites de uso único e política RLS.

## Configuração
O frontend usa o projeto Supabase já configurado no `index.html`. A chave publishable/anon é pública por natureza; a segurança depende das políticas RLS. Nunca coloque service_role ou outras chaves secretas no navegador.

## Passos antes de usar
1. No Supabase SQL Editor, revisar e executar a migração em `supabase/migrations/202611210001_registration_invites.sql`.
2. Confirmar que o usuário administrativo possui um registro em `public.profiles` com `role = 'admin'`.
3. Confirmar as políticas RLS de `profiles`, `client_data` e `loan_applications`.
4. Importar o repositório no Lovable e validar a conexão.

## Estado desta versão
A interface administrativa consulta as tabelas existentes `profiles`, `client_data` e `loan_applications`. O módulo de convites grava hashes de tokens em `registration_invites`; o token original só aparece uma vez na tela. A rota/formulário público de cadastro ainda será implementada na próxima etapa. Portanto, **não enviar convites a clientes ainda**.

O sistema não realiza transferências, pagamentos ou cobranças automáticas. A formalização de crédito, validação de identidade, liberação de recursos e gestão de encargos exigem implementação e revisão jurídica específicas antes de produção.
