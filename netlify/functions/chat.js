'use strict';

const CONTRACT_VERSION = '1.0';
const BASE_DISCLAIMER =
  'This assistant is for legal awareness and safety education only. It is not a substitute for emergency services or professional legal advice.';

const RATE_WINDOW_MS = 5 * 60 * 1000;
const RATE_LIMIT_MAX_REQUESTS = 25;
const rateWindowByClient = new Map();

const EMERGENCY_CITATIONS = [
  {
    title: 'National Emergency Number (112)',
    url: 'https://www.dial112.gov.in/',
  },
  {
    title: 'Women Helpline (181)',
    url: 'https://wcd.nic.in/',
  },
  {
    title: 'National Commission for Women (NCW)',
    url: 'https://ncw.nic.in/',
  },
  {
    title: 'Cyber Crime Portal',
    url: 'https://cybercrime.gov.in/',
  },
];

const KNOWLEDGE_BASE = [
  {
    id: 'zero_fir',
    title: 'Right to File Zero FIR',
    content:
      'A woman can file an FIR at any police station regardless of jurisdiction under Section 154 CrPC. The station must register and transfer it to the concerned station.',
    keywords: ['zero fir', 'fir', 'police refused', 'register complaint', 'section 154'],
    citations: [
      { title: 'Legislative Department (India)', url: 'https://legislative.gov.in/' },
      { title: 'Ministry of Home Affairs', url: 'https://www.mha.gov.in/' },
    ],
  },
  {
    id: 'free_legal_aid',
    title: 'Right to Free Legal Aid',
    content:
      'Women affected by sexual violence can access free legal aid through Legal Services Authorities under Article 39A and the Legal Services Authorities Act.',
    keywords: ['free lawyer', 'legal aid', 'nalsa', 'article 39a', 'court help'],
    citations: [
      { title: 'NALSA', url: 'https://nalsa.gov.in/' },
      { title: 'Constitution of India', url: 'https://legislative.gov.in/constitution-of-india' },
    ],
  },
  {
    id: 'medical_rights',
    title: 'Right to Immediate Medical Care',
    content:
      'Sexual assault survivors are entitled to free, immediate medical treatment and examination. Hospitals cannot deny care and police referral is not required first.',
    keywords: ['medical exam', 'hospital denied', 'section 164a', 'treatment', 'doctor'],
    citations: [
      { title: 'Ministry of Health and Family Welfare', url: 'https://www.mohfw.gov.in/' },
      { title: 'Legislative Department (India)', url: 'https://legislative.gov.in/' },
    ],
  },
  {
    id: 'trial_privacy',
    title: 'Trial Privacy and Identity Protection',
    content:
      'Sexual assault trials can be held in camera and survivor identity must be protected. Public disclosure can attract legal consequences.',
    keywords: ['in camera', 'privacy', 'media name', 'identity', 'section 327'],
    citations: [
      { title: 'Department of Justice', url: 'https://doj.gov.in/' },
      { title: 'eCourts Services', url: 'https://districts.ecourts.gov.in/' },
    ],
  },
  {
    id: 'cyber_safety',
    title: 'Cyber Crime Action Path',
    content:
      'For cyber harassment, stalking, image misuse or extortion: preserve evidence, avoid deleting chats, and report via cybercrime portal and helpline 1930.',
    keywords: ['cyber', 'online harassment', 'morphed image', 'blackmail', 'stalking online', '1930'],
    citations: [
      { title: 'National Cyber Crime Reporting Portal', url: 'https://cybercrime.gov.in/' },
      { title: 'NCRB', url: 'https://ncrb.gov.in/' },
    ],
  },
  {
    id: 'workplace_posh',
    title: 'Workplace POSH Rights',
    content:
      'Workplaces with 10+ employees must have an Internal Complaints Committee under the POSH Act 2013. Complaints should be handled with confidentiality and process safeguards.',
    keywords: ['workplace', 'office harassment', 'posh', 'icc', 'internal complaints committee'],
    citations: [
      {
        title: 'POSH Act (Ministry of Women and Child Development)',
        url: 'https://wcd.nic.in/acts/sexual-harassment-women-workplace-prevention-prohibition-and-redressal-act-2013',
      },
      { title: 'National Commission for Women', url: 'https://ncw.nic.in/' },
    ],
  },
  {
    id: 'compensation',
    title: 'Victim Compensation',
    content:
      'Survivors can seek compensation via District Legal Services Authority under Section 357A CrPC and state victim compensation schemes.',
    keywords: ['compensation', '357a', 'financial support', 'rehabilitation'],
    citations: [
      { title: 'NALSA Victim Compensation', url: 'https://nalsa.gov.in/victim-compensation' },
      { title: 'Department of Justice', url: 'https://doj.gov.in/' },
    ],
  },
  {
    id: 'helplines',
    title: 'Official Helplines',
    content:
      'Important helplines include 112 (national emergency), 181 (women), 1091 (women), NCW support, and 1930 for cyber financial and online incidents.',
    keywords: ['helpline', '112', '181', '1091', 'ncw', 'emergency number'],
    citations: EMERGENCY_CITATIONS,
  },
  {
    id: 'statistics',
    title: 'Official Statistics Context',
    content:
      'Official Indian and global reports consistently show high underreporting of crimes and indicate that many offenders are known to the victim.',
    keywords: ['statistics', 'ncrb', 'who', 'reporting rate', 'conviction'],
    citations: [
      { title: 'NCRB', url: 'https://ncrb.gov.in/' },
      {
        title: 'WHO: Violence Against Women Facts',
        url: 'https://www.who.int/news-room/fact-sheets/detail/violence-against-women',
      },
    ],
  },
];

function getTraceId() {
  return `trace_${Date.now()}_${Math.random().toString(36).slice(2, 10)}`;
}

function getClientId(headers) {
  const ipHeader =
    headers['x-nf-client-connection-ip'] ||
    headers['client-ip'] ||
    headers['x-forwarded-for'] ||
    'unknown';
  return String(ipHeader).split(',')[0].trim();
}

function isRateLimited(clientId) {
  const now = Date.now();
  const timestamps = rateWindowByClient.get(clientId) || [];
  const fresh = timestamps.filter((t) => now - t < RATE_WINDOW_MS);

  if (fresh.length >= RATE_LIMIT_MAX_REQUESTS) {
    rateWindowByClient.set(clientId, fresh);
    return true;
  }

  fresh.push(now);
  rateWindowByClient.set(clientId, fresh);
  return false;
}

function buildHeaders(origin) {
  const allowOrigin = origin || '*';
  return {
    'Content-Type': 'application/json; charset=utf-8',
    'Access-Control-Allow-Origin': allowOrigin,
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Allow-Methods': 'POST, OPTIONS',
    'Cache-Control': 'no-store',
  };
}

function jsonResponse(statusCode, body, origin) {
  return {
    statusCode,
    headers: buildHeaders(origin),
    body: JSON.stringify(body),
  };
}

function parseBody(event) {
  if (!event.body) {
    return {};
  }

  try {
    const rawBody = event.isBase64Encoded
      ? Buffer.from(event.body, 'base64').toString('utf-8')
      : event.body;
    return JSON.parse(rawBody);
  } catch (error) {
    return null;
  }
}

function normalizeProviderPreference(value) {
  const normalized = String(value || 'auto').toLowerCase();
  if (normalized === 'gemini' || normalized === 'nvidia' || normalized === 'auto') {
    return normalized;
  }
  return 'auto';
}

function resolveProviderOrder(preference) {
  const defaultProvider = String(process.env.CHAT_PROVIDER_DEFAULT || 'gemini').toLowerCase();
  const available = [];

  if (process.env.GEMINI_API_KEY) {
    available.push('gemini');
  }
  if (process.env.NVIDIA_API_KEY) {
    available.push('nvidia');
  }

  if (available.length === 0) {
    return [];
  }

  const order = [];
  if (preference !== 'auto' && available.includes(preference)) {
    order.push(preference);
  }

  if (available.includes(defaultProvider) && !order.includes(defaultProvider)) {
    order.push(defaultProvider);
  }

  for (const provider of available) {
    if (!order.includes(provider)) {
      order.push(provider);
    }
  }

  return order;
}

function containsDisallowedIntent(message) {
  const text = message.toLowerCase();
  const disallowedPatterns = [
    /how\s+to\s+kill/,
    /how\s+to\s+hurt/,
    /how\s+to\s+attack/,
    /poison\s+someone/,
    /harm\s+her/,
    /revenge\s+porn\s+tips/,
  ];
  return disallowedPatterns.some((pattern) => pattern.test(text));
}

function analyzeSafety(message) {
  const text = message.toLowerCase();

  const emergencySignals = [
    'help me now',
    'im in danger',
    'i am in danger',
    'someone is following me',
    'someone attacked me',
    'being attacked',
    'kidnapped',
    'threatening me',
    'domestic violence now',
    'assault happening',
    'urgent',
  ];

  const criticalSignals = [
    'being attacked',
    'attacked right now',
    'kidnapped',
    'im trapped',
    'i am trapped',
    'cannot escape',
    'in immediate danger',
  ];

  const isEmergency = emergencySignals.some((signal) => text.includes(signal));
  const isCritical = criticalSignals.some((signal) => text.includes(signal));

  return { isEmergency, isCritical };
}

function dedupeCitations(citations) {
  const seen = new Set();
  const output = [];
  for (const citation of citations) {
    if (!citation || !citation.url) {
      continue;
    }
    if (seen.has(citation.url)) {
      continue;
    }
    seen.add(citation.url);
    output.push(citation);
  }
  return output;
}

function selectKnowledge(message, maxItems = 3) {
  const text = message.toLowerCase();
  const scored = KNOWLEDGE_BASE.map((item) => {
    let score = 0;
    for (const keyword of item.keywords) {
      if (text.includes(keyword)) {
        score += 1;
      }
    }
    return { item, score };
  })
    .filter((entry) => entry.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, maxItems)
    .map((entry) => entry.item);

  if (scored.length > 0) {
    return scored;
  }

  return [
    KNOWLEDGE_BASE.find((item) => item.id === 'helplines'),
    KNOWLEDGE_BASE.find((item) => item.id === 'free_legal_aid'),
  ].filter(Boolean);
}

function buildSystemPrompt() {
  return [
    'You are an assistant for women safety and legal awareness in India.',
    'Rules:',
    '1) Prioritize user safety and practical, immediate next steps.',
    '2) For emergency-risk context, advise calling 112 and relevant helplines immediately.',
    '3) Provide educational legal awareness content, not definitive legal representation.',
    '4) Avoid hallucinations and avoid inventing sections or agencies.',
    '5) Keep tone calm, supportive, and concise.',
    '6) If unsure, say what is uncertain and suggest official sources.',
  ].join('\n');
}

function buildUserPrompt(message, history, selectedKnowledge, safety) {
  const historyLines = history
    .slice(-8)
    .map((item) => `${item.role || 'user'}: ${item.content || ''}`)
    .join('\n');

  const contextLines = selectedKnowledge
    .map((item, index) => `Context ${index + 1}: ${item.title}\n${item.content}`)
    .join('\n\n');

  const emergencyNote = safety.isEmergency
    ? 'Emergency context detected. Begin with immediate safety actions and helplines, then answer legal-awareness question.'
    : 'No emergency signal detected.';

  return [
    emergencyNote,
    'Use the trusted context below when relevant:',
    contextLines,
    'Conversation history:',
    historyLines || 'No prior history.',
    'User message:',
    message,
  ].join('\n\n');
}

async function callGemini({ prompt, systemPrompt }) {
  const apiKey = process.env.GEMINI_API_KEY;
  const model = process.env.GEMINI_MODEL || 'gemini-1.5-flash';

  if (!apiKey) {
    throw new Error('Gemini API key missing');
  }

  const endpoint = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${apiKey}`;

  const response = await fetch(endpoint, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      system_instruction: {
        parts: [{ text: systemPrompt }],
      },
      contents: [
        {
          role: 'user',
          parts: [{ text: prompt }],
        },
      ],
      generationConfig: {
        temperature: 0.2,
        topP: 0.9,
        maxOutputTokens: 700,
      },
    }),
  });

  const payload = await response.json();

  if (!response.ok) {
    const message = payload?.error?.message || 'Gemini request failed';
    throw new Error(message);
  }

  const parts = payload?.candidates?.[0]?.content?.parts || [];
  const text = parts
    .map((part) => part.text)
    .filter(Boolean)
    .join('\n')
    .trim();

  if (!text) {
    throw new Error('Gemini returned empty response');
  }

  return {
    providerUsed: 'gemini',
    modelUsed: model,
    text,
  };
}

async function callNvidia({ prompt, systemPrompt }) {
  const apiKey = process.env.NVIDIA_API_KEY;
  const model = process.env.NVIDIA_MODEL || 'meta/llama-3.1-70b-instruct';
  const baseUrl = process.env.NVIDIA_BASE_URL || 'https://integrate.api.nvidia.com';

  if (!apiKey) {
    throw new Error('NVIDIA API key missing');
  }

  const endpoint = `${baseUrl.replace(/\/$/, '')}/v1/chat/completions`;

  const response = await fetch(endpoint, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${apiKey}`,
    },
    body: JSON.stringify({
      model,
      temperature: 0.2,
      max_tokens: 700,
      messages: [
        { role: 'system', content: systemPrompt },
        { role: 'user', content: prompt },
      ],
    }),
  });

  const payload = await response.json();

  if (!response.ok) {
    const message = payload?.error?.message || 'NVIDIA request failed';
    throw new Error(message);
  }

  const text = payload?.choices?.[0]?.message?.content?.trim();

  if (!text) {
    throw new Error('NVIDIA returned empty response');
  }

  return {
    providerUsed: 'nvidia',
    modelUsed: model,
    text,
  };
}

async function callProvider(provider, payload) {
  if (provider === 'gemini') {
    return callGemini(payload);
  }
  if (provider === 'nvidia') {
    return callNvidia(payload);
  }
  throw new Error(`Unsupported provider: ${provider}`);
}

function buildCriticalEmergencyAnswer() {
  return [
    'If you are in immediate danger, call 112 now.',
    'If possible, move to a safer public place and contact a trusted person immediately.',
    'For women-focused support, call 181 and report cyber abuse at 1930 or cybercrime.gov.in.',
    'If police refuse to register your complaint, ask to file a Zero FIR at any police station.',
  ].join(' ');
}

exports.handler = async (event) => {
  const origin = event.headers?.origin || event.headers?.Origin || '*';

  if (event.httpMethod === 'OPTIONS') {
    return {
      statusCode: 200,
      headers: buildHeaders(origin),
      body: '',
    };
  }

  if (event.httpMethod !== 'POST') {
    return jsonResponse(
      405,
      {
        contractVersion: CONTRACT_VERSION,
        error: { code: 'METHOD_NOT_ALLOWED', message: 'Use POST for /api/chat' },
      },
      origin,
    );
  }

  const clientId = getClientId(event.headers || {});
  if (isRateLimited(clientId)) {
    return jsonResponse(
      429,
      {
        contractVersion: CONTRACT_VERSION,
        error: {
          code: 'RATE_LIMITED',
          message: 'Too many requests. Please wait a few minutes and try again.',
        },
      },
      origin,
    );
  }

  const body = parseBody(event);
  if (body === null) {
    return jsonResponse(
      400,
      {
        contractVersion: CONTRACT_VERSION,
        error: { code: 'BAD_JSON', message: 'Invalid JSON request body.' },
      },
      origin,
    );
  }

  const message = String(body.message || '').trim();
  const history = Array.isArray(body.history) ? body.history : [];
  const providerPreference = normalizeProviderPreference(body.providerPreference);
  const traceId = getTraceId();

  if (!message) {
    return jsonResponse(
      400,
      {
        contractVersion: CONTRACT_VERSION,
        traceId,
        error: { code: 'EMPTY_MESSAGE', message: 'Message is required.' },
      },
      origin,
    );
  }

  if (containsDisallowedIntent(message)) {
    return jsonResponse(
      200,
      {
        contractVersion: CONTRACT_VERSION,
        traceId,
        providerUsed: 'safety_block',
        modelUsed: 'none',
        emergencyFlag: false,
        disclaimer: BASE_DISCLAIMER,
        answer: "Sorry, I can't assist with that.",
        citations: [],
      },
      origin,
    );
  }

  const safety = analyzeSafety(message);
  const selectedKnowledge = selectKnowledge(message, 3);
  const citations = dedupeCitations([
    ...selectedKnowledge.flatMap((item) => item.citations || []),
    ...(safety.isEmergency ? EMERGENCY_CITATIONS : []),
  ]).slice(0, 6);

  if (safety.isCritical) {
    return jsonResponse(
      200,
      {
        contractVersion: CONTRACT_VERSION,
        traceId,
        providerUsed: 'safety_critical_path',
        modelUsed: 'none',
        emergencyFlag: true,
        disclaimer: BASE_DISCLAIMER,
        answer: buildCriticalEmergencyAnswer(),
        citations,
      },
      origin,
    );
  }

  const providerOrder = resolveProviderOrder(providerPreference);

  if (providerOrder.length === 0) {
    return jsonResponse(
      500,
      {
        contractVersion: CONTRACT_VERSION,
        traceId,
        error: {
          code: 'PROVIDER_NOT_CONFIGURED',
          message:
            'No AI provider is configured. Set GEMINI_API_KEY and/or NVIDIA_API_KEY in Netlify environment variables.',
        },
      },
      origin,
    );
  }

  const systemPrompt = buildSystemPrompt();
  const userPrompt = buildUserPrompt(message, history, selectedKnowledge, safety);

  const providerErrors = [];
  for (const provider of providerOrder) {
    try {
      const providerResult = await callProvider(provider, {
        prompt: userPrompt,
        systemPrompt,
      });

      return jsonResponse(
        200,
        {
          contractVersion: CONTRACT_VERSION,
          traceId,
          providerUsed: providerResult.providerUsed,
          modelUsed: providerResult.modelUsed,
          emergencyFlag: safety.isEmergency,
          disclaimer: BASE_DISCLAIMER,
          answer: providerResult.text,
          citations,
        },
        origin,
      );
    } catch (error) {
      providerErrors.push({ provider, message: error.message });
      console.error(`[chat] provider failure: ${provider}`, error.message);
    }
  }

  return jsonResponse(
    502,
    {
      contractVersion: CONTRACT_VERSION,
      traceId,
      error: {
        code: 'ALL_PROVIDERS_FAILED',
        message: 'All configured providers failed for this request.',
        details: providerErrors,
      },
    },
    origin,
  );
};
