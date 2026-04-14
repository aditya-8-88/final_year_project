# Chatbot Setup (Netlify + Flutter)

This project now includes a provider-neutral chatbot architecture:

- Flutter client calls same-origin endpoint: `/api/chat`
- Netlify Function: `netlify/functions/chat.js`
- Netlify function calls one or more model providers (Gemini and/or NVIDIA)
- Provider keys live only in Netlify environment variables

## 1) Configure Netlify Environment Variables

Set these in Netlify site settings:

### Required (at least one provider)
- `GEMINI_API_KEY`
- `NVIDIA_API_KEY`

### Optional provider config
- `CHAT_PROVIDER_DEFAULT` (`gemini` or `nvidia`, default: `gemini`)
- `GEMINI_MODEL` (default: `gemini-1.5-flash`)
- `NVIDIA_MODEL` (default: `meta/llama-3.1-70b-instruct`)
- `NVIDIA_BASE_URL` (default: `https://integrate.api.nvidia.com`)

### Recommended (both providers + Gemini default)
- `GEMINI_API_KEY=<your gemini key>`
- `NVIDIA_API_KEY=<your nvidia key>`
- `CHAT_PROVIDER_DEFAULT=gemini`

### Exact steps in Netlify UI
1. Open Netlify dashboard and choose your site.
2. Go to **Site configuration**.
3. Open **Environment variables**.
4. Click **Add a variable**.
5. Add these one by one:
  - `GEMINI_API_KEY`
  - `NVIDIA_API_KEY`
  - `CHAT_PROVIDER_DEFAULT` with value `gemini`
6. Save variables.
7. Trigger a fresh deploy from **Deploys** -> **Trigger deploy** -> **Deploy site**.

### Important notes
- Do not put API keys in Flutter code or repository files.
- If Gemini hits quota or fails, backend auto-falls back to NVIDIA (when `NVIDIA_API_KEY` is set).
- If NVIDIA model access differs in your account, set `NVIDIA_MODEL` explicitly to a model available to your key.

## 2) Netlify Routing

`netlify.toml` now contains:

- Functions directory config (`netlify/functions`)
- API redirect:
  - `/api/* -> /.netlify/functions/:splat`
- SPA redirect remains for all other routes

The API redirect must remain above the catch-all SPA redirect.

## 3) Client Contract

### Request (from Flutter)

```json
{
  "contractVersion": "1.0",
  "sessionId": "session_...",
  "message": "How can I file Zero FIR?",
  "history": [
    {"role": "user", "content": "...", "timestamp": "..."}
  ],
  "locale": "en-IN",
  "context": {"screen": "global_overlay", "platform": "web"},
  "providerPreference": "auto"
}
```

`providerPreference` supports: `auto`, `gemini`, `nvidia`.

### Response (from Netlify function)

```json
{
  "contractVersion": "1.0",
  "traceId": "trace_...",
  "providerUsed": "gemini",
  "modelUsed": "gemini-1.5-flash",
  "emergencyFlag": false,
  "disclaimer": "...",
  "answer": "...",
  "citations": [
    {"title": "NALSA", "url": "https://nalsa.gov.in/"}
  ]
}
```

## 4) Multi-Provider Behavior

The backend chooses providers in this order:

1. Requested provider from `providerPreference` (if available)
2. `CHAT_PROVIDER_DEFAULT`
3. Other configured provider

If one provider fails, it automatically falls back to the next configured provider.

## 5) Safety and Emergency Behavior

The backend enforces domain safety:

- Detects emergency context and prioritizes immediate helpline guidance
- Provides awareness-focused legal support, not formal legal representation
- Blocks harmful intent responses
- Adds source citations when context matches known legal resources

## 6) Local and Mobile Notes

For Flutter Web deployment on Netlify, no extra client URL config is needed.

For non-web runs (Android/iOS/desktop), pass:

```bash
flutter run --dart-define=CHAT_API_BASE_URL=https://<your-netlify-site>.netlify.app
```

This is required because non-web targets cannot use a relative URL like `/api/chat`.

## 7) Quick Verification Checklist

- Chat button appears on all screens
- Sending a message returns an assistant response
- Provider dropdown (`Auto`, `Gemini`, `NVIDIA`) works
- Citations open source links
- Emergency-style query returns urgent helpline-first guidance
- No provider keys are present in Flutter code or web build output

## 8) Local CLI Checks Before Push

Fast path (recommended):
1. Run from project root:
  - ./pre_push_checks.sh

This script validates Flutter and Node availability, then runs analyze, tests, web build, and Netlify function syntax check.

If your terminal shows "command not found" for Flutter or Node, install them first.

### One-time install on macOS (Homebrew)
1. Install Flutter:
  - brew install --cask flutter
2. Install Node 18 (matches .nvmrc):
  - brew install node@18
3. Add Node 18 to PATH:
  - echo 'export PATH="/opt/homebrew/opt/node@18/bin:$PATH"' >> ~/.zshrc
  - source ~/.zshrc
4. Verify:
  - flutter --version
  - node -v
  - npm -v

### Run checks in project root
1. flutter clean
2. flutter pub get
3. flutter analyze
4. flutter test
5. flutter build web --release
6. node --check netlify/functions/chat.js

### Optional: Netlify function smoke test locally
1. npm install -g netlify-cli
2. netlify dev
3. Open http://localhost:8888 and send one chat message in app UI.
