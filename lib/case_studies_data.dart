// Real Case Studies Data
class CaseStudy {
  final String title;
  final String year;
  final String description;
  final String outcome;
  final String legalAction;
  final String impact;
  final String category;

  CaseStudy({
    required this.title,
    required this.year,
    required this.description,
    required this.outcome,
    required this.legalAction,
    required this.impact,
    required this.category,
  });
}

final List<CaseStudy> realCaseStudies = [
  CaseStudy(
    title: "Nirbhaya Case (2012)",
    year: "2012",
    category: "Sexual Assault",
    description: "A 23-year-old physiotherapy student was brutally gang-raped and assaulted in Delhi, leading to her death. The incident sparked nationwide protests and demanded stricter laws.",
    outcome: "Four convicts were hanged in 2020. One juvenile was sentenced to 3 years in reform facility.",
    legalAction: "Led to Criminal Law Amendment Act, 2013. Death penalty for repeat rape offenders. New provisions for acid attacks, stalking, and voyeurism.",
    impact: "Transformed India's rape laws. Faster trial procedures implemented. Created widespread awareness about women's safety. Led to formation of Nirbhaya Fund (₹1,000 crores) for women safety initiatives.",
  ),
  CaseStudy(
    title: "Vishaka vs State of Rajasthan (1997)",
    year: "1997",
    category: "Workplace Harassment",
    description: "Bhanwari Devi, a social worker in Rajasthan, was gang-raped as retaliation for her efforts to prevent child marriage. She fought for justice for years.",
    outcome: "Supreme Court issued Vishaka Guidelines for preventing sexual harassment at workplace.",
    legalAction: "Created mandatory guidelines for employers. Required Internal Complaints Committee in organizations. Defined sexual harassment comprehensively.",
    impact: "Landmark judgment that formed basis for POSH Act 2013. Made workplaces legally accountable. Empowered women to report harassment without fear.",
  ),
  CaseStudy(
    title: "Mathura Rape Case (1972)",
    year: "1972",
    category: "Police Custody Rape",
    description: "16-year-old tribal girl Mathura was raped by two policemen inside a police station. Lower courts acquitted the accused claiming 'consent'.",
    outcome: "Supreme Court acquitted policemen in 1979, sparking massive protests.",
    legalAction: "Led to Criminal Law Amendment Act, 1983. Shifted burden of proof to accused in custody rape cases. Made it clear that policeman-victim relationship means no consent possible.",
    impact: "Changed the legal definition of consent. Recognized power imbalance. Strengthened laws against custodial rape. Sparked feminist legal reforms.",
  ),
  CaseStudy(
    title: "Bhanwari Devi Case (2011)",
    year: "2011",
    category: "Honor Killing",
    description: "Nurse in Rajasthan who exposed illegal medical practices was murdered and her body was disposed of. Case involved powerful politicians.",
    outcome: "CBI investigation led to multiple arrests including politicians and police officers.",
    legalAction: "Highlighted corruption in justice system. Led to stricter witness protection laws.",
    impact: "Exposed nexus between crime and politics. Strengthened CBI's role in sensitive cases.",
  ),
  CaseStudy(
    title: "Priyadarshini Mattoo Case (1996)",
    year: "1996",
    category: "Stalking & Murder",
    description: "Law student Priyadarshini was stalked and murdered by son of an IPS officer. Initially acquitted due to influence.",
    outcome: "After 10 years of legal battle, convict sentenced to death (later life imprisonment).",
    legalAction: "Exposed how powerful accused manipulate justice. Led to demands for witness protection and fast-track courts.",
    impact: "Victory for victim's family showed that justice is possible even against powerful. Made stalking a serious offense in public consciousness.",
  ),
  CaseStudy(
    title: "Poonam Rani Case (2023)",
    year: "2023",
    category: "Cyber Crime",
    description: "Mumbai-based professional had her photos morphed and posted on porn sites by ex-boyfriend. She fought 2-year legal battle.",
    outcome: "Accused arrested under IT Act. ₹10 lakh compensation awarded to victim.",
    legalAction: "Used IT Act Section 66E (privacy violation) and 67 (obscene content). Set precedent for cyber harassment cases.",
    impact: "Encouraged more women to report cyber crimes. Tech companies made stricter policies for removing such content.",
  ),
];

final List<Map<String, dynamic>> successStories = [
  {
    "name": "Laxmi Agarwal",
    "year": "2005",
    "story": "Acid attack survivor at age 15. Instead of hiding, she became face of acid attack survivors' rights movement.",
    "achievement": "Founded Chhanv Foundation. Successfully campaigned for regulation of acid sales. Supreme Court issued guidelines limiting acid sales. Inspired Deepika Padukone's movie 'Chhapaak'.",
    "quote": "I am not a victim, I am a survivor.",
    "image": "assets/laxmi.jpg",
  },
  {
    "name": "Kiranjit Ahluwalia",
    "year": "1989",
    "story": "Endured 10 years of domestic violence. Set abusive husband on fire in self-defense. Initially convicted of murder.",
    "achievement": "Her case changed UK law on domestic violence. 'Provocation' defense was reformed. Sentence reduced to manslaughter. Case helped change domestic violence laws globally.",
    "quote": "Sometimes you have to fight for your right to live.",
    "image": "assets/kiranjit.jpg",
  },
  {
    "name": "Suzette Jordan (Park Street Rape Survivor)",
    "year": "2012",
    "story": "Gang-raped in Kolkata. Instead of staying anonymous, revealed her identity to fight stigma.",
    "achievement": "Broke taboo of victim-shaming. Spoke publicly about her ordeal. Three rapists convicted and sentenced to 10 years each. Became symbol of courage for rape survivors.",
    "quote": "I am a fighter, not a victim.",
    "image": "assets/suzette.jpg",
  },
  {
    "name": "Chandrashekhar Vanlalruat's Daughter",
    "year": "2019",
    "story": "Minor girl from Mizoram trafficked to Hyderabad. Escaped and helped police rescue 20 other girls.",
    "achievement": "Her testimony led to busting of major trafficking ring. 15 traffickers arrested. Received bravery award from President.",
    "quote": "Speaking up saved not just me, but many others.",
    "image": "assets/hero_girl.jpg",
  },
  {
    "name": "Aruna Shanbaug (Impact Case)",
    "year": "1973-2015",
    "story": "Nurse brutally assaulted and left in vegetative state for 42 years. Her case sparked debate on passive euthanasia and victim compensation.",
    "achievement": "Supreme Court legalized passive euthanasia in her case (2011). Led to better laws for sexual assault victim compensation. Improved hospital security for healthcare workers.",
    "quote": "Her case changed laws even though she couldn't speak.",
    "image": "assets/aruna.jpg",
  },
];

final List<Map<String, dynamic>> landmarkJudgments = [
  {
    "title": "Independent Thought vs UOI (2017)",
    "court": "Supreme Court",
    "description": "Sexual intercourse with wife below 18 years is rape, even in marriage.",
    "significance": "Struck down Exception 2 to Section 375 IPC partially. Protected minor wives. Recognized child marriage victims' rights.",
    "verdict": "Exception 2 of Section 375 struck down for wives under 18 years.",
  },
  {
    "title": "Justice K.S. Puttaswamy vs UOI (2017)",
    "court": "Supreme Court",
    "description": "Right to privacy is fundamental right under Article 21.",
    "significance": "Helped in cases of voyeurism, stalking, revenge porn. Made digital privacy a fundamental right.",
    "verdict": "Privacy is protected under Article 21 of Constitution.",
  },
  {
    "title": "Sakshi vs UOI (2004)",
    "court": "Supreme Court",
    "description": "Expanded definition of rape beyond penile-vaginal penetration.",
    "significance": "Led to amendment of rape laws. Included other forms of sexual assault. Recognized male victims of sexual assault.",
    "verdict": "Directed Parliament to amend rape laws to include all forms of penetration.",
  },
  {
    "title": "State of Maharashtra vs Madhukar (1991)",
    "court": "Supreme Court",
    "description": "Victim's character is irrelevant in rape cases.",
    "significance": "Stopped defense lawyers from character assassination. Protected victim's dignity in court. Changed trial procedures.",
    "verdict": "Past sexual history cannot be used to discredit rape victim.",
  },
  {
    "title": "Domestic Violence Act Constitutional (2010)",
    "court": "Supreme Court",
    "description": "Protection of Women from Domestic Violence Act upheld as constitutional.",
    "significance": "Validated civil remedies for domestic violence. Confirmed women's right to shared household. Made enforcement mandatory.",
    "verdict": "PWDVA 2005 is constitutionally valid and enforceable.",
  },
];

final List<Map<String, String>> preventionTips = [
  {
    "category": "In Public Transport",
    "tips": "• Sit near driver or conductor\n• Avoid isolated seats at back\n• Keep emergency contacts on speed dial\n• Note vehicle number and share with someone\n• Trust your instincts - if uncomfortable, get off\n• Avoid headphones - stay alert\n• Keep some distance from co-passengers",
  },
  {
    "category": "Walking Alone",
    "tips": "• Stay in well-lit areas\n• Walk facing traffic (harder to pull into vehicle)\n• Carry pepper spray or safety alarm\n• Keep phone charged and accessible\n• Avoid shortcuts through isolated areas\n• Walk confidently, not distracted\n• If followed, go to crowded area or shop\n• Don't reveal you're alone",
  },
  {
    "category": "At Home",
    "tips": "• Don't share you're alone on social media\n• Keep emergency numbers visible\n• Have working phone at all times\n• Know your neighbors\n• Install peephole and chain lock\n• Don't open door to strangers\n• Keep windows locked at night\n• Have emergency exit plan",
  },
  {
    "category": "Online Safety",
    "tips": "• Don't share personal details publicly\n• Use privacy settings on social media\n• Don't accept friend requests from strangers\n• Be cautious in online relationships\n• Don't share location in real-time\n• Block and report harassers immediately\n• Save evidence of online harassment\n• Don't respond to trolls or bullies",
  },
  {
    "category": "At Workplace",
    "tips": "• Know your company's POSH policy\n• Document any harassment instances\n• Report to Internal Complaints Committee\n• Keep emails/messages as evidence\n• Avoid being alone with potential harasser\n• Inform trusted colleague or manager\n• Know legal rights under POSH Act 2013\n• Don't feel pressured to stay silent",
  },
  {
    "category": "On Dates/Social Meetings",
    "tips": "• Meet in public places first time\n• Tell friend/family where you're going\n• Share live location\n• Keep own transport arrangements\n• Don't leave drink unattended\n• Trust your gut feeling\n• Have exit strategy\n• Limit alcohol consumption\n• Keep phone charged",
  },
  {
    "category": "Self-Defense Basics",
    "tips": "• Target vulnerable points: eyes, nose, throat, groin\n• Make noise - scream 'FIRE' (more people respond)\n• Use keys, pen, bag as weapons\n• Learn basic self-defense moves\n• Run if possible - better than fighting\n• Create distance between you and attacker\n• Don't be predictable in routine\n• Stay fit and alert",
  },
];

final List<Map<String, String>> legalRightsFacts = [
  {
    "title": "Zero FIR",
    "description": "Police MUST register your complaint regardless of jurisdiction. They will transfer it to correct police station. You have RIGHT to get FIR copy immediately.",
  },
  {
    "title": "Free Legal Aid",
    "description": "You don't need money for lawyer. State provides FREE legal aid to women victims. Contact District Legal Services Authority (DLSA) or call 15100.",
  },
  {
    "title": "Woman Police Officer",
    "description": "You have RIGHT to give statement to woman police officer only. Male officer cannot record statement of rape/molestation victim without woman officer present.",
  },
  {
    "title": "In-Camera Trial",
    "description": "Your rape case will be heard in closed court (in-camera). Media cannot reveal your identity. Maximum privacy protection ensured.",
  },
  {
    "title": "Victim Compensation",
    "description": "State MUST pay you compensation (₹1-10 lakhs depending on case). Apply to DLSA within one year. Compensation doesn't affect criminal case.",
  },
  {
    "title": "Right to Record Denial",
    "description": "If police refuse to file FIR, you can send written complaint to SP/Commissioner. Online complaint on state police website also valid.",
  },
  {
    "title": "Two-Finger Test Banned",
    "description": "Degrading 'two-finger test' is banned by Supreme Court. Doctor cannot comment on your 'habituation to sex'. Such test evidence is inadmissible.",
  },
  {
    "title": "Medical Examination Rights",
    "description": "Medical examination should be by woman doctor. You have right to female attendant. Examination must be with your consent (except by court order).",
  },
  {
    "title": "Protection During Trial",
    "description": "Screen/separate room facility during testimony. No aggressive cross-examination allowed. Victim cannot be called to police station at night.",
  },
  {
    "title": "Right to Speedy Trial",
    "description": "Rape cases should be decided in 2 months (Fast Track Courts). If not, you can file application for speedy trial under Section 309 CrPC.",
  },
];
