import 'package:flutter/material.dart';
import 'chatbot_screen.dart';

class LandmarkCasesScreen extends StatefulWidget {
  const LandmarkCasesScreen({super.key});

  /// Public accessor for search functionality
  static final List<Map<String, String>> cases = _LandmarkCasesScreenState._cases;

  @override
  State<LandmarkCasesScreen> createState() => _LandmarkCasesScreenState();
}

class _LandmarkCasesScreenState extends State<LandmarkCasesScreen> {
  String _selectedCategory = 'All';

  static const List<String> _categories = [
    'All',
    'Fundamental Rights',
    'Women & Gender',
    'Religion & Personal Law',
    'Property & Land',
    'Criminal Law',
    'Digital & Privacy',
    'Environment',
    'Reservation & Equality',
    'Free Speech & Media',
    'Labour & Employment',
  ];

  static final List<Map<String, String>> _cases = [
    // Fundamental Rights
    {
      'case': 'Kesavananda Bharati v. State of Kerala (1973)',
      'category': 'Fundamental Rights',
      'significance': 'Established the Basic Structure Doctrine - Parliament cannot alter the fundamental framework of the Constitution. The most important constitutional case in Indian history.',
      'year': '1973',
    },
    {
      'case': 'Maneka Gandhi v. Union of India (1978)',
      'category': 'Fundamental Rights',
      'significance': 'Expanded the scope of Article 21 (Right to Life) - any law restricting personal liberty must be just, fair, and reasonable. Transformed the interpretation of fundamental rights.',
      'year': '1978',
    },
    {
      'case': 'Golaknath v. State of Punjab (1967)',
      'category': 'Fundamental Rights',
      'significance': 'Held that Parliament cannot amend fundamental rights. Though later overruled by the 24th Amendment, it sparked the basic structure debate.',
      'year': '1967',
    },
    {
      'case': 'A.K. Gopalan v. State of Madras (1950)',
      'category': 'Fundamental Rights',
      'significance': 'First major case on preventive detention and Article 21. Supreme Court initially took a narrow view of "procedure established by law" - later overruled by Maneka Gandhi.',
      'year': '1950',
    },
    {
      'case': 'Minerva Mills v. Union of India (1980)',
      'category': 'Fundamental Rights',
      'significance': 'Reinforced the Basic Structure Doctrine. Struck down Section 4 of the 42nd Amendment. Held that balance between fundamental rights and DPSP is the basic structure.',
      'year': '1980',
    },

    // Women & Gender
    {
      'case': 'Vishaka v. State of Rajasthan (1997)',
      'category': 'Women & Gender',
      'significance': 'Laid down guidelines to prevent sexual harassment of women at the workplace. Led to the enactment of the POSH Act, 2013.',
      'year': '1997',
    },
    {
      'case': 'Shah Bano v. Mohd. Ahmed Khan (1985)',
      'category': 'Women & Gender',
      'significance': 'Upheld the right of a divorced Muslim woman to claim maintenance under Section 125 CrPC. A landmark in women\'s rights that sparked national debate on Uniform Civil Code.',
      'year': '1985',
    },
    {
      'case': 'Lata Singh v. State of U.P. (2006)',
      'category': 'Women & Gender',
      'significance': 'Held that an adult woman has the right to marry anyone of her choice. Family members threatening or committing violence against inter-caste couples is a criminal offence.',
      'year': '2006',
    },
    {
      'case': 'Shayara Bano v. Union of India (2017)',
      'category': 'Women & Gender',
      'significance': 'Declared instant Triple Talaq (talaq-e-biddat) unconstitutional. Led to the Muslim Women (Protection of Rights on Marriage) Act, 2019.',
      'year': '2017',
    },
    {
      'case': 'Joseph Shine v. Union of India (2018)',
      'category': 'Women & Gender',
      'significance': 'Struck down Section 497 IPC (adultery) as unconstitutional. Held that treating women as property of their husbands violates Article 21.',
      'year': '2018',
    },
    {
      'case': 'Indian Young Lawyers Assn. v. State of Kerala (Sabarimala) (2018)',
      'category': 'Women & Gender',
      'significance': 'Allowed women of all ages to enter Sabarimala temple. Held that exclusion based on biological characteristics violates fundamental rights.',
      'year': '2018',
    },

    // Religion & Personal Law
    {
      'case': 'S.R. Bommai v. Union of India (1994)',
      'category': 'Religion & Personal Law',
      'significance': 'Defined secularism as part of the basic structure of the Constitution. Limited the arbitrary use of Article 356 (President\'s Rule).',
      'year': '1994',
    },
    {
      'case': 'M. Ismail Faruqui v. Union of India (Ayodhya) (1994)',
      'category': 'Religion & Personal Law',
      'significance': 'Held that a mosque is not an essential part of Islam. Later, the 2019 Ayodhya verdict in M Siddiq v. Mahant Suresh Das allotted disputed land for Ram Temple with alternative land for mosque.',
      'year': '1994',
    },
    {
      'case': 'Rev. Stainislaus v. State of M.P. (1977)',
      'category': 'Religion & Personal Law',
      'significance': 'Upheld state anti-conversion laws. Held that Article 25 (Freedom of Religion) does not include the right to convert others - only the right to freely profess, practice, and propagate.',
      'year': '1977',
    },

    // Property & Land
    {
      'case': 'State of West Bengal v. Bela Banerjee (1954)',
      'category': 'Property & Land',
      'significance': 'Held that compensation for land acquisition must be "just equivalent" of the property. Led to amendments to limit judicial review of compensation amounts.',
      'year': '1954',
    },
    {
      'case': 'Kameshwar Singh v. State of Bihar (1952)',
      'category': 'Property & Land',
      'significance': 'Challenged zamindari abolition. Led to the First Amendment adding Article 31A to protect land reform laws from challenge under fundamental rights.',
      'year': '1952',
    },
    {
      'case': 'Olga Tellis v. Bombay Municipal Corporation (1985)',
      'category': 'Property & Land',
      'significance': 'Known as the "Pavement Dwellers Case." Right to livelihood is part of Right to Life under Article 21. Slum dwellers cannot be evicted without due process.',
      'year': '1985',
    },
    {
      'case': 'Narmada Bachao Andolan v. Union of India (2000)',
      'category': 'Property & Land',
      'significance': 'Allowed Sardar Sarovar Dam construction but mandated proper rehabilitation of displaced persons. Balanced development with displacement rights.',
      'year': '2000',
    },

    // Criminal Law
    {
      'case': 'Hussainara Khatoon v. State of Bihar (1979)',
      'category': 'Criminal Law',
      'significance': 'Established the right to speedy trial as a fundamental right under Article 21. Exposed thousands of undertrial prisoners languishing in Bihar jails longer than maximum sentence.',
      'year': '1979',
    },
    {
      'case': 'D.K. Basu v. State of West Bengal (1997)',
      'category': 'Criminal Law',
      'significance': 'Laid down 11 mandatory guidelines for arrest and detention to prevent custodial violence and torture. Every arrest must be recorded with witness.',
      'year': '1997',
    },
    {
      'case': 'Bachan Singh v. State of Punjab (1980)',
      'category': 'Criminal Law',
      'significance': 'Upheld constitutionality of death penalty but restricted it to the "rarest of rare" cases. Established the framework courts use to decide capital punishment.',
      'year': '1980',
    },
    {
      'case': 'Lalita Kumari v. Govt. of U.P. (2014)',
      'category': 'Criminal Law',
      'significance': 'Made it mandatory for police to register an FIR when information discloses a cognizable offence. Police cannot refuse to file an FIR - it is their duty.',
      'year': '2014',
    },
    {
      'case': 'Arnesh Kumar v. State of Bihar (2014)',
      'category': 'Criminal Law',
      'significance': 'Restricted automatic arrest in cases with punishment up to 7 years. Police must satisfy themselves that arrest is necessary - prevents misuse of laws like 498A.',
      'year': '2014',
    },

    // Digital & Privacy
    {
      'case': 'K.S. Puttaswamy v. Union of India (2017)',
      'category': 'Digital & Privacy',
      'significance': 'Declared Right to Privacy as a fundamental right under Article 21. A 9-judge bench unanimously held privacy is intrinsic to life and liberty.',
      'year': '2017',
    },
    {
      'case': 'Shreya Singhal v. Union of India (2015)',
      'category': 'Digital & Privacy',
      'significance': 'Struck down Section 66A of the IT Act (arrest for "offensive" online posts) as unconstitutional. Landmark victory for free speech on the internet.',
      'year': '2015',
    },
    {
      'case': 'K.S. Puttaswamy v. Union of India (Aadhaar) (2018)',
      'category': 'Digital & Privacy',
      'significance': 'Upheld Aadhaar but struck down Section 57 - private companies cannot demand Aadhaar. Aadhaar is valid for government subsidies and tax filing but cannot be mandatory for bank accounts or phones.',
      'year': '2018',
    },

    // Environment
    {
      'case': 'M.C. Mehta v. Union of India (Oleum Gas Leak) (1987)',
      'category': 'Environment',
      'significance': 'Introduced the principle of "Absolute Liability" for hazardous industries. Companies engaged in dangerous activities are absolutely liable - no exceptions.',
      'year': '1987',
    },
    {
      'case': 'Vellore Citizens Welfare Forum v. Union of India (1996)',
      'category': 'Environment',
      'significance': 'Applied the Precautionary Principle and Polluter Pays Principle as part of Indian environmental law. Ordered tanneries in Tamil Nadu to pay compensation for pollution.',
      'year': '1996',
    },
    {
      'case': 'T.N. Godavarman v. Union of India (1997)',
      'category': 'Environment',
      'significance': 'Expanded the definition of "forest" beyond Revenue records. Any area that is a forest by dictionary meaning is protected. Ongoing case with 3000+ orders protecting India\'s forests.',
      'year': '1997',
    },

    // Reservation & Equality
    {
      'case': 'Indra Sawhney v. Union of India (1992)',
      'category': 'Reservation & Equality',
      'significance': 'Upheld 27% OBC reservation and set the 50% ceiling on total reservations. Introduced the "creamy layer" concept - economically well-off OBCs are excluded.',
      'year': '1992',
    },
    {
      'case': 'Navtej Singh Johar v. Union of India (2018)',
      'category': 'Reservation & Equality',
      'significance': 'Decriminalized consensual homosexual acts by reading down Section 377 IPC. Affirmed that LGBTQ+ persons have equal rights to dignity, privacy, and non-discrimination.',
      'year': '2018',
    },
    {
      'case': 'NALSA v. Union of India (2014)',
      'category': 'Reservation & Equality',
      'significance': 'Recognized transgender persons as the "third gender." Directed governments to treat them as socially and educationally backward classes and extend reservations.',
      'year': '2014',
    },
    {
      'case': 'Ashoka Kumar Thakur v. Union of India (2008)',
      'category': 'Reservation & Equality',
      'significance': 'Upheld 27% OBC reservation in central educational institutions (93rd Amendment & Central Educational Institutions Act). Confirmed creamy layer exclusion.',
      'year': '2008',
    },

    // Free Speech & Media
    {
      'case': 'Romesh Thappar v. State of Madras (1950)',
      'category': 'Free Speech & Media',
      'significance': 'Established that freedom of the press is included in freedom of speech under Article 19(1)(a). Banning a newspaper\'s entry into a state is unconstitutional.',
      'year': '1950',
    },
    {
      'case': 'Bennett Coleman & Co. v. Union of India (1972)',
      'category': 'Free Speech & Media',
      'significance': 'Struck down the Newsprint Control Order restricting newspaper pages. Government cannot indirectly curtail press freedom through newsprint rationing.',
      'year': '1972',
    },
    {
      'case': 'Anuradha Bhasin v. Union of India (2020)',
      'category': 'Free Speech & Media',
      'significance': 'Held that internet access is a fundamental right under Article 19. Internet shutdowns must be proportionate, temporary, and subject to judicial review.',
      'year': '2020',
    },

    // Labour & Employment
    {
      'case': 'Bandhua Mukti Morcha v. Union of India (1984)',
      'category': 'Labour & Employment',
      'significance': 'Addressed bonded labour as a violation of Article 23. Supreme Court directed states to identify, release, and rehabilitate bonded labourers.',
      'year': '1984',
    },
    {
      'case': 'People\'s Union for Democratic Rights v. Union of India (1982)',
      'category': 'Labour & Employment',
      'significance': 'Known as the "Asiad Workers Case." Held that paying less than minimum wage is forced labour under Article 23. Workers building for Asian Games were being exploited.',
      'year': '1982',
    },
    {
      'case': 'Secretary, State of Karnataka v. Umadevi (2006)',
      'category': 'Labour & Employment',
      'significance': 'Ruled that temporary/daily wage workers cannot claim permanent regularization as a right. Government jobs must be filled through proper recruitment process under Articles 14 and 16.',
      'year': '2006',
    },
  ];

  List<Map<String, String>> get _filteredCases {
    if (_selectedCategory == 'All') return _cases;
    return _cases.where((c) => c['category'] == _selectedCategory).toList();
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'Fundamental Rights': return Colors.blue;
      case 'Women & Gender': return Colors.pink;
      case 'Religion & Personal Law': return Colors.orange;
      case 'Property & Land': return Colors.brown;
      case 'Criminal Law': return Colors.red;
      case 'Digital & Privacy': return Colors.indigo;
      case 'Environment': return Colors.green;
      case 'Reservation & Equality': return Colors.purple;
      case 'Free Speech & Media': return Colors.teal;
      case 'Labour & Employment': return Colors.amber.shade800;
      default: return Colors.grey;
    }
  }

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'Fundamental Rights': return Icons.shield;
      case 'Women & Gender': return Icons.woman;
      case 'Religion & Personal Law': return Icons.temple_hindu;
      case 'Property & Land': return Icons.landscape;
      case 'Criminal Law': return Icons.local_police;
      case 'Digital & Privacy': return Icons.phonelink_lock;
      case 'Environment': return Icons.eco;
      case 'Reservation & Equality': return Icons.diversity_3;
      case 'Free Speech & Media': return Icons.newspaper;
      case 'Labour & Employment': return Icons.engineering;
      default: return Icons.balance;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filtered = _filteredCases;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Landmark Court Decisions'),
      ),
      body: Column(
        children: [
          // Category filter chips
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: _categories.map((cat) {
                  final isSelected = cat == _selectedCategory;
                  final count = cat == 'All'
                      ? _cases.length
                      : _cases.where((c) => c['category'] == cat).length;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text('$cat ($count)'),
                      onSelected: (_) => setState(() => _selectedCategory = cat),
                      selectedColor: (cat == 'All'
                              ? theme.colorScheme.primary
                              : _categoryColor(cat))
                          .withOpacity(0.2),
                      checkmarkColor: cat == 'All'
                          ? theme.colorScheme.primary
                          : _categoryColor(cat),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        color: isSelected
                            ? (cat == 'All' ? theme.colorScheme.primary : _categoryColor(cat))
                            : theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(height: 1),
          // Cases list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final c = filtered[index];
                final category = c['category']!;
                final color = _categoryColor(category);
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => _showCaseDetail(context, c),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(_categoryIcon(category),
                                    size: 18, color: color),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  c['case']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            c['significance']!,
                            style: const TextStyle(fontSize: 13, height: 1.5),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: color,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                c['year']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.textTheme.bodySmall?.color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCaseDetail(BuildContext context, Map<String, String> c) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _CaseDetailPage(
          caseData: c,
          color: _categoryColor(c['category']!),
          icon: _categoryIcon(c['category']!),
        ),
      ),
    );
  }
}

class _CaseDetailPage extends StatelessWidget {
  final Map<String, String> caseData;
  final Color color;
  final IconData icon;

  const _CaseDetailPage({
    required this.caseData,
    required this.color,
    required this.icon,
  });

  void _openAIChat(BuildContext context) {
    final c = caseData;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatbotScreen(
          contextTitle: c['case']!,
          contextPrompt:
              'Provide a detailed analysis of this landmark Indian court case:\n\n'
              'Case: ${c['case']}\n'
              'Category: ${c['category']}\n'
              'Brief: ${c['significance']}\n\n'
              'Cover: 1) Background & facts, 2) Key legal questions, 3) Supreme Court\'s decision, '
              '4) Key judges, 5) Impact on citizens today, 6) Related laws/articles, 7) Legacy. '
              'Use simple language. Include Hindi terms where helpful.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = caseData;

    return Scaffold(
      appBar: AppBar(
        title: Text(c['category']!),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAIChat(context),
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Know More'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          c['category']!,
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        c['year']!,
                        style: TextStyle(fontSize: 13, color: theme.textTheme.bodySmall?.color, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Case name
            Text(
              c['case']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, height: 1.4),
            ),
            const SizedBox(height: 16),

            // Significance
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Significance', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
                  const SizedBox(height: 8),
                  Text(
                    c['significance']!,
                    style: const TextStyle(fontSize: 15, height: 1.7),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
