import '../models/models.dart';

// Preamble of the Constitution of India
const String preambleText = '''
WE, THE PEOPLE OF INDIA, having solemnly resolved to constitute India into a SOVEREIGN SOCIALIST SECULAR DEMOCRATIC REPUBLIC and to secure to all its citizens:

JUSTICE, social, economic and political;

LIBERTY of thought, expression, belief, faith and worship;

EQUALITY of status and of opportunity;

and to promote among them all

FRATERNITY assuring the dignity of the individual and the unity and integrity of the Nation;

IN OUR CONSTITUENT ASSEMBLY this twenty-sixth day of November, 1949, do HEREBY ADOPT, ENACT AND GIVE TO OURSELVES THIS CONSTITUTION.
''';

const String preambleExplanation = '''
The Preamble is the introduction and soul of the Indian Constitution. It declares:

• Sovereign - India is free from external control and makes its own decisions.
• Socialist - The state works to reduce inequality and ensure wealth is distributed fairly (added by 42nd Amendment, 1976).
• Secular - The state treats all religions equally with no official religion (added by 42nd Amendment, 1976).
• Democratic - Power belongs to the people through elected representatives.
• Republic - The head of state (President) is elected, not hereditary.

The four pillars it promises:
1. Justice - Social, economic, and political fairness for all.
2. Liberty - Freedom to think, speak, believe, and worship.
3. Equality - Equal status and opportunities for every citizen.
4. Fraternity - Brotherhood that ensures individual dignity and national unity.
''';

// Constitution Parts with key articles
final List<ConstitutionPart> constitutionParts = [
  ConstitutionPart(
    partNumber: 'Part I',
    title: 'The Union and its Territory',
    articleRange: 'Articles 1–4',
    summary:
        'Defines India as a "Union of States", lists the states and union territories, and provides for admission/establishment of new states.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '1',
        title: 'Name and territory of the Union',
        description:
            'India, that is Bharat, shall be a Union of States. The territory of India shall comprise the territories of the States, the Union territories, and any territory that may be acquired.',
        simpleExplanation:
            'India is officially called both "India" and "Bharat." It is a union of all states and union territories. The word "Union" means states cannot leave India - it is indestructible.',
        part: 'Part I',
        partTitle: 'The Union and its Territory',
        category: 'Territory',
        keywords: ['union', 'states', 'territory', 'bharat'],
      ),
      const ConstitutionArticle(
        articleNumber: '2',
        title: 'Admission or establishment of new States',
        description:
            'Parliament may by law admit into the Union, or establish, new States on such terms and conditions as it thinks fit.',
        simpleExplanation:
            'Parliament can create new states or admit new territories into India. For example, Sikkim was admitted as a state in 1975.',
        part: 'Part I',
        partTitle: 'The Union and its Territory',
        category: 'Territory',
        keywords: ['new states', 'parliament', 'admission'],
      ),
      const ConstitutionArticle(
        articleNumber: '3',
        title: 'Formation of new States and alteration of boundaries',
        description:
            'Parliament may by law form a new State by separation of territory from any State or by uniting two or more States, increase or diminish the area of any State, and alter the name of any State.',
        simpleExplanation:
            'Parliament can reorganize states - split them, merge them, change their boundaries, or rename them. This is how Telangana was carved out of Andhra Pradesh in 2014.',
        part: 'Part I',
        partTitle: 'The Union and its Territory',
        category: 'Territory',
        keywords: ['formation', 'boundaries', 'reorganization'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part II',
    title: 'Citizenship',
    articleRange: 'Articles 5–11',
    summary:
        'Defines who is a citizen of India at the commencement of the Constitution and empowers Parliament to make laws regarding citizenship.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '5',
        title: 'Citizenship at the commencement of the Constitution',
        description:
            'At the commencement of this Constitution, every person who has his domicile in the territory of India and who was born in India, or either of whose parents was born in India, or who has been ordinarily resident in India for not less than five years, shall be a citizen of India.',
        simpleExplanation:
            'When the Constitution started (26 Jan 1950), anyone born in India or whose parents were born in India, or who had lived in India for 5+ years, became an Indian citizen.',
        part: 'Part II',
        partTitle: 'Citizenship',
        category: 'Citizenship',
        keywords: ['citizen', 'birth', 'domicile'],
      ),
      const ConstitutionArticle(
        articleNumber: '11',
        title: 'Parliament to regulate citizenship by law',
        description:
            'Nothing in the foregoing provisions of this Part shall derogate from the power of Parliament to make any provision with respect to the acquisition and termination of citizenship.',
        simpleExplanation:
            'Parliament has full power to make laws about how citizenship is gained or lost. This is why we have the Citizenship Act, 1955 and its amendments.',
        part: 'Part II',
        partTitle: 'Citizenship',
        category: 'Citizenship',
        keywords: ['parliament', 'citizenship act', 'law'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part III',
    title: 'Fundamental Rights',
    articleRange: 'Articles 12–35',
    summary:
        'The cornerstone of Indian democracy. Guarantees six categories of rights to every citizen that even Parliament cannot easily take away.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '14',
        title: 'Equality before law',
        description:
            'The State shall not deny to any person equality before the law or the equal protection of the laws within the territory of India.',
        simpleExplanation:
            'Everyone is equal in the eyes of law - from the Prime Minister to a common citizen. No one is above the law. The state must treat everyone fairly.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Equality',
        keywords: ['equality', 'law', 'equal protection'],
      ),
      const ConstitutionArticle(
        articleNumber: '15',
        title: 'Prohibition of discrimination',
        description:
            'The State shall not discriminate against any citizen on grounds only of religion, race, caste, sex, place of birth or any of them.',
        simpleExplanation:
            'The government cannot discriminate against you because of your religion, race, caste, gender, or birthplace. However, the state CAN make special provisions for women, children, and backward classes.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Equality',
        keywords: ['discrimination', 'caste', 'religion', 'gender', 'reservation'],
      ),
      const ConstitutionArticle(
        articleNumber: '16',
        title: 'Equality of opportunity in public employment',
        description:
            'There shall be equality of opportunity for all citizens in matters relating to employment or appointment to any office under the State.',
        simpleExplanation:
            'Every citizen has equal right to government jobs. No discrimination in hiring. However, reservations for backward classes, SC/ST are allowed as special provision.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Equality',
        keywords: ['employment', 'reservation', 'government jobs'],
      ),
      const ConstitutionArticle(
        articleNumber: '17',
        title: 'Abolition of Untouchability',
        description:
            'Untouchability is abolished and its practice in any form is forbidden. The enforcement of any disability arising out of Untouchability shall be an offence punishable in accordance with law.',
        simpleExplanation:
            'Untouchability is completely banned. Practicing it in any form is a crime. The Protection of Civil Rights Act, 1955 provides punishment for it.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Equality',
        keywords: ['untouchability', 'abolished', 'caste discrimination'],
      ),
      const ConstitutionArticle(
        articleNumber: '18',
        title: 'Abolition of titles',
        description:
            'No title, not being a military or academic distinction, shall be conferred by the State. No citizen shall accept any title from any foreign State.',
        simpleExplanation:
            'The government cannot give titles like "Sir" or "Lord." Citizens cannot accept titles from foreign countries. However, Bharat Ratna and Padma awards are NOT titles - they are honors.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Equality',
        keywords: ['titles', 'bharat ratna', 'honours'],
      ),
      const ConstitutionArticle(
        articleNumber: '19',
        title: 'Protection of certain rights regarding freedom',
        description:
            'All citizens shall have the right to: (a) freedom of speech and expression; (b) assemble peaceably without arms; (c) form associations or unions; (d) move freely throughout India; (e) reside and settle anywhere in India; (f) practice any profession or carry on any occupation, trade or business.',
        simpleExplanation:
            'You have 6 freedoms: speak freely, gather peacefully, form groups, travel anywhere in India, live anywhere in India, and do any job or business. BUT these are not absolute - reasonable restrictions can be placed for national security, public order, etc.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Freedom',
        keywords: ['speech', 'expression', 'assembly', 'movement', 'profession', 'freedom'],
      ),
      const ConstitutionArticle(
        articleNumber: '20',
        title: 'Protection in respect of conviction for offences',
        description:
            'No person shall be convicted except for violation of a law in force at the time. No person shall be punished for the same offence more than once. No accused person shall be compelled to be a witness against himself.',
        simpleExplanation:
            'Three protections: (1) You can only be punished under a law that existed when you did the act (no retroactive punishment). (2) You cannot be punished twice for the same crime. (3) You cannot be forced to confess or testify against yourself.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Freedom',
        keywords: ['conviction', 'double jeopardy', 'self-incrimination'],
      ),
      const ConstitutionArticle(
        articleNumber: '21',
        title: 'Protection of life and personal liberty',
        description:
            'No person shall be deprived of his life or personal liberty except according to procedure established by law.',
        simpleExplanation:
            'The most important fundamental right. Your life and freedom cannot be taken away arbitrarily. Over the years, the Supreme Court has expanded this to include: right to live with dignity, right to privacy, right to clean environment, right to livelihood, right to education, right to health, right to sleep, and right to shelter.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Freedom',
        keywords: ['life', 'liberty', 'dignity', 'privacy', 'right to life'],
      ),
      const ConstitutionArticle(
        articleNumber: '21A',
        title: 'Right to education',
        description:
            'The State shall provide free and compulsory education to all children of the age of six to fourteen years in such manner as the State may determine.',
        simpleExplanation:
            'Every child between 6-14 years has the fundamental right to free education. Added by the 86th Amendment (2002). The RTE Act 2009 implements this right.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Freedom',
        keywords: ['education', 'free', 'compulsory', 'children', 'RTE'],
      ),
      const ConstitutionArticle(
        articleNumber: '22',
        title: 'Protection against arrest and detention',
        description:
            'No person who is arrested shall be detained without being informed of the grounds for arrest. Arrested person has right to consult and be defended by a legal practitioner. Must be produced before a magistrate within 24 hours.',
        simpleExplanation:
            'If you are arrested: (1) Police MUST tell you why. (2) You can call a lawyer immediately. (3) You must be taken to a judge within 24 hours. These rights protect you from arbitrary police action.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Freedom',
        keywords: ['arrest', 'detention', 'lawyer', 'magistrate', '24 hours'],
      ),
      const ConstitutionArticle(
        articleNumber: '23',
        title: 'Prohibition of traffic in human beings and forced labour',
        description:
            'Traffic in human beings and begar and other similar forms of forced labour are prohibited and any contravention shall be an offence punishable in accordance with law.',
        simpleExplanation:
            'Human trafficking, bonded labour, and forced labour are completely banned. Even the government cannot force you to work without payment (except military conscription in emergencies).',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right against Exploitation',
        keywords: ['trafficking', 'forced labour', 'bonded labour', 'begar'],
      ),
      const ConstitutionArticle(
        articleNumber: '24',
        title: 'Prohibition of employment of children in factories',
        description:
            'No child below the age of fourteen years shall be employed to work in any factory or mine or engaged in any other hazardous employment.',
        simpleExplanation:
            'Children under 14 cannot work in factories, mines, or any dangerous jobs. The Child Labour Act strengthens this by regulating conditions where children can work at all.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right against Exploitation',
        keywords: ['child labour', 'factory', 'mine', 'hazardous'],
      ),
      const ConstitutionArticle(
        articleNumber: '25',
        title: 'Freedom of conscience and free profession, practice and propagation of religion',
        description:
            'Subject to public order, morality and health, all persons are equally entitled to freedom of conscience and the right freely to profess, practise and propagate religion.',
        simpleExplanation:
            'You can follow any religion, practice it, and even spread it to others - as long as it doesn\'t disturb public order or health. This right belongs to ALL persons in India, not just citizens.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Freedom of Religion',
        keywords: ['religion', 'conscience', 'propagation', 'practice'],
      ),
      const ConstitutionArticle(
        articleNumber: '29',
        title: 'Protection of interests of minorities',
        description:
            'Any section of the citizens having a distinct language, script or culture shall have the right to conserve the same.',
        simpleExplanation:
            'If you belong to a community with its own language or culture, you have the right to preserve it. The government cannot force you to abandon your cultural identity.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Cultural and Educational Rights',
        keywords: ['minorities', 'language', 'culture', 'conservation'],
      ),
      const ConstitutionArticle(
        articleNumber: '30',
        title: 'Right of minorities to establish educational institutions',
        description:
            'All minorities, whether based on religion or language, shall have the right to establish and administer educational institutions of their choice.',
        simpleExplanation:
            'Religious and linguistic minorities can set up and run their own schools and colleges. The government cannot discriminate against them in granting aid.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Cultural and Educational Rights',
        keywords: ['minorities', 'education', 'institutions'],
      ),
      const ConstitutionArticle(
        articleNumber: '32',
        title: 'Right to Constitutional Remedies',
        description:
            'The right to move the Supreme Court by appropriate proceedings for the enforcement of the rights conferred by this Part is guaranteed. The Supreme Court shall have power to issue writs.',
        simpleExplanation:
            'Dr. Ambedkar called this the "heart and soul" of the Constitution. If any fundamental right is violated, you can directly go to the Supreme Court. The Court can issue 5 types of writs: Habeas Corpus, Mandamus, Prohibition, Certiorari, and Quo Warranto.',
        part: 'Part III',
        partTitle: 'Fundamental Rights',
        category: 'Right to Constitutional Remedies',
        keywords: ['supreme court', 'writ', 'habeas corpus', 'mandamus', 'enforcement'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part IV',
    title: 'Directive Principles of State Policy',
    articleRange: 'Articles 36–51',
    summary:
        'Guidelines for the government to create laws and policies. Not enforceable by courts, but fundamental in governance. These represent the social and economic goals of the Constitution.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '38',
        title: 'State to secure a social order for promotion of welfare',
        description:
            'The State shall strive to promote the welfare of the people by securing a social order in which justice, social, economic and political, shall inform all the institutions of the national life.',
        simpleExplanation:
            'The government should work towards creating a fair society where social, economic, and political justice exists for everyone. This is the guiding principle behind welfare schemes.',
        part: 'Part IV',
        partTitle: 'Directive Principles of State Policy',
        category: 'DPSP - Welfare',
        keywords: ['welfare', 'social order', 'justice'],
      ),
      const ConstitutionArticle(
        articleNumber: '39',
        title: 'Certain principles of policy to be followed by the State',
        description:
            'The State shall direct its policy towards securing: adequate means of livelihood for all citizens; equitable distribution of material resources; prevention of concentration of wealth; equal pay for equal work for both men and women.',
        simpleExplanation:
            'The government should ensure: everyone can earn a living, wealth is not concentrated in few hands, and men and women get equal pay for equal work. This is why we have minimum wage laws and anti-monopoly regulations.',
        part: 'Part IV',
        partTitle: 'Directive Principles of State Policy',
        category: 'DPSP - Economic',
        keywords: ['livelihood', 'equal pay', 'wealth distribution'],
      ),
      const ConstitutionArticle(
        articleNumber: '40',
        title: 'Organisation of village panchayats',
        description:
            'The State shall take steps to organise village panchayats and endow them with such powers and authority as may be necessary to enable them to function as units of self-government.',
        simpleExplanation:
            'Villages should have their own elected panchayats with real power to govern locally. This was strengthened by the 73rd Amendment (1992) which made Panchayati Raj a constitutional reality.',
        part: 'Part IV',
        partTitle: 'Directive Principles of State Policy',
        category: 'DPSP - Governance',
        keywords: ['panchayat', 'village', 'self-government', 'local governance'],
      ),
      const ConstitutionArticle(
        articleNumber: '41',
        title: 'Right to work, education and public assistance',
        description:
            'The State shall, within the limits of its economic capacity, make effective provision for securing the right to work, to education and to public assistance in cases of unemployment, old age, sickness and disablement.',
        simpleExplanation:
            'The government should try to provide: jobs for everyone, education for all, and financial help for the unemployed, elderly, sick, and disabled. MGNREGA and various pension schemes are based on this principle.',
        part: 'Part IV',
        partTitle: 'Directive Principles of State Policy',
        category: 'DPSP - Social',
        keywords: ['work', 'education', 'public assistance', 'MGNREGA'],
      ),
      const ConstitutionArticle(
        articleNumber: '44',
        title: 'Uniform civil code',
        description:
            'The State shall endeavour to secure for the citizens a uniform civil code throughout the territory of India.',
        simpleExplanation:
            'The government should work towards one common set of personal laws (marriage, divorce, inheritance) for ALL citizens regardless of religion. Currently, different religions follow different personal laws. This remains one of the most debated provisions.',
        part: 'Part IV',
        partTitle: 'Directive Principles of State Policy',
        category: 'DPSP - Social',
        keywords: ['uniform civil code', 'personal law', 'UCC'],
      ),
      const ConstitutionArticle(
        articleNumber: '46',
        title: 'Promotion of educational and economic interests of SC/ST',
        description:
            'The State shall promote with special care the educational and economic interests of the weaker sections, in particular of the Scheduled Castes and the Scheduled Tribes, and shall protect them from social injustice and all forms of exploitation.',
        simpleExplanation:
            'The government must specially help SC/ST communities in education and economics, and protect them from social injustice. This is the constitutional basis for reservation policies and the SC/ST Atrocities Act.',
        part: 'Part IV',
        partTitle: 'Directive Principles of State Policy',
        category: 'DPSP - Social Justice',
        keywords: ['SC', 'ST', 'reservation', 'education', 'exploitation'],
      ),
      const ConstitutionArticle(
        articleNumber: '48A',
        title: 'Protection and improvement of environment',
        description:
            'The State shall endeavour to protect and improve the environment and to safeguard the forests and wild life of the country.',
        simpleExplanation:
            'The government must protect the environment, forests, and wildlife. Added by the 42nd Amendment (1976). This is why we have the Environment Protection Act, Wildlife Protection Act, and Forest Conservation Act.',
        part: 'Part IV',
        partTitle: 'Directive Principles of State Policy',
        category: 'DPSP - Environment',
        keywords: ['environment', 'forests', 'wildlife', 'protection'],
      ),
      const ConstitutionArticle(
        articleNumber: '51',
        title: 'Promotion of international peace and security',
        description:
            'The State shall endeavour to promote international peace and security, maintain just and honourable relations between nations, and encourage settlement of international disputes by arbitration.',
        simpleExplanation:
            'India should promote world peace, maintain good relations with other countries, respect international law, and resolve disputes through dialogue, not war. This guides India\'s foreign policy.',
        part: 'Part IV',
        partTitle: 'Directive Principles of State Policy',
        category: 'DPSP - International',
        keywords: ['peace', 'international', 'arbitration', 'foreign policy'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part IVA',
    title: 'Fundamental Duties',
    articleRange: 'Article 51A',
    summary:
        'Added by the 42nd Amendment (1976). Lists 11 duties every Indian citizen should follow. Not enforceable by courts but morally binding.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '51A',
        title: 'Fundamental Duties of Citizens',
        description:
            'It shall be the duty of every citizen of India to abide by the Constitution, cherish its ideals and institutions, the National Flag and the National Anthem.',
        simpleExplanation:
            'Every citizen has 11 duties including: respect the Constitution, flag, and anthem; cherish the freedom struggle ideals; protect sovereignty and unity; defend the country; promote harmony; preserve composite culture; protect environment; develop scientific temper; safeguard public property; strive for excellence; provide education to children (6-14 years, added by 86th Amendment).',
        part: 'Part IVA',
        partTitle: 'Fundamental Duties',
        category: 'Duties',
        keywords: ['duties', 'citizen', 'flag', 'anthem', 'harmony'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part V',
    title: 'The Union',
    articleRange: 'Articles 52–151',
    summary:
        'Covers the entire structure of the Central Government - the President, Vice President, Prime Minister, Council of Ministers, Parliament, Supreme Court, and Comptroller & Auditor General.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '52',
        title: 'The President of India',
        description:
            'There shall be a President of India.',
        simpleExplanation:
            'India must have a President who is the head of state and supreme commander of the armed forces. The President is elected by an electoral college consisting of elected members of both Houses of Parliament and State Legislatures.',
        part: 'Part V',
        partTitle: 'The Union',
        category: 'Executive',
        keywords: ['president', 'head of state', 'electoral college'],
      ),
      const ConstitutionArticle(
        articleNumber: '74',
        title: 'Council of Ministers to aid and advise President',
        description:
            'There shall be a Council of Ministers with the Prime Minister at the head to aid and advise the President who shall, in the exercise of his functions, act in accordance with such advice.',
        simpleExplanation:
            'The President must act on the advice of the Prime Minister and Council of Ministers. This makes India a parliamentary democracy where real power lies with the PM, not the President. The 42nd and 44th Amendments made this advice binding.',
        part: 'Part V',
        partTitle: 'The Union',
        category: 'Executive',
        keywords: ['prime minister', 'council of ministers', 'advice', 'parliamentary'],
      ),
      const ConstitutionArticle(
        articleNumber: '110',
        title: 'Definition of Money Bills',
        description:
            'A Bill shall be deemed to be a Money Bill if it contains only provisions dealing with taxation, government borrowing, Consolidated Fund, Contingency Fund, or any matter incidental to these.',
        simpleExplanation:
            'Money Bills deal with taxes, government spending, and borrowing. They can ONLY be introduced in Lok Sabha. Rajya Sabha can suggest changes but Lok Sabha has the final say. The Speaker decides whether a bill is a Money Bill or not.',
        part: 'Part V',
        partTitle: 'The Union',
        category: 'Legislature',
        keywords: ['money bill', 'lok sabha', 'rajya sabha', 'taxation'],
      ),
      const ConstitutionArticle(
        articleNumber: '124',
        title: 'Establishment and constitution of Supreme Court',
        description:
            'There shall be a Supreme Court of India consisting of a Chief Justice of India and such number of other Judges as Parliament may prescribe.',
        simpleExplanation:
            'The Supreme Court is the highest court. The Chief Justice is appointed by the President (through collegium system). Judges serve until age 65. The Court has original, appellate, and advisory jurisdiction. Its decisions are binding on all courts in India.',
        part: 'Part V',
        partTitle: 'The Union',
        category: 'Judiciary',
        keywords: ['supreme court', 'chief justice', 'collegium', 'judiciary'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part VI',
    title: 'The States',
    articleRange: 'Articles 152–237',
    summary:
        'Mirrors Part V but for state governments. Covers the Governor, Chief Minister, State Legislature, and High Courts.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '153',
        title: 'Governors of States',
        description:
            'There shall be a Governor for each State. One person can be appointed as Governor for two or more States.',
        simpleExplanation:
            'Every state has a Governor appointed by the President (on the advice of the Central Government). The Governor is the constitutional head of the state, similar to how the President is for the Centre. One person can govern multiple states.',
        part: 'Part VI',
        partTitle: 'The States',
        category: 'State Executive',
        keywords: ['governor', 'state', 'appointment', 'president'],
      ),
      const ConstitutionArticle(
        articleNumber: '214',
        title: 'High Courts for States',
        description:
            'There shall be a High Court for each State.',
        simpleExplanation:
            'Every state must have a High Court. It is the highest court at the state level and has power to issue writs for enforcing fundamental rights (Article 226). High Court judges are appointed through the collegium system and serve until age 62.',
        part: 'Part VI',
        partTitle: 'The States',
        category: 'State Judiciary',
        keywords: ['high court', 'state', 'writ', 'judiciary'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part IX',
    title: 'The Panchayats',
    articleRange: 'Articles 243–243O',
    summary:
        'Added by the 73rd Amendment (1992). Provides constitutional status to Panchayati Raj institutions - the three-tier system of local self-government in rural areas.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '243B',
        title: 'Constitution of Panchayats',
        description:
            'There shall be constituted in every State, Panchayats at the village, intermediate and district levels.',
        simpleExplanation:
            'Every state must have a three-level Panchayat system: Gram Panchayat (village), Panchayat Samiti (block), and Zila Parishad (district). Elections are held every 5 years. One-third seats are reserved for women. Seats are also reserved for SC/ST in proportion to their population.',
        part: 'Part IX',
        partTitle: 'The Panchayats',
        category: 'Local Government',
        keywords: ['panchayat', 'gram', 'zila parishad', 'local government', '73rd amendment'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part IXA',
    title: 'The Municipalities',
    articleRange: 'Articles 243P–243ZG',
    summary:
        'Added by the 74th Amendment (1992). Provides constitutional status to urban local bodies - Nagar Panchayats, Municipal Councils, and Municipal Corporations.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '243Q',
        title: 'Constitution of Municipalities',
        description:
            'There shall be constituted in every State - a Nagar Panchayat for a transitional area, a Municipal Council for a smaller urban area, and a Municipal Corporation for a larger urban area.',
        simpleExplanation:
            'Cities and towns must have elected local bodies: Nagar Panchayat (small towns), Municipal Council (medium cities), and Municipal Corporation (big cities like Delhi, Mumbai). They handle local services like water, roads, sanitation, and planning.',
        part: 'Part IXA',
        partTitle: 'The Municipalities',
        category: 'Local Government',
        keywords: ['municipality', 'municipal corporation', 'nagar panchayat', '74th amendment'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part XI',
    title: 'Relations between the Union and the States',
    articleRange: 'Articles 245–263',
    summary:
        'Defines the division of powers between Centre and States through three lists: Union List, State List, and Concurrent List.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '246',
        title: 'Subject-matter of laws made by Parliament and State Legislatures',
        description:
            'Parliament has exclusive power to make laws on subjects in the Union List. State Legislature has exclusive power on State List subjects. Both can make laws on Concurrent List subjects.',
        simpleExplanation:
            'Powers are divided: Union List (97 subjects like defence, foreign affairs - only Parliament); State List (66 subjects like police, health - only State); Concurrent List (47 subjects like education, marriage - both can make laws, but Centre\'s law prevails if there\'s a conflict).',
        part: 'Part XI',
        partTitle: 'Relations between Union and States',
        category: 'Federal Structure',
        keywords: ['union list', 'state list', 'concurrent list', 'federal', 'division of powers'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part XII',
    title: 'Finance, Property, Contracts and Suits',
    articleRange: 'Articles 264–300A',
    summary:
        'Covers taxation powers, finance commission, Consolidated Fund, GST Council, and the right to property (now a legal right, not fundamental).',
    articles: [
      const ConstitutionArticle(
        articleNumber: '280',
        title: 'Finance Commission',
        description:
            'The President shall constitute a Finance Commission every five years to recommend the distribution of tax revenues between the Centre and States.',
        simpleExplanation:
            'Every 5 years, a Finance Commission decides how tax money collected by the Centre should be shared with states. This ensures states get their fair share of national revenue. The current 16th Finance Commission was constituted in 2024.',
        part: 'Part XII',
        partTitle: 'Finance, Property, Contracts and Suits',
        category: 'Finance',
        keywords: ['finance commission', 'tax', 'revenue sharing', 'centre-state'],
      ),
      const ConstitutionArticle(
        articleNumber: '300A',
        title: 'Right to Property',
        description:
            'No person shall be deprived of his property save by authority of law.',
        simpleExplanation:
            'Your property cannot be taken without a law authorizing it. Originally a Fundamental Right (Article 31), it was downgraded to a legal right by the 44th Amendment (1978). The government can still acquire your property for public purposes but must compensate you.',
        part: 'Part XII',
        partTitle: 'Finance, Property, Contracts and Suits',
        category: 'Property',
        keywords: ['property', 'acquisition', 'compensation', '44th amendment'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part XVIII',
    title: 'Emergency Provisions',
    articleRange: 'Articles 352–360',
    summary:
        'Three types of emergencies: National Emergency (war/external aggression), President\'s Rule in states, and Financial Emergency.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '352',
        title: 'Proclamation of National Emergency',
        description:
            'If the President is satisfied that a grave emergency exists whereby the security of India or any part thereof is threatened by war, external aggression, or armed rebellion, he may proclaim Emergency.',
        simpleExplanation:
            'The President can declare National Emergency if India faces war, attack from outside, or armed rebellion. During this, fundamental rights (except Articles 20 and 21) can be suspended. Has been used three times: 1962 (China war), 1971 (Pakistan war), and 1975 (internal emergency by Indira Gandhi). The 44th Amendment added safeguards to prevent misuse.',
        part: 'Part XVIII',
        partTitle: 'Emergency Provisions',
        category: 'Emergency',
        keywords: ['emergency', 'national', 'war', '1975', 'fundamental rights suspended'],
      ),
      const ConstitutionArticle(
        articleNumber: '356',
        title: 'President\'s Rule in States',
        description:
            'If the President is satisfied that the government of the State cannot be carried on in accordance with the provisions of the Constitution, he may assume all functions of the State Government.',
        simpleExplanation:
            'If a state government fails or collapses, the President can take over and run the state directly (through the Governor). This is called "President\'s Rule." It has been used over 100 times. The S.R. Bommai case (1994) established that the President\'s decision can be reviewed by the courts.',
        part: 'Part XVIII',
        partTitle: 'Emergency Provisions',
        category: 'Emergency',
        keywords: ['president rule', 'state', 'failure', 'governor', 'Bommai'],
      ),
    ],
  ),
  ConstitutionPart(
    partNumber: 'Part XX',
    title: 'Amendment of the Constitution',
    articleRange: 'Article 368',
    summary:
        'Defines how the Constitution can be amended. Parliament can amend most provisions by special majority. Some provisions need ratification by states.',
    articles: [
      const ConstitutionArticle(
        articleNumber: '368',
        title: 'Power of Parliament to amend the Constitution',
        description:
            'Parliament may amend any provision of this Constitution by way of addition, variation, or repeal. A Bill for amendment must be passed by each House with a special majority.',
        simpleExplanation:
            'The Constitution can be changed by Parliament through special majority (2/3 of members present AND voting + majority of total membership). Some amendments also need approval by half the state legislatures. The Supreme Court held in Kesavananda Bharati case (1973) that Parliament CANNOT alter the "basic structure" of the Constitution.',
        part: 'Part XX',
        partTitle: 'Amendment of the Constitution',
        category: 'Amendment',
        keywords: ['amendment', 'special majority', 'basic structure', 'Kesavananda'],
      ),
    ],
  ),
];

// Key Amendments
final List<Amendment> keyAmendments = [
  const Amendment(
    number: 1,
    year: '1951',
    description:
        'Added Ninth Schedule to protect land reform laws from judicial review. Added reasonable restrictions on freedom of speech.',
    impact:
        'Allowed the government to implement land reforms without courts striking them down. Limited free speech for public order, friendly relations with foreign states, and incitement to offense.',
    articlesAffected: ['15', '19', '85', '87', '174', '176', '341', '342', '372A', '376'],
  ),
  const Amendment(
    number: 7,
    year: '1956',
    description:
        'Reorganized states on linguistic basis. Replaced Part A, B, C, D states with a uniform system of States and Union Territories.',
    impact:
        'Created the current state structure of India. States were reorganized based on language (e.g., Andhra Pradesh for Telugu speakers, Tamil Nadu for Tamil speakers). Abolished the earlier classification of states.',
    articlesAffected: ['1', '3', '49', '80', '81', '82', '131', '153', '158', '168'],
  ),
  const Amendment(
    number: 42,
    year: '1976',
    description:
        'The most controversial amendment, passed during Emergency. Added "Socialist," "Secular," and "Integrity" to the Preamble. Added Fundamental Duties. Curtailed judicial review.',
    impact:
        'Called the "Mini-Constitution" for the sheer number of changes. Made India officially socialist and secular. Added Part IVA (Fundamental Duties). Gave Parliament power to amend any part of the Constitution. Many provisions were later reversed by the 43rd and 44th Amendments.',
    articlesAffected: ['31C', '39', '43A', '48A', '51A', '74', '77', '81', '100', '102'],
  ),
  const Amendment(
    number: 44,
    year: '1978',
    description:
        'Reversed the most damaging provisions of the 42nd Amendment. Removed Right to Property from Fundamental Rights. Added safeguards against Emergency misuse.',
    impact:
        'Made it harder to declare Emergency - requires written advice of Cabinet (not just PM), must be approved by Parliament within 1 month. Right to Property moved from Article 31 to Article 300A (legal right, not fundamental). Restored judicial review. Strengthened individual liberty.',
    articlesAffected: ['19', '22', '30', '31', '38', '71', '74', '77', '83', '103', '132', '134A', '139A', '150', '166', '170', '172', '192', '194', '217', '225', '226', '227', '228', '300A', '352', '356', '358', '359', '360', '371F'],
  ),
  const Amendment(
    number: 52,
    year: '1985',
    description:
        'Anti-Defection Law. Disqualifies legislators who defect from their party after being elected.',
    impact:
        'Added the Tenth Schedule. If an elected representative switches parties or votes against party whip, they lose their seat. This was meant to prevent the "Aaya Ram Gaya Ram" phenomenon. The decision is made by the Speaker/Chairman.',
    articlesAffected: ['101', '102', '190', '191'],
  ),
  const Amendment(
    number: 61,
    year: '1989',
    description: 'Reduced voting age from 21 to 18 years.',
    impact:
        'Gave millions of young Indians the right to vote. India\'s largest democracy became even more inclusive by allowing 18-year-olds to participate in elections. This brought Indian voting age in line with most democracies worldwide.',
    articlesAffected: ['326'],
  ),
  const Amendment(
    number: 73,
    year: '1992',
    description:
        'Gave constitutional status to Panchayati Raj institutions. Added Part IX.',
    impact:
        'Created a three-tier Panchayat system with elected bodies at village, block, and district levels. Reserved one-third seats for women. Reserved seats for SC/ST. Five-year term with regular elections mandatory. 29 subjects transferred to Panchayats.',
    articlesAffected: ['243', '243A-243O'],
  ),
  const Amendment(
    number: 74,
    year: '1992',
    description:
        'Gave constitutional status to urban local bodies (municipalities). Added Part IXA.',
    impact:
        'Created three types of urban local bodies: Nagar Panchayat, Municipal Council, Municipal Corporation. Reserved one-third seats for women. Regular elections every 5 years mandatory. 18 subjects transferred to municipalities.',
    articlesAffected: ['243P-243ZG'],
  ),
  const Amendment(
    number: 86,
    year: '2002',
    description:
        'Made education a Fundamental Right for children aged 6-14. Added Article 21A.',
    impact:
        'Free and compulsory education for children aged 6-14 became a constitutionally guaranteed right. Led to the Right to Education (RTE) Act, 2009. Added duty to provide education as a Fundamental Duty (51A(k)). Changed Article 45 to focus on early childhood care.',
    articlesAffected: ['21A', '45', '51A'],
  ),
  const Amendment(
    number: 101,
    year: '2016',
    description:
        'Introduced Goods and Services Tax (GST). Unified India\'s indirect tax system.',
    impact:
        'Replaced multiple central and state taxes with one unified GST. Created GST Council (Article 279A) with representation from Centre and all states. Called "One Nation, One Tax." Fundamentally changed India\'s tax structure and made inter-state trade easier.',
    articlesAffected: ['246A', '269A', '279A'],
  ),
  const Amendment(
    number: 103,
    year: '2019',
    description:
        '10% reservation for Economically Weaker Sections (EWS) of society in education and government jobs.',
    impact:
        'Extended reservation benefits to economically weak citizens from general (unreserved) categories. Applied to those with income below ₹8 lakh per year. First time reservation was based purely on economic criteria rather than caste. Upheld by Supreme Court in 2022.',
    articlesAffected: ['15', '16'],
  ),
];

// Fundamental Duties (Article 51A) - expanded list
final List<Map<String, String>> fundamentalDuties = [
  {
    'number': '51A(a)',
    'duty': 'To abide by the Constitution and respect its ideals and institutions, the National Flag and the National Anthem.',
    'explanation': 'Every citizen must follow the Constitution, respect national symbols. Disrespecting the flag or anthem can lead to punishment under the Prevention of Insults to National Honour Act, 1971.',
  },
  {
    'number': '51A(b)',
    'duty': 'To cherish and follow the noble ideals which inspired our national struggle for freedom.',
    'explanation': 'Remember and follow the values of the freedom movement - non-violence, truth, sacrifice, equality, and democracy that leaders like Gandhi, Ambedkar, Nehru, and Bose fought for.',
  },
  {
    'number': '51A(c)',
    'duty': 'To uphold and protect the sovereignty, unity and integrity of India.',
    'explanation': 'Protect India from threats - both external and internal. Do not support separatism or activities that threaten national unity. This is why sedition (now BNS Section 152) is a criminal offense.',
  },
  {
    'number': '51A(d)',
    'duty': 'To defend the country and render national service when called upon to do so.',
    'explanation': 'Be ready to serve the nation if needed - through military service, civil defense, or other forms of national service. India does not have compulsory military service, but this duty means you should be willing.',
  },
  {
    'number': '51A(e)',
    'duty': 'To promote harmony and the spirit of common brotherhood amongst all the people of India transcending religious, linguistic and regional diversities.',
    'explanation': 'Treat everyone as equal regardless of religion, language, or region. Renounce practices that are derogatory to the dignity of women. Build bridges, not walls, between communities.',
  },
  {
    'number': '51A(f)',
    'duty': 'To value and preserve the rich heritage of our composite culture.',
    'explanation': 'India\'s culture is a mix of many traditions. Protect historical monuments, ancient texts, art forms, and cultural practices. This is why we have the Ancient Monuments Act and ASI.',
  },
  {
    'number': '51A(g)',
    'duty': 'To protect and improve the natural environment including forests, lakes, rivers and wild life, and to have compassion for living creatures.',
    'explanation': 'Environmental protection is every citizen\'s duty. Don\'t pollute, plant trees, protect wildlife. This duty is enforced through the Environment Protection Act, Wildlife Protection Act, and NGT.',
  },
  {
    'number': '51A(h)',
    'duty': 'To develop the scientific temper, humanism and the spirit of inquiry and reform.',
    'explanation': 'Think rationally and scientifically. Question superstitions. Support scientific research. This is uniquely Indian - few constitutions in the world include scientific thinking as a citizen\'s duty.',
  },
  {
    'number': '51A(i)',
    'duty': 'To safeguard public property and to abjure violence.',
    'explanation': 'Don\'t damage public property (buses, trains, government buildings) during protests or otherwise. The Prevention of Damage to Public Property Act, 1984 makes this a punishable offense.',
  },
  {
    'number': '51A(j)',
    'duty': 'To strive towards excellence in all spheres of individual and collective activity.',
    'explanation': 'Always try to do your best in education, work, sports, arts, or any field. Continuous improvement helps both the individual and the nation progress.',
  },
  {
    'number': '51A(k)',
    'duty': 'To provide opportunities for education to his child or ward between the age of six and fourteen years.',
    'explanation': 'Added by the 86th Amendment (2002). Parents MUST send children aged 6-14 to school. This corresponds with Article 21A (Right to Education). Failing to educate children is a breach of constitutional duty.',
  },
];
