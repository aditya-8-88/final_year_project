# Nagrik — Constitution & Laws for Every Citizen

> An AI-powered Flutter web application that makes Indian law accessible to every citizen through interactive exploration of the Constitution, landmark cases, legal provisions, and an intelligent chat assistant.

---

## 1. Introduction

**Nagrik** (meaning *Citizen* in Hindi) is a cross-platform legal education platform built with Flutter. It transforms complex constitutional articles, Indian Penal Code sections, landmark Supreme Court judgments, and legal terminology into clear, simple language that any citizen can understand.

The application integrates a GPT-4o-mini powered AI assistant that provides contextual explanations, answers legal queries in structured formats, and supports multi-session conversations — all without requiring any legal background from the user.

### Key Highlights

| Feature | Details |
|---------|---------|
| Constitution Explorer | 25+ articles across all parts with simple explanations |
| Indian Laws | 40+ sections from IPC, CrPC, IT Act, POCSO, and more |
| Landmark Cases | 37 Supreme Court decisions across 10 legal categories |
| AI Chat Assistant | GPT-4o-mini with multi-session contextual conversations |
| Legal Glossary | 30+ legal terms with Hindi translations and examples |
| Key Amendments | Major constitutional amendments with impact analysis |
| Smart Search | Cross-data search across all articles, laws, cases, and amendments |

---

## 2. Background

India's legal system, while comprehensive, remains inaccessible to the majority of its citizens. According to the India Justice Report (2022), over 70% of citizens lack basic awareness of their constitutional rights. Legal language is complex, scattered across multiple acts and amendments, and rarely presented in simple terms.

Existing solutions fall short in several ways:
- **Government portals** (legislative.gov.in, indiacode.nic.in) publish raw legal text without simplified explanations
- **Legal apps** focus narrowly on either case tracking or lawyer directories, not education
- **Generic AI chatbots** lack the domain-specific prompting needed for accurate Indian legal information

There is a clear need for a **unified, education-first platform** that combines constitutional articles, criminal and civil laws, landmark judgments, and AI-assisted explanations in one accessible application.

---

## 3. Problem Statement

*How can technology bridge the legal awareness gap for Indian citizens who lack access to simplified, reliable, and comprehensive information about their constitutional rights, legal protections, and landmark judicial decisions?*

Specific challenges addressed:
1. **Complexity barrier** — Legal provisions are written in technical language incomprehensible to non-lawyers
2. **Fragmentation** — Rights, laws, cases, and amendments are spread across dozens of separate sources
3. **Lack of context** — Citizens cannot relate abstract legal provisions to real-world situations
4. **No intelligent guidance** — No existing platform provides AI-powered, context-aware legal explanations specific to Indian law

---

## 4. Objectives

1. **Simplify** constitutional articles, legal sections, and amendments into plain language with Hindi terminology
2. **Consolidate** the Constitution, Indian Penal Code, landmark Supreme Court cases, and legal glossary into a single platform
3. **Integrate AI** for contextual, on-demand legal explanations using GPT-4o-mini with domain-specific prompt engineering
4. **Enable discovery** through smart search that finds relevant content across all data sources using multi-word matching
5. **Ensure accuracy** by grounding all content in official sources — constitutional references, section numbers, and case citations
6. **Build for accessibility** with responsive design, dark mode support, bookmarking, and a clear Material Design 3 interface

---

## 5. Methodology

### 5.1 System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        NAGRIK APPLICATION                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────┐  ┌──────────────┐  ┌────────┐  ┌──────────────┐  │
│  │   Home   │  │ Constitution │  │  Laws  │  │ AI Assistant │  │
│  │  Screen  │  │   Explorer   │  │ Screen │  │   Sessions   │  │
│  └────┬─────┘  └──────┬───────┘  └───┬────┘  └──────┬───────┘  │
│       │               │              │               │          │
│  ┌────┴───────────────┴──────────────┴───────────────┴────┐     │
│  │                   Navigation Layer                     │     │
│  │         (ResponsiveScaffold + Bottom Nav Bar)          │     │
│  └────────────────────────┬───────────────────────────────┘     │
│                           │                                     │
│  ┌────────────────────────┴───────────────────────────────┐     │
│  │                    Feature Modules                     │     │
│  ├──────────────┬──────────────┬──────────────────────────┤     │
│  │  Landmark    │  Amendments  │  Glossary / Bookmarks /  │     │
│  │  Cases (37)  │  Explorer    │  Search / DPSP / FR / FD │     │
│  └──────┬───────┴──────┬───────┴──────────┬──────────────┘     │
│         │              │                  │                     │
│  ┌──────┴──────────────┴──────────────────┴──────────────┐     │
│  │                    Data Layer                         │     │
│  ├───────────────┬────────────┬───────────┬──────────────┤     │
│  │ constitution  │  laws_data │  glossary │  models.dart │     │
│  │  _data.dart   │   .dart    │ _data.dart│  (6 models) │     │
│  └───────────────┴────────────┴───────────┴──────────────┘     │
│                                                                 │
│  ┌───────────────────────────────────────────────────────┐     │
│  │                   Services Layer                      │     │
│  ├──────────────┬──────────────┬─────────────────────────┤     │
│  │   GitHub     │   Session    │   Storage Service       │     │
│  │   Models     │    Cache     │ (SharedPreferences +    │     │
│  │  (GPT-4o-   │ (Multi-chat  │  Bookmarks + Theme)     │     │
│  │    mini)     │  sessions)   │                         │     │
│  └──────┬───────┴──────────────┴─────────────────────────┘     │
│         │                                                       │
└─────────┼───────────────────────────────────────────────────────┘
          │
          ▼
┌─────────────────────┐
│  GitHub Models API  │
│  (Azure-hosted      │
│   GPT-4o-mini)      │
└─────────────────────┘
```

### 5.2 Development Approach

| Phase | Activity | Output |
|-------|----------|--------|
| **Phase 1** | Requirements gathering, data collection from official sources | Data models, constitution & law datasets |
| **Phase 2** | UI/UX design with Material Design 3, responsive scaffold | 15+ screens, dark/light themes |
| **Phase 3** | AI integration with prompt engineering and multi-provider fallback | Contextual chat with session management |
| **Phase 4** | Smart search, bookmarks, enhanced navigation | Cross-data search with suggestion chips |
| **Phase 5** | Testing, deployment on Netlify with CI/CD | Live production build |

### 5.3 AI Prompt Engineering

The AI assistant uses a structured system prompt with:
- **Chain-of-thought reasoning** for legal analysis
- **Structured output format** — 📋 Law, 📖 Reference, 💡 Simple Explanation, 🔑 Hindi Term, ⚠️ Practical Tips
- **Few-shot examples** for consistent response quality
- **Guard rails** — never fabricates provisions, education-only (not legal advice), 150–250 word target
- **Contextual FABs** — each detail screen (article, law, case) pre-loads relevant context into the AI chat

### 5.4 Technology Stack

| Component | Technology | Purpose |
|-----------|-----------|---------|
| Framework | Flutter 3.24.5 | Cross-platform UI |
| Language | Dart 3.5.4 | Application logic |
| AI Model | GPT-4o-mini (GitHub Models) | Legal Q&A and explanations |
| Deployment | Netlify (CI/CD) | Automated web deployment |
| State | ValueNotifier + StatefulWidget | Reactive UI updates |
| Storage | SharedPreferences | Bookmarks, theme, settings |
| Rendering | flutter_markdown | AI response formatting |

---

## 6. Results and Discussion

### 6.1 Content Coverage

| Data Category | Count | Sources |
|---------------|-------|---------|
| Constitution Articles | 25+ | Constitution of India |
| Law Sections | 40+ | IPC, CrPC, IT Act, POCSO, DV Act |
| Landmark Cases | 37 | Supreme Court of India |
| Legal Categories | 10 | Fundamental Rights to Labour Law |
| Glossary Terms | 30+ | Legal dictionaries, Bar Council |
| Key Amendments | 15+ | Constitutional amendments |

### 6.2 AI Performance

- **Response quality:** Structured, cited responses with constitutional references in every answer
- **Provider reliability:** GitHub Models (GPT-4o-mini) with auto-fallback to Gemini and NVIDIA NIM
- **Session management:** Multi-session support with conversation history preservation
- **Context awareness:** FAB-triggered chats pre-load article/law/case context for relevant answers

### 6.3 Search Effectiveness

The enhanced search system supports:
- **Multi-word matching** — queries like "land property" match results where both words appear across any fields
- **Cross-data coverage** — single query searches articles, laws, cases, amendments, and glossary simultaneously
- **Suggestion chips** — 17 common legal topics for quick access
- **Categorized results** — results grouped by type with count badges

### 6.4 User Interface

- **4-tab navigation** — Home, Constitution, Laws, AI Assistant
- **Responsive design** — adapts from mobile to desktop with NavigationRail
- **Dark/Light themes** — Material Design 3 with persistent preference
- **Contextual FABs** — "Ask AI" / "Know More" buttons on every detail page

---

## 7. Impact and Benefits

### For Citizens
- **Legal empowerment** — understand rights without needing a lawyer
- **Instant access** — search any legal topic and get simplified explanations within seconds
- **Bilingual support** — Hindi terminology alongside English for better comprehension
- **AI guidance** — ask follow-up questions in natural language and get structured, cited answers

### For Students and Researchers
- **Consolidated reference** — Constitution, laws, and cases in one searchable platform
- **Case law discovery** — 37 landmark cases with significance and year, filterable by 10 categories
- **Amendment tracking** — understand how the Constitution has evolved over decades

### For Legal Awareness
- **Bridges the knowledge gap** — makes complex legal provisions accessible to non-lawyers
- **Encourages rights awareness** — citizens who know their rights are better equipped to exercise them
- **Reliable information** — all content grounded in official sources, not user-generated or unverified

### Technical Benefits
- **Cross-platform** — runs on web, Android, iOS, Windows, macOS, and Linux from a single codebase
- **Offline-capable data** — all content is bundled in the app, no internet needed for browsing
- **AI only when needed** — internet required only for AI chat; all other features work offline

---

## 8. Conclusion and Future Work

### Conclusion

Nagrik demonstrates that technology can meaningfully bridge the legal awareness gap in India. By combining comprehensive legal data, simplified explanations, landmark case references, and an AI-powered assistant, the application makes Indian law accessible to any citizen with a smartphone or browser. The structured AI prompt engineering ensures reliable, cited responses while the multi-session chat system allows deep exploration of legal topics.

### Future Work

1. **Offline AI** — integrate on-device language models for AI explanations without internet
2. **Voice interaction** — add speech-to-text for querying legal information in regional languages
3. **Multi-language support** — full Hindi, Tamil, Bengali, and other regional language translations
4. **Legal document generator** — templates for RTI applications, FIR complaints, and legal notices
5. **Community features** — moderated Q&A forum for legal discussions with verified answers
6. **Push notifications** — alerts for new Supreme Court judgments and legislative changes
7. **Expanded coverage** — add state-specific laws, consumer protection, labour tribunals, and tax laws
8. **Accessibility** — screen reader support, high contrast mode, and font size controls

---

## Getting Started

### Prerequisites
- Flutter SDK 3.24.5+
- Dart SDK 3.5.4+

### Run Locally

```bash
git clone https://github.com/aditya-8-88/final_year_project.git
cd final_year_project
flutter pub get

# Create .env file with your API keys
echo "GITHUB_TOKEN=your_github_pat_here" > .env
echo "CHAT_PROVIDER_DEFAULT=github" >> .env

# Run on Chrome
flutter run -d chrome --dart-define-from-file=.env
```

### Build for Production

```bash
flutter build web --dart-define-from-file=.env
```

---

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── config/
│   ├── constants.dart           # AI prompts, app config
│   └── theme.dart               # Material 3 light/dark themes
├── data/
│   ├── constitution_data.dart   # Articles, parts, amendments
│   ├── laws_data.dart           # IPC, CrPC, IT Act sections
│   ├── glossary_data.dart       # Legal terms with Hindi
│   └── quiz_data.dart           # Knowledge quiz questions
├── models/
│   └── models.dart              # Data models (6 classes)
├── screens/
│   ├── home_screen.dart         # Dashboard with stats & navigation
│   ├── constitution_explorer_screen.dart
│   ├── laws_screen.dart         # Law categories & detail view
│   ├── landmark_cases_screen.dart   # 37 cases, 10 categories
│   ├── chatbot_screen.dart      # AI chat with context support
│   ├── chat_sessions_screen.dart    # Multi-session management
│   ├── search_screen.dart       # Enhanced cross-data search
│   ├── article_detail_screen.dart
│   ├── amendments_screen.dart
│   ├── fundamental_rights_screen.dart
│   ├── fundamental_duties_screen.dart
│   ├── dpsp_screen.dart
│   ├── glossary_screen.dart
│   ├── bookmarks_screen.dart
│   ├── about_screen.dart
│   └── quiz_screen.dart
├── services/
│   ├── github_models_service.dart   # GPT-4o-mini API
│   ├── gemini_service.dart          # Gemini fallback
│   ├── nvidia_service.dart          # NVIDIA NIM fallback
│   ├── session_cache.dart           # Multi-session chat storage
│   └── storage_service.dart         # Preferences & bookmarks
└── widgets/
    ├── responsive_scaffold.dart     # Adaptive nav layout
    ├── article_card.dart            # Reusable article cards
    └── chat_bubble.dart             # AI/user message bubbles
```
---

## License

This project is for educational purposes as part of a B.Tech final year project.
