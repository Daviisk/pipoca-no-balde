# Pipoca no Balde 🍿

Aplicação Next.js (App Router) para cardápio gourmet mobile-first, carrinho, checkout Mercado Pago e painel administrativo.

## Estado atual
Código-base de integração real enviado ao GitHub. **Ainda não publicado nem homologado para receber pagamentos.** É necessário configurar serviços externos, fotos, preços, frete e validar testes de ponta a ponta. O protótipo `index.html` antigo permanece no repositório como referência, mas o aplicativo usa `app/`.

## Configuração
1. `npm install` e `npm run dev`.
2. Criar projeto Supabase e executar `supabase/schema.sql` no SQL Editor.
3. Copiar `.env.example` para `.env.local` e preencher as variáveis.
4. Criar usuário administrativo em Supabase Authentication; inserir seu UUID em `admin_users` pelo SQL Editor.
5. Cadastrar produtos reais em `products` com nome, categoria, preço e foto HTTPS.
6. Configurar no Mercado Pago o token de produção e segredo de assinatura de webhook. URL: `https://SEU-DOMINIO/api/webhooks/mercadopago`.
7. Definir `NEXT_PUBLIC_SITE_URL` com o domínio público e publicar na Vercel.
8. Validar pagamento Pix e cartão, webhook, reentregas, autenticação, checkout e política de privacidade em ambiente controlado antes de liberar pedidos.

## Fluxos
- Uber chamado pelo cliente: cliente só solicita motorista após receber aviso de pedido pronto (texto gerado no painel para copiar).
- Retirada presencial agendada: horário solicitado pelo cliente, sujeito a confirmação da loja.
- Retirada presencial combinada: horário combinado com a loja.
- Motoboy: opção visível, mas checkout bloqueado até a configuração de cálculo de frete para impedir cobranças incorretas.
- Mensagens WhatsApp: botão de copiar no painel; não há envio automático.

## Segurança e limitações
- O servidor recalcula preços a partir do catálogo; nunca confia nos valores do navegador.
- Pedidos e administração são acessados somente pelo servidor com chave de serviço; não exponha `SUPABASE_SERVICE_ROLE_KEY` ou `MERCADOPAGO_ACCESS_TOKEN` no navegador.
- O webhook verifica assinatura e consulta o pagamento no Mercado Pago antes de marcar como pago.
- A interface administrativa permite consultar pedidos, alterar status e disponibilidade; cadastro/edição de catálogo, upload de imagens, autenticação opcional de clientes, taxas de motoboy e personalização de sabores/tamanhos ainda precisam ser implementados.
- A implementação não foi submetida a testes automatizados ou testes de pagamento reais nesta etapa.
