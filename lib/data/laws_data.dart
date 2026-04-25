import '../models/models.dart';

final List<LawCategory> indianLaws = [
  LawCategory(
    name: 'Bharatiya Nyaya Sanhita (BNS) 2023',
    icon: 'gavel',
    description:
        'Replaced the Indian Penal Code (IPC) from July 1, 2024. The new criminal code of India that defines offenses and prescribes punishments.',
    sections: [
      const LawSection(
        sectionNumber: '100',
        title: 'Murder',
        actName: 'BNS 2023',
        description:
            'Whoever causes death by doing an act with the intention of causing death, or with the intention of causing such bodily injury as is likely to cause death, or with the knowledge that he is likely by such act to cause death, commits the offence of murder.',
        simpleExplanation:
            'If you intentionally kill someone or know your actions will likely kill them, it\'s murder. This replaced IPC Section 302.',
        punishment: 'Death or imprisonment for life, and fine.',
        keywords: ['murder', 'homicide', 'death', 'killing'],
      ),
      const LawSection(
        sectionNumber: '63',
        title: 'Rape',
        actName: 'BNS 2023',
        description:
            'A man commits rape if he has sexual intercourse with a woman against her will, without her consent, or when consent is obtained by deception, fear, or when she is unable to communicate consent.',
        simpleExplanation:
            'Sexual intercourse without free and genuine consent is rape. Replaced IPC Section 375-376. Punishment has been significantly increased.',
        punishment:
            'Rigorous imprisonment not less than 10 years, which may extend to life imprisonment, and fine. For repeat offenders: life imprisonment or death.',
        keywords: ['rape', 'sexual assault', 'consent'],
      ),
      const LawSection(
        sectionNumber: '115',
        title: 'Voluntarily causing hurt',
        actName: 'BNS 2023',
        description:
            'Whoever causes bodily pain, disease or infirmity to any person is said to voluntarily cause hurt.',
        simpleExplanation:
            'If you intentionally hurt someone physically - cause pain, illness, or injury - it\'s a criminal offense. Replaced IPC Section 323.',
        punishment: 'Imprisonment up to 1 year, or fine up to ₹10,000, or both.',
        keywords: ['hurt', 'assault', 'injury', 'pain'],
      ),
      const LawSection(
        sectionNumber: '303',
        title: 'Theft',
        actName: 'BNS 2023',
        description:
            'Whoever, intending to take dishonestly any movable property out of the possession of any person without that person\'s consent, moves that property, commits theft.',
        simpleExplanation:
            'Taking someone\'s things without their permission and with dishonest intention is theft. Replaced IPC Section 378.',
        punishment: 'Imprisonment up to 3 years, or fine, or both.',
        keywords: ['theft', 'stealing', 'property', 'dishonest'],
      ),
      const LawSection(
        sectionNumber: '308',
        title: 'Extortion',
        actName: 'BNS 2023',
        description:
            'Whoever intentionally puts any person in fear of injury and thereby dishonestly induces the person to deliver any property or valuable security commits extortion.',
        simpleExplanation:
            'Threatening someone to give you money or property is extortion. This includes physical threats, threats to reputation, or blackmail. Replaced IPC Section 383.',
        punishment: 'Imprisonment up to 3 years, or fine, or both.',
        keywords: ['extortion', 'blackmail', 'threat', 'coercion'],
      ),
      const LawSection(
        sectionNumber: '318',
        title: 'Cheating',
        actName: 'BNS 2023',
        description:
            'Whoever deceives any person and thereby fraudulently or dishonestly induces the person to deliver property, or to do or omit to do anything which he would not otherwise do, commits cheating.',
        simpleExplanation:
            'Tricking someone into giving you money, property, or doing something through lies is cheating. Covers fraud, scams, and deception. Replaced IPC Section 420.',
        punishment: 'Imprisonment up to 3 years, or fine, or both. If cheating causes damage, up to 7 years.',
        keywords: ['cheating', 'fraud', 'deception', 'scam', '420'],
      ),
      const LawSection(
        sectionNumber: '152',
        title: 'Acts endangering sovereignty, unity and integrity of India',
        actName: 'BNS 2023',
        description:
            'Whoever, purposely or knowingly, by words, signs, or visible representation, excites or attempts to excite secession or armed rebellion or subversive activities, or encourages feelings of separatist activities or endangers sovereignty or unity and integrity of India.',
        simpleExplanation:
            'This replaced the old sedition law (IPC 124A). It\'s narrower - targets acts that endanger sovereignty through armed rebellion or subversive activities. Simply criticizing the government is NOT covered.',
        punishment: 'Imprisonment for life, or up to 7 years, and fine.',
        keywords: ['sedition', 'sovereignty', 'unity', 'rebellion'],
      ),
      const LawSection(
        sectionNumber: '74',
        title: 'Assault on woman with intent to outrage her modesty',
        actName: 'BNS 2023',
        description:
            'Whoever assaults or uses criminal force to any woman, intending to outrage or knowing it to be likely that he will thereby outrage her modesty.',
        simpleExplanation:
            'Any physical act intended to violate a woman\'s modesty - like groping, touching inappropriately, or forcing physical contact - is a crime. Replaced IPC Section 354.',
        punishment: 'Imprisonment not less than 1 year, which may extend to 5 years, and fine.',
        keywords: ['assault', 'woman', 'modesty', 'groping'],
      ),
    ],
  ),
  LawCategory(
    name: 'Bharatiya Nagarik Suraksha Sanhita (BNSS) 2023',
    icon: 'shield',
    description:
        'Replaced the Code of Criminal Procedure (CrPC) from July 1, 2024. Governs how criminal cases are investigated, tried, and resolved.',
    sections: [
      const LawSection(
        sectionNumber: '173',
        title: 'Information to police (FIR)',
        actName: 'BNSS 2023',
        description:
            'Every information relating to the commission of a cognizable offence, if given orally to an officer in charge of a police station, shall be reduced to writing. A copy of the information shall be given free of cost to the informant.',
        simpleExplanation:
            'When you report a cognizable offense (serious crime), police MUST register an FIR. They must give you a free copy. If they refuse, you can complain to the SP or file a complaint with the Magistrate.',
        punishment: 'Police officer refusing to register FIR can face departmental action and prosecution.',
        keywords: ['FIR', 'complaint', 'police', 'report', 'cognizable'],
      ),
      const LawSection(
        sectionNumber: '37',
        title: 'Arrest: When police may arrest without warrant',
        actName: 'BNSS 2023',
        description:
            'Any police officer may, without an order from a Magistrate and without a warrant, arrest any person who commits a cognizable offence in his presence, or against whom a reasonable complaint has been made or credible information has been received.',
        simpleExplanation:
            'Police can arrest you without a warrant only for serious (cognizable) crimes. For minor offenses, they need a warrant from a magistrate. New safeguards: electronic records of arrest, mandatory information to family, and video recording of search and seizure.',
        punishment: '',
        keywords: ['arrest', 'warrant', 'police', 'cognizable'],
      ),
      const LawSection(
        sectionNumber: '187',
        title: 'Zero FIR',
        actName: 'BNSS 2023',
        description:
            'The officer in charge of a police station shall register every information relating to the commission of a cognizable offence, irrespective of the area where the offence is committed.',
        simpleExplanation:
            'You can file an FIR at ANY police station, regardless of where the crime happened. The police station will register it as "Zero FIR" and then transfer it to the correct jurisdiction. This was practice before but is now codified in law.',
        punishment: '',
        keywords: ['zero FIR', 'jurisdiction', 'any police station'],
      ),
      const LawSection(
        sectionNumber: '479',
        title: 'Bail provisions',
        actName: 'BNSS 2023',
        description:
            'Where a person has been detained for a period extending to one-half of the maximum period of imprisonment specified for that offence, he shall be released on bail.',
        simpleExplanation:
            'If you\'ve been in jail awaiting trial for half the maximum punishment period (e.g., 1.5 years if max punishment is 3 years), you MUST be given bail. This prevents under-trial prisoners from spending more time in jail than their actual punishment would be.',
        punishment: '',
        keywords: ['bail', 'under-trial', 'detention', 'release'],
      ),
    ],
  ),
  LawCategory(
    name: 'Right to Information Act (RTI) 2005',
    icon: 'visibility',
    description:
        'Empowers every citizen to seek information from any public authority, promoting transparency and accountability in government.',
    sections: [
      const LawSection(
        sectionNumber: '3',
        title: 'Right to Information',
        actName: 'RTI Act 2005',
        description:
            'Subject to the provisions of this Act, all citizens shall have the right to information.',
        simpleExplanation:
            'Every Indian citizen has the right to ask for any information from any government body. You can ask about government decisions, spending, policies, files - anything. The government must reply within 30 days.',
        punishment: '',
        keywords: ['RTI', 'information', 'transparency', 'government'],
      ),
      const LawSection(
        sectionNumber: '6',
        title: 'How to file RTI',
        actName: 'RTI Act 2005',
        description:
            'A person who desires to obtain any information shall make a request in writing or through electronic means to the Public Information Officer, accompanied by the prescribed fee.',
        simpleExplanation:
            'Write a simple application to the Public Information Officer (PIO) of the department. Pay ₹10 fee (BPL cardholders exempt). You can file RTI online too through the RTI Online portal. No need to give reason for seeking information.',
        punishment: '',
        keywords: ['RTI application', 'PIO', 'fee', 'how to file'],
      ),
      const LawSection(
        sectionNumber: '7',
        title: 'Time limit for response',
        actName: 'RTI Act 2005',
        description:
            'The PIO shall, within thirty days of the receipt of the request, either provide the information or reject the request for any of the reasons specified. In case of life or liberty, within 48 hours.',
        simpleExplanation:
            'The government MUST reply within 30 days. If the information concerns someone\'s life or freedom, they must reply within 48 hours! If no reply comes, the request is deemed refused and you can appeal.',
        punishment: 'PIO can be fined ₹250 per day of delay, up to ₹25,000.',
        keywords: ['30 days', 'time limit', 'response', 'penalty'],
      ),
      const LawSection(
        sectionNumber: '8',
        title: 'Exemptions from disclosure',
        actName: 'RTI Act 2005',
        description:
            'Information affecting sovereignty, security, strategic/scientific interests, information received in confidence from foreign government, information that would endanger life/safety, cabinet papers, etc.',
        simpleExplanation:
            'Some information is exempt: national security secrets, cabinet papers (until decision is made), personal information that invades privacy, information from foreign governments, and trade secrets. But the exemption can be overridden if public interest outweighs the harm.',
        punishment: '',
        keywords: ['exemption', 'secret', 'national security', 'privacy'],
      ),
    ],
  ),
  LawCategory(
    name: 'Information Technology Act 2000',
    icon: 'computer',
    description:
        'India\'s primary law for regulating electronic commerce, digital signatures, cyber offenses, and data protection.',
    sections: [
      const LawSection(
        sectionNumber: '43',
        title: 'Unauthorized access to computer system',
        actName: 'IT Act 2000',
        description:
            'If any person without permission accesses or downloads data from a computer, introduces a virus, damages a computer, disrupts a network, or denies access to an authorized person.',
        simpleExplanation:
            'Hacking into someone\'s computer, downloading their data without permission, spreading viruses, or crashing networks is illegal. This covers most forms of unauthorized access to digital systems.',
        punishment: 'Compensation up to ₹1 crore to the affected person.',
        keywords: ['hacking', 'unauthorized access', 'virus', 'computer crime'],
      ),
      const LawSection(
        sectionNumber: '66',
        title: 'Computer related offences (Hacking)',
        actName: 'IT Act 2000',
        description:
            'If any person dishonestly or fraudulently does any act referred to in section 43, he shall be punishable.',
        simpleExplanation:
            'If hacking is done with dishonest or fraudulent intent (not just accidentally), it becomes a criminal offense. This is the main "hacking" section used by police.',
        punishment: 'Imprisonment up to 3 years, or fine up to ₹5 lakhs, or both.',
        keywords: ['hacking', 'criminal', 'fraudulent access'],
      ),
      const LawSection(
        sectionNumber: '66A',
        title: 'Sending offensive messages (STRUCK DOWN)',
        actName: 'IT Act 2000',
        description:
            'This section made sending "offensive" or "menacing" messages through communication devices a crime. It was STRUCK DOWN by the Supreme Court in Shreya Singhal v. Union of India (2015).',
        simpleExplanation:
            'This section was used to arrest people for social media posts. The Supreme Court declared it unconstitutional because it was too vague and violated free speech. Despite being struck down, some police still (illegally) use it - you should know it\'s no longer valid.',
        punishment: 'INVALID - Struck down by Supreme Court in 2015.',
        keywords: ['66A', 'social media', 'struck down', 'free speech', 'Shreya Singhal'],
      ),
      const LawSection(
        sectionNumber: '67',
        title: 'Publishing obscene material electronically',
        actName: 'IT Act 2000',
        description:
            'Whoever publishes or transmits or causes to be published in the electronic form any material which is lascivious or appeals to the prurient interest.',
        simpleExplanation:
            'Publishing or sharing obscene/pornographic content online is a crime. This covers websites, apps, social media, messaging - any electronic platform.',
        punishment: 'First conviction: imprisonment up to 3 years and fine up to ₹5 lakhs. Subsequent: up to 5 years and ₹10 lakhs.',
        keywords: ['obscene', 'pornography', 'online', 'electronic'],
      ),
      const LawSection(
        sectionNumber: '72',
        title: 'Breach of confidentiality and privacy',
        actName: 'IT Act 2000',
        description:
            'Any person who has secured access to any electronic record, book, register, correspondence, information, document or other material and discloses it without consent.',
        simpleExplanation:
            'If someone who has access to your digital records (like a telecom employee, bank official, or IT administrator) shares your private data without your consent, they can be prosecuted.',
        punishment: 'Imprisonment up to 2 years, or fine up to ₹1 lakh, or both.',
        keywords: ['privacy', 'breach', 'confidentiality', 'data leak'],
      ),
    ],
  ),
  LawCategory(
    name: 'Consumer Protection Act 2019',
    icon: 'shopping_cart',
    description:
        'Protects consumers from unfair trade practices, defective goods, and deficient services. Replaced the 1986 Act with stronger provisions.',
    sections: [
      const LawSection(
        sectionNumber: '2(7)',
        title: 'Who is a Consumer',
        actName: 'Consumer Protection Act 2019',
        description:
            'Any person who buys any goods or avails any services for a consideration, including online transactions and e-commerce.',
        simpleExplanation:
            'If you buy a product or service (including online), you are a consumer with legal rights. This now explicitly covers online shopping, e-commerce, and direct selling.',
        punishment: '',
        keywords: ['consumer', 'buyer', 'e-commerce', 'online shopping'],
      ),
      const LawSection(
        sectionNumber: '18',
        title: 'Consumer Rights',
        actName: 'Consumer Protection Act 2019',
        description:
            'Right to be protected against marketing of goods hazardous to life and property; right to be informed about quality, quantity, potency, purity, standard and price; right to be assured of access to goods at competitive prices; right to be heard; right to seek redressal; right to consumer awareness.',
        simpleExplanation:
            'You have 6 consumer rights: (1) Safety from dangerous products (2) Full information about products (3) Fair prices through competition (4) Your complaints must be heard (5) Get compensation for defects (6) Be educated about your rights.',
        punishment: '',
        keywords: ['consumer rights', 'safety', 'information', 'redressal'],
      ),
      const LawSection(
        sectionNumber: '35',
        title: 'Consumer Disputes Redressal Commissions',
        actName: 'Consumer Protection Act 2019',
        description:
            'Three-tier consumer court system: District (up to ₹1 crore), State (₹1 crore to ₹10 crore), and National (above ₹10 crore).',
        simpleExplanation:
            'File complaints based on claim amount: District Commission (up to ₹1 crore), State Commission (₹1-10 crore), National Commission (above ₹10 crore). You can file complaints online too through the e-daakhil portal. No lawyer needed - you can argue yourself.',
        punishment: '',
        keywords: ['consumer court', 'complaint', 'district commission', 'e-daakhil'],
      ),
      const LawSection(
        sectionNumber: '89',
        title: 'Product Liability',
        actName: 'Consumer Protection Act 2019',
        description:
            'A product liability action may be brought by a complainant against a product manufacturer, product service provider, or product seller.',
        simpleExplanation:
            'If a product is defective and causes harm, you can sue the manufacturer, seller, or service provider. They are ALL liable. This is especially important for defective vehicles, medicines, electronics, or food products.',
        punishment: 'Compensation as determined by consumer court. No cap on amount.',
        keywords: ['product liability', 'defective product', 'manufacturer', 'compensation'],
      ),
    ],
  ),
  LawCategory(
    name: 'Motor Vehicles Act 1988 (Amended 2019)',
    icon: 'directions_car',
    description:
        'Governs all aspects of road transport - licensing, registration, insurance, traffic rules, and penalties for violations.',
    sections: [
      const LawSection(
        sectionNumber: '3',
        title: 'Driving License Requirements',
        actName: 'Motor Vehicles Act 1988',
        description:
            'No person shall drive a motor vehicle in any public place unless he holds an effective driving licence issued to him authorising him to drive the vehicle.',
        simpleExplanation:
            'You MUST have a valid driving license to drive. Learner\'s license at 16 (gearless two-wheelers only), full license at 18. Commercial license at 20 with 8th pass. License is valid for 20 years or until age 50 (whichever is earlier).',
        punishment: 'Driving without license: Fine up to ₹5,000 (after 2019 amendment).',
        keywords: ['license', 'driving', 'learner', 'DL'],
      ),
      const LawSection(
        sectionNumber: '185',
        title: 'Driving under influence of alcohol/drugs',
        actName: 'Motor Vehicles Act 1988',
        description:
            'Whoever drives a motor vehicle while having consumed alcohol exceeding 30mg per 100ml of blood or is under the influence of a drug to such an extent as to be incapable of exercising proper control.',
        simpleExplanation:
            'Drunk driving is a serious offense. Blood alcohol limit is 30mg/100ml (one of the strictest in the world). Even small amounts of alcohol can make you illegal to drive. Police can test you on the spot.',
        punishment: 'First offense: ₹10,000 fine and/or 6 months jail. Repeat offense: ₹15,000 fine and/or 2 years jail.',
        keywords: ['drunk driving', 'alcohol', 'DUI', 'intoxication'],
      ),
      const LawSection(
        sectionNumber: '194D',
        title: 'Not wearing seat belt',
        actName: 'Motor Vehicles Act 1988',
        description:
            'Whoever drives a motor vehicle without wearing a safety belt or carries passengers not wearing safety belts.',
        simpleExplanation:
            'All passengers (including rear seat) must wear seat belts. This is often ignored but strictly enforced now with heavy fines after the 2019 amendment.',
        punishment: 'Fine of ₹1,000.',
        keywords: ['seat belt', 'safety', 'fine'],
      ),
    ],
  ),
  LawCategory(
    name: 'Environmental Laws',
    icon: 'eco',
    description:
        'Laws protecting India\'s environment, forests, wildlife, and natural resources. Based on Article 48A (DPSP) and Article 51A(g) (Fundamental Duty).',
    sections: [
      const LawSection(
        sectionNumber: '3',
        title: 'Power of Central Government to take measures',
        actName: 'Environment Protection Act 1986',
        description:
            'Central Government shall have the power to take all such measures as it deems necessary for protecting and improving the quality of the environment and preventing environmental pollution.',
        simpleExplanation:
            'The central government has broad powers to protect the environment - set standards, restrict industries, close polluting units, and take any action needed. This is the umbrella act under which all environmental regulations are made.',
        punishment: 'Violation: imprisonment up to 5 years, fine up to ₹1 lakh, or both. Continuing offense: ₹5,000 per day.',
        keywords: ['environment', 'pollution', 'protection', 'EPA'],
      ),
      const LawSection(
        sectionNumber: '15',
        title: 'Penalties under Air (Prevention and Control of Pollution) Act 1981',
        actName: 'Air Act 1981',
        description:
            'Whoever fails to comply with any provisions of this Act or orders/directions issued under it shall be punishable.',
        simpleExplanation:
            'Industries and vehicles must follow air quality standards. The Pollution Control Board monitors and enforces compliance. If you cause air pollution beyond permitted limits, you face criminal prosecution.',
        punishment: 'Imprisonment up to 6 years, and fine. For continuing offense, ₹5,000 per day.',
        keywords: ['air pollution', 'emission', 'pollution control', 'industry'],
      ),
      const LawSection(
        sectionNumber: '5',
        title: 'National Green Tribunal (NGT)',
        actName: 'NGT Act 2010',
        description:
            'The NGT shall have jurisdiction over all civil cases involving substantial questions relating to environment and shall apply the principles of sustainable development, precautionary principle and polluter pays principle.',
        simpleExplanation:
            'The NGT is a special court for environmental cases. Any citizen can file a complaint about environmental damage. It follows three key principles: sustainable development, precaution (prevent harm before it happens), and polluter pays (whoever pollutes must pay for cleanup).',
        punishment: 'NGT can order compensation, restoration, and penalties up to ₹100 crore.',
        keywords: ['NGT', 'green tribunal', 'environmental court', 'pollution'],
      ),
    ],
  ),
  LawCategory(
    name: 'Labour Laws',
    icon: 'engineering',
    description:
        'Four new Labour Codes (2020) consolidated 29 old labour laws into four categories: Wages, Industrial Relations, Social Security, and Occupational Safety.',
    sections: [
      const LawSection(
        sectionNumber: '3',
        title: 'Minimum Wages',
        actName: 'Code on Wages 2019',
        description:
            'The appropriate Government shall fix the minimum rate of wages payable to employees. No employer shall pay to any employee wages less than the minimum rate of wages.',
        simpleExplanation:
            'Every worker must be paid at least the minimum wage set by the government. The Central government sets a floor wage, and states can fix higher minimums. Covers ALL workers - organized and unorganized sectors. Penalties for paying below minimum wage have been increased.',
        punishment: 'Fine up to ₹50,000. Repeat offense: imprisonment up to 3 months and fine up to ₹1 lakh.',
        keywords: ['minimum wage', 'salary', 'wages', 'payment'],
      ),
      const LawSection(
        sectionNumber: '6',
        title: 'Equal Remuneration',
        actName: 'Code on Wages 2019',
        description:
            'No employer shall discriminate against any employee on the ground of gender in matters relating to wages by paying less to such employee.',
        simpleExplanation:
            'Men and women must get equal pay for equal work. An employer cannot pay a woman less than a man for the same job. This is backed by Article 39(d) of the Constitution.',
        punishment: 'Fine up to ₹50,000.',
        keywords: ['equal pay', 'gender', 'discrimination', 'wages'],
      ),
      const LawSection(
        sectionNumber: '14',
        title: 'Registration of establishments',
        actName: 'Code on Social Security 2020',
        description:
            'Every establishment to which this Code applies shall be registered within such period and in such manner as may be prescribed.',
        simpleExplanation:
            'All businesses must register under the social security code. This ensures workers get benefits like EPF (provident fund), ESI (health insurance), gratuity, and maternity benefits. Covers gig workers and platform workers for the first time.',
        punishment: '',
        keywords: ['registration', 'EPF', 'ESI', 'social security', 'gig workers'],
      ),
    ],
  ),
  LawCategory(
    name: 'Digital Personal Data Protection Act 2023',
    icon: 'lock',
    description:
        'India\'s comprehensive data protection law that regulates how personal data is collected, stored, processed, and shared by organizations.',
    sections: [
      const LawSection(
        sectionNumber: '4',
        title: 'Consent for data processing',
        actName: 'DPDP Act 2023',
        description:
            'A person may process the personal data of a Data Principal only in accordance with the provisions of this Act and for a lawful purpose for which the Data Principal has given consent or for certain legitimate uses.',
        simpleExplanation:
            'Companies need your clear, informed consent before collecting or using your personal data. You must be told what data is being collected, why, and how it will be used. You can withdraw consent at any time.',
        punishment: '',
        keywords: ['consent', 'data', 'privacy', 'personal data'],
      ),
      const LawSection(
        sectionNumber: '6',
        title: 'Rights of Data Principal',
        actName: 'DPDP Act 2023',
        description:
            'Every Data Principal shall have the right to obtain information about processing, seek correction and erasure of personal data, have a readily available means of grievance redressal, and nominate another person to exercise rights in case of death or incapacity.',
        simpleExplanation:
            'You have the right to: know what data companies have about you, get wrong data corrected, get your data deleted, complain if your data is misused, and nominate someone to manage your data rights after you.',
        punishment: '',
        keywords: ['data rights', 'erasure', 'correction', 'privacy rights'],
      ),
      const LawSection(
        sectionNumber: '33',
        title: 'Penalties for data breach',
        actName: 'DPDP Act 2023',
        description:
            'In case of significant personal data breach due to non-compliance, the Data Protection Board may impose penalties up to ₹250 crore per instance.',
        simpleExplanation:
            'If a company fails to protect your data and it gets leaked, they can be fined up to ₹250 crore (about \$30 million). This makes companies take data security seriously. The Data Protection Board of India will oversee enforcement.',
        punishment: 'Penalty up to ₹250 crore per data breach instance.',
        keywords: ['data breach', 'penalty', 'fine', 'data protection board'],
      ),
    ],
  ),
];
