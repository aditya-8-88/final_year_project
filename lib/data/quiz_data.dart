import '../models/models.dart';

final List<QuizQuestion> quizQuestions = [
  // Preamble & Basics
  const QuizQuestion(
    question: 'Which words were added to the Preamble by the 42nd Amendment?',
    options: ['Federal and Democratic', 'Socialist and Secular', 'Sovereign and Republic', 'Justice and Liberty'],
    correctIndex: 1,
    explanation: 'The 42nd Amendment (1976) added "Socialist" and "Secular" to the Preamble, along with "Integrity" of the Nation.',
    category: 'Preamble',
  ),
  const QuizQuestion(
    question: 'On which date was the Constitution of India adopted?',
    options: ['January 26, 1950', 'August 15, 1947', 'November 26, 1949', 'January 30, 1948'],
    correctIndex: 2,
    explanation: 'The Constitution was adopted on November 26, 1949 (celebrated as Constitution Day) and came into effect on January 26, 1950 (Republic Day).',
    category: 'Preamble',
  ),
  const QuizQuestion(
    question: 'Who is known as the "Father of the Indian Constitution"?',
    options: ['Mahatma Gandhi', 'Jawaharlal Nehru', 'Dr. B.R. Ambedkar', 'Sardar Patel'],
    correctIndex: 2,
    explanation: 'Dr. Bhimrao Ramji Ambedkar was the Chairman of the Drafting Committee and is called the Father of the Indian Constitution.',
    category: 'Preamble',
  ),
  const QuizQuestion(
    question: 'India is described in Article 1 as:',
    options: ['A Federation of States', 'A Union of States', 'A Confederation of States', 'A Republic of States'],
    correctIndex: 1,
    explanation: 'Article 1 says "India, that is Bharat, shall be a Union of States." The word "Union" implies states cannot secede from India.',
    category: 'Basics',
  ),

  // Fundamental Rights
  const QuizQuestion(
    question: 'Which Article is called the "Heart and Soul" of the Constitution?',
    options: ['Article 14', 'Article 19', 'Article 21', 'Article 32'],
    correctIndex: 3,
    explanation: 'Dr. Ambedkar called Article 32 (Right to Constitutional Remedies) the "heart and soul" of the Constitution because it allows citizens to directly approach the Supreme Court to enforce fundamental rights.',
    category: 'Fundamental Rights',
  ),
  const QuizQuestion(
    question: 'Article 21 protects:',
    options: ['Right to Equality', 'Right to Life and Personal Liberty', 'Right to Freedom of Religion', 'Right against Exploitation'],
    correctIndex: 1,
    explanation: 'Article 21 says "No person shall be deprived of his life or personal liberty except according to procedure established by law." The Supreme Court has expanded this to include right to dignity, privacy, livelihood, clean environment, and more.',
    category: 'Fundamental Rights',
  ),
  const QuizQuestion(
    question: 'Which Article abolished Untouchability?',
    options: ['Article 14', 'Article 15', 'Article 17', 'Article 18'],
    correctIndex: 2,
    explanation: 'Article 17 abolished Untouchability and made its practice in any form a punishable offense under the Protection of Civil Rights Act, 1955.',
    category: 'Fundamental Rights',
  ),
  const QuizQuestion(
    question: 'Right to Education (Article 21A) guarantees free education for children of age:',
    options: ['5 to 12 years', '6 to 14 years', '6 to 16 years', '5 to 14 years'],
    correctIndex: 1,
    explanation: 'Article 21A (added by 86th Amendment, 2002) guarantees free and compulsory education for children aged 6 to 14 years.',
    category: 'Fundamental Rights',
  ),
  const QuizQuestion(
    question: 'How many types of writs can the Supreme Court issue under Article 32?',
    options: ['3', '4', '5', '6'],
    correctIndex: 2,
    explanation: 'Five writs: Habeas Corpus (produce the body), Mandamus (command to act), Prohibition (stop lower court), Certiorari (quash order), and Quo Warranto (by what authority).',
    category: 'Fundamental Rights',
  ),
  const QuizQuestion(
    question: 'Which Fundamental Right was removed by the 44th Amendment?',
    options: ['Right to Equality', 'Right to Property', 'Right to Freedom', 'Right to Religion'],
    correctIndex: 1,
    explanation: 'Right to Property (Article 31) was removed as a Fundamental Right by the 44th Amendment (1978) and made a legal right under Article 300A.',
    category: 'Fundamental Rights',
  ),

  // DPSP & Duties
  const QuizQuestion(
    question: 'Directive Principles of State Policy are:',
    options: ['Enforceable by courts', 'Not enforceable by courts', 'Only for the judiciary', 'Only for citizens'],
    correctIndex: 1,
    explanation: 'DPSPs (Articles 36-51) are guidelines for the government but are NOT enforceable by any court. However, they are fundamental in governance of the country.',
    category: 'DPSP',
  ),
  const QuizQuestion(
    question: 'Fundamental Duties were added by which Amendment?',
    options: ['42nd Amendment', '44th Amendment', '73rd Amendment', '86th Amendment'],
    correctIndex: 0,
    explanation: 'The 42nd Amendment (1976) added Part IVA containing Fundamental Duties (Article 51A). Originally 10 duties; the 86th Amendment added the 11th duty (education of children).',
    category: 'Duties',
  ),
  const QuizQuestion(
    question: 'Uniform Civil Code is mentioned in which Article?',
    options: ['Article 40', 'Article 42', 'Article 44', 'Article 46'],
    correctIndex: 2,
    explanation: 'Article 44 directs the State to secure a Uniform Civil Code for citizens throughout India. It remains one of the most debated provisions.',
    category: 'DPSP',
  ),

  // Government Structure
  const QuizQuestion(
    question: 'The President of India is elected by:',
    options: ['Direct public vote', 'Members of Parliament only', 'Electoral College of elected members of Parliament and State Legislatures', 'Prime Minister\'s nomination'],
    correctIndex: 2,
    explanation: 'The President is elected by an Electoral College consisting of elected members of both Houses of Parliament and elected members of State Legislative Assemblies.',
    category: 'Government',
  ),
  const QuizQuestion(
    question: 'Money Bills can only be introduced in:',
    options: ['Rajya Sabha', 'Lok Sabha', 'Either House', 'Joint Session'],
    correctIndex: 1,
    explanation: 'Money Bills (Article 110) can ONLY be introduced in Lok Sabha. Rajya Sabha can only suggest amendments, which Lok Sabha may or may not accept.',
    category: 'Government',
  ),
  const QuizQuestion(
    question: 'Minimum age to become President of India is:',
    options: ['25 years', '30 years', '35 years', '40 years'],
    correctIndex: 2,
    explanation: 'Article 58 requires the President to be at least 35 years old, an Indian citizen, and qualified for election to Lok Sabha.',
    category: 'Government',
  ),
  const QuizQuestion(
    question: 'Supreme Court judges retire at the age of:',
    options: ['60', '62', '65', '70'],
    correctIndex: 2,
    explanation: 'Supreme Court judges retire at age 65 (Article 124). High Court judges retire at age 62 (Article 217).',
    category: 'Government',
  ),

  // Amendments
  const QuizQuestion(
    question: 'Anti-Defection Law was introduced by which Amendment?',
    options: ['42nd', '44th', '52nd', '61st'],
    correctIndex: 2,
    explanation: 'The 52nd Amendment (1985) added the Tenth Schedule (Anti-Defection Law) to disqualify legislators who defect from their party.',
    category: 'Amendments',
  ),
  const QuizQuestion(
    question: 'Voting age was reduced from 21 to 18 by which Amendment?',
    options: ['44th', '52nd', '61st', '73rd'],
    correctIndex: 2,
    explanation: 'The 61st Amendment (1989) reduced the voting age from 21 to 18 years, giving millions more young Indians the right to vote.',
    category: 'Amendments',
  ),
  const QuizQuestion(
    question: 'Panchayati Raj was given constitutional status by:',
    options: ['42nd Amendment', '73rd Amendment', '74th Amendment', '86th Amendment'],
    correctIndex: 1,
    explanation: 'The 73rd Amendment (1992) added Part IX and gave constitutional status to Panchayati Raj institutions with three-tier local governance.',
    category: 'Amendments',
  ),
  const QuizQuestion(
    question: 'GST was introduced by which Amendment?',
    options: ['100th', '101st', '103rd', '104th'],
    correctIndex: 1,
    explanation: 'The 101st Amendment (2016) introduced GST (Goods and Services Tax), creating "One Nation, One Tax" and establishing the GST Council.',
    category: 'Amendments',
  ),

  // Laws
  const QuizQuestion(
    question: 'The RTI Act requires government to respond within:',
    options: ['7 days', '15 days', '30 days', '60 days'],
    correctIndex: 2,
    explanation: 'Under Section 7 of the RTI Act 2005, the Public Information Officer must respond within 30 days. For life and liberty matters, it\'s 48 hours.',
    category: 'Laws',
  ),
  const QuizQuestion(
    question: 'Section 66A of the IT Act was struck down by the Supreme Court in:',
    options: ['Shreya Singhal v. UOI', 'Kesavananda Bharati v. State of Kerala', 'Vishaka v. State of Rajasthan', 'Maneka Gandhi v. UOI'],
    correctIndex: 0,
    explanation: 'In Shreya Singhal v. Union of India (2015), the Supreme Court struck down Section 66A as unconstitutional for violating free speech (Article 19).',
    category: 'Laws',
  ),
  const QuizQuestion(
    question: 'The Bharatiya Nyaya Sanhita (BNS) replaced:',
    options: ['CrPC', 'Indian Penal Code', 'Indian Evidence Act', 'RTI Act'],
    correctIndex: 1,
    explanation: 'BNS 2023 replaced the Indian Penal Code (IPC) 1860 from July 1, 2024, as part of India\'s new criminal law framework.',
    category: 'Laws',
  ),
  const QuizQuestion(
    question: 'Maximum penalty for data breach under the Digital Personal Data Protection Act 2023 is:',
    options: ['₹10 crore', '₹50 crore', '₹100 crore', '₹250 crore'],
    correctIndex: 3,
    explanation: 'Section 33 of DPDP Act 2023 provides for penalties up to ₹250 crore per instance of significant data breach.',
    category: 'Laws',
  ),

  // Landmark Cases
  const QuizQuestion(
    question: 'The "Basic Structure" doctrine was established in:',
    options: ['Golaknath case (1967)', 'Kesavananda Bharati case (1973)', 'Minerva Mills case (1980)', 'Maneka Gandhi case (1978)'],
    correctIndex: 1,
    explanation: 'In Kesavananda Bharati v. State of Kerala (1973), the Supreme Court ruled that Parliament cannot alter the "basic structure" of the Constitution through amendments.',
    category: 'Landmark Cases',
  ),
  const QuizQuestion(
    question: 'Right to Privacy was declared a Fundamental Right in:',
    options: ['K.S. Puttaswamy v. UOI (2017)', 'Vishaka v. State of Rajasthan (1997)', 'Navtej Johar v. UOI (2018)', 'Shreya Singhal v. UOI (2015)'],
    correctIndex: 0,
    explanation: 'In Justice K.S. Puttaswamy v. Union of India (2017), a nine-judge bench unanimously declared Right to Privacy as a Fundamental Right under Article 21.',
    category: 'Landmark Cases',
  ),

  // Miscellaneous
  const QuizQuestion(
    question: 'Total number of Schedules in the Indian Constitution:',
    options: ['8', '10', '12', '14'],
    correctIndex: 2,
    explanation: 'The Constitution has 12 Schedules covering states/territories, oaths, salaries, subjects in three lists, scheduled areas, languages, anti-defection law, and panchayat/municipality subjects.',
    category: 'Basics',
  ),
  const QuizQuestion(
    question: 'Which Schedule contains the three lists (Union, State, Concurrent)?',
    options: ['Fifth Schedule', 'Sixth Schedule', 'Seventh Schedule', 'Eighth Schedule'],
    correctIndex: 2,
    explanation: 'The Seventh Schedule contains Union List (97 subjects), State List (66 subjects), and Concurrent List (47 subjects) that define the division of powers between Centre and States.',
    category: 'Basics',
  ),
  const QuizQuestion(
    question: 'How many languages are recognized in the Eighth Schedule?',
    options: ['18', '20', '22', '24'],
    correctIndex: 2,
    explanation: 'The Eighth Schedule recognizes 22 official languages including Hindi, Bengali, Telugu, Marathi, Tamil, Urdu, Gujarati, Kannada, Malayalam, Odia, Punjabi, Assamese, Maithili, Santali, Kashmiri, Nepali, Sindhi, Konkani, Dogri, Manipuri, Bodo, and Sanskrit.',
    category: 'Basics',
  ),
  const QuizQuestion(
    question: 'The concept of "Judicial Review" comes from which country\'s constitution?',
    options: ['UK', 'USA', 'France', 'Germany'],
    correctIndex: 1,
    explanation: 'Judicial Review (power of courts to examine constitutionality of laws) was adopted from the USA, specifically from the case Marbury v. Madison (1803).',
    category: 'Basics',
  ),
  const QuizQuestion(
    question: 'Emergency has been declared in India how many times?',
    options: ['Once', 'Twice', 'Three times', 'Four times'],
    correctIndex: 2,
    explanation: 'National Emergency has been declared three times: 1962 (China war), 1971 (Pakistan war), and 1975 (internal emergency by PM Indira Gandhi).',
    category: 'Government',
  ),
  const QuizQuestion(
    question: 'Consumer complaints for goods worth up to ₹1 crore can be filed at:',
    options: ['Supreme Court', 'High Court', 'District Consumer Commission', 'National Consumer Commission'],
    correctIndex: 2,
    explanation: 'District Consumer Disputes Redressal Commission handles complaints for goods/services worth up to ₹1 crore.',
    category: 'Laws',
  ),
  const QuizQuestion(
    question: 'Blood alcohol limit for driving in India is:',
    options: ['30mg/100ml', '50mg/100ml', '80mg/100ml', 'Zero tolerance'],
    correctIndex: 0,
    explanation: 'Under Section 185 of the Motor Vehicles Act, the blood alcohol limit is 30mg per 100ml of blood - one of the strictest limits in the world.',
    category: 'Laws',
  ),
  const QuizQuestion(
    question: 'Which body was created under Article 280 to recommend tax distribution between Centre and States?',
    options: ['NITI Aayog', 'Finance Commission', 'Planning Commission', 'GST Council'],
    correctIndex: 1,
    explanation: 'Article 280 provides for the Finance Commission, constituted every 5 years by the President to recommend distribution of tax revenues between Centre and States.',
    category: 'Government',
  ),
];
