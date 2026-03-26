import 'package:flutter/material.dart';
import 'package:edudash_app/utils/colors.dart'; 
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedNavIndex = 0;
  int _selectedTab = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _statCards = [
    {
      'title': 'Total Students',
      'value': '3,248',
      'change': '+12%',
      'positive': true,
      'icon': Icons.school_rounded,
      'color': AppColors.statCard1,
      'bg': Color(0xFFEDECFF),
    },
    {
      'title': 'Teachers',
      'value': '184',
      'change': '+4%',
      'positive': true,
      'icon': Icons.person_rounded,
      'color': AppColors.statCard2,
      'bg': Color(0xFFFFECF0),
    },
    {
      'title': 'Attendance',
      'value': '94.2%',
      'change': '-1.3%',
      'positive': false,
      'icon': Icons.check_circle_rounded,
      'color': AppColors.statCard3,
      'bg': Color(0xFFE8FDF5),
    },
    {
      'title': 'Revenue',
      'value': '\$84.5K',
      'change': '+8%',
      'positive': true,
      'icon': Icons.attach_money_rounded,
      'color': AppColors.statCard4,
      'bg': Color(0xFFFFF6E8),
    },
  ];

  final List<Map<String, dynamic>> _recentStudents = [
    {'name': 'Sophia Carter', 'class': 'Grade 10-A', 'gpa': '3.9', 'status': 'Present', 'avatar': 'https://i.pravatar.cc/150?img=47'},
    {'name': 'Liam Johnson', 'class': 'Grade 9-B', 'gpa': '3.4', 'status': 'Absent', 'avatar': 'https://i.pravatar.cc/150?img=12'},
    {'name': 'Emma Williams', 'class': 'Grade 11-C', 'gpa': '4.0', 'status': 'Present', 'avatar': 'https://i.pravatar.cc/150?img=45'},
    {'name': 'Noah Brown', 'class': 'Grade 8-A', 'gpa': '3.6', 'status': 'Late', 'avatar': 'https://i.pravatar.cc/150?img=15'},
    {'name': 'Olivia Davis', 'class': 'Grade 12-B', 'gpa': '3.8', 'status': 'Present', 'avatar': 'https://i.pravatar.cc/150?img=49'},
    {'name': 'James Wilson', 'class': 'Grade 7-C', 'gpa': '3.2', 'status': 'Present', 'avatar': 'https://i.pravatar.cc/150?img=59'},
  ];

  final List<Map<String, dynamic>> _upcomingEvents = [
    {'title': 'Science Exhibition', 'date': 'Dec 18', 'time': '9:00 AM', 'color': AppColors.primary, 'icon': Icons.science_rounded, 'participants': '42 Students'},
    {'title': 'Parent-Teacher Meet', 'date': 'Dec 22', 'time': '2:00 PM', 'color': AppColors.secondary, 'icon': Icons.groups_rounded, 'participants': '184 Teachers'},
    {'title': 'Annual Sports Day', 'date': 'Dec 28', 'time': '8:00 AM', 'color': AppColors.accent, 'icon': Icons.sports_soccer_rounded, 'participants': 'All Students'},
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.dashboard_rounded, 'label': 'Dashboard'},
    {'icon': Icons.school_rounded, 'label': 'Students'},
    {'icon': Icons.person_rounded, 'label': 'Teachers'},
    {'icon': Icons.bar_chart_rounded, 'label': 'Reports'},
    {'icon': Icons.calendar_month_rounded, 'label': 'Schedule'},
    {'icon': Icons.settings_rounded, 'label': 'Settings'},
  ];

  final List<Map<String, dynamic>> _subjects = [
    {'name': 'Mathematics', 'progress': 0.82, 'color': AppColors.primary, 'students': '820', 'icon': Icons.functions_rounded},
    {'name': 'Science', 'progress': 0.74, 'color': AppColors.accent, 'students': '740', 'icon': Icons.science_rounded},
    {'name': 'English', 'progress': 0.91, 'color': AppColors.secondary, 'students': '910', 'icon': Icons.menu_book_rounded},
    {'name': 'History', 'progress': 0.65, 'color': AppColors.accentOrange, 'students': '650', 'icon': Icons.history_edu_rounded},
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Row(
          children: [
            _buildSidebar(),
            Expanded(
              child: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildWelcomeBanner(),
                          SizedBox(height: 28),
                          _buildStatCards(),
                          SizedBox(height: 28),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 5, child: _buildStudentsSection()),
                              SizedBox(width: 24),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    _buildUpcomingEvents(),
                                    SizedBox(height: 24),
                                    _buildQuickActions(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 28),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: _buildSubjectPerformance()),
                              SizedBox(width: 24),
                              Expanded(flex: 2, child: _buildActivityFeed()),
                            ],
                          ),
                          SizedBox(height: 28),
                          _buildAnnouncementBanner(),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 248,
      decoration: BoxDecoration(
        color: AppColors.navBarBg,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: Offset(4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.school_rounded, color: Colors.white, size: 22),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EduDash',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      'School Management',
                      style: GoogleFonts.poppins(
                        color: AppColors.textGrey,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: Colors.white.withOpacity(0.06), thickness: 1),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              'MAIN MENU',
              style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: _navItems.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedNavIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedNavIndex = index),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.only(bottom: 4),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [AppColors.primary.withOpacity(0.3), AppColors.primary.withOpacity(0.1)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected ? Border.all(color: AppColors.primary.withOpacity(0.4), width: 1) : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            _navItems[index]['icon'],
                            color: isSelected ? AppColors.primary : AppColors.textGrey,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          _navItems[index]['label'],
                          style: GoogleFonts.poppins(
                            color: isSelected ? Colors.white : AppColors.textGrey,
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                        if (isSelected) ...[Spacer(), Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.5), blurRadius: 6)]))],
                        if (index == 1) ...[Spacer(), _buildNavBadge('12', AppColors.secondary)],
                        if (index == 3) ...[Spacer(), _buildNavBadge('3', AppColors.accentOrange)],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: Colors.white.withOpacity(0.06), thickness: 1),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withOpacity(0.2), AppColors.accent.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=68'),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.navBarBg, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Robert Lee',
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Administrator',
                          style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.logout_rounded, color: AppColors.textGrey, size: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBadge(String count, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        count,
        style: GoogleFonts.poppins(color: color, fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard Overview',
                style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Text(
                'Greenfield Academy · Dec 15, 2024',
                style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 12),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: 260,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                SizedBox(width: 12),
                Icon(Icons.search_rounded, color: AppColors.textGrey, size: 18),
                SizedBox(width: 8),
                Text('Search students, teachers...', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 12.5)),
              ],
            ),
          ),
          SizedBox(width: 16),
          _buildTopBarIcon(Icons.tune_rounded, AppColors.textDark, null),
          SizedBox(width: 10),
          Stack(
            children: [
              _buildTopBarIcon(Icons.notifications_outlined, AppColors.textDark, null),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
          _buildTopBarIcon(Icons.mail_outline_rounded, AppColors.textDark, null),
          SizedBox(width: 14),
          Container(
            height: 36,
            width: 1,
            color: AppColors.divider,
          ),
          SizedBox(width: 14),
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=68'),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dr. Robert', style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 12, fontWeight: FontWeight.w600)),
              Text('Admin', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 10)),
            ],
          ),
          SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textGrey, size: 18),
        ],
      ),
    );
  }

  Widget _buildTopBarIcon(IconData icon, Color color, Color? bgColor) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.divider),
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF8B7FFF), Color(0xFF43D9A2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 28,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: 60,
            bottom: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(28),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(width: 6, height: 6, decoration: BoxDecoration(color: AppColors.accent, shape: BoxShape.circle)),
                                SizedBox(width: 6),
                                Text('Term 2 · Week 8', style: GoogleFonts.poppins(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Good Morning,',
                        style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8), fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Dr. Robert Lee! 👋',
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700, height: 1.2),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Greenfield Academy is thriving today. Here\'s your\ncomplete overview for December 15, 2024.',
                        style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.8), fontSize: 13, height: 1.6),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          _buildBannerAction(Icons.add_rounded, 'Add Student', AppColors.accent),
                          SizedBox(width: 12),
                          _buildBannerAction(Icons.bar_chart_rounded, 'View Reports', Colors.white.withOpacity(0.25)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1580582932707-520aed937b7b?w=200&q=80',
                        width: 180,
                        height: 140,
                        fit: BoxFit.cover,
                        loadingBuilder: (ctx, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            width: 180,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                          );
                        },
                        errorBuilder: (ctx, e, s) => Container(
                          width: 180,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(Icons.school_rounded, color: Colors.white, size: 56),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerAction(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            SizedBox(width: 6),
            Text(label, style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards() {
    return Row(
      children: List.generate(_statCards.length, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < _statCards.length - 1 ? 16 : 0),
            child: _buildStatCard(_statCards[index]),
          ),
        );
      }),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> card) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: (card['color'] as Color).withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: (card['color'] as Color).withOpacity(0.08),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: card['bg'],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(card['icon'], color: card['color'], size: 24),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: card['positive'] ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      card['positive'] ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                      color: card['positive'] ? AppColors.success : AppColors.error,
                      size: 13,
                    ),
                    SizedBox(width: 3),
                    Text(
                      card['change'],
                      style: GoogleFonts.poppins(
                        color: card['positive'] ? AppColors.success : AppColors.error,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Text(
            card['value'],
            style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.5),
          ),
          SizedBox(height: 4),
          Text(
            card['title'],
            style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 13),
          ),
          SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: card['title'] == 'Attendance' ? 0.94 : card['title'] == 'Teachers' ? 0.6 : card['title'] == 'Total Students' ? 0.8 : 0.72,
              backgroundColor: (card['color'] as Color).withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(card['color']),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentsSection() {
    return Container(
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Student Roster', style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 16, fontWeight: FontWeight.w700)),
                  Text('Today\'s attendance overview', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  _buildTabChip('All', 0),
                  SizedBox(width: 6),
                  _buildTabChip('Present', 1),
                  SizedBox(width: 6),
                  _buildTabChip('Absent', 2),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('Student', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5))),
                Expanded(flex: 2, child: Text('Class', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5))),
                Expanded(flex: 1, child: Text('GPA', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5))),
                Expanded(flex: 1, child: Text('Status', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5))),
              ],
            ),
          ),
          SizedBox(height: 6),
          ...(_recentStudents.map((student) => _buildStudentRow(student)).toList()),
          SizedBox(height: 8),
          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.expand_more_rounded, color: AppColors.primary, size: 18),
              label: Text('View All 3,248 Students', style: GoogleFonts.poppins(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabChip(String label, int index) {
    bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.primary : AppColors.divider),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : AppColors.textGrey,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildStudentRow(Map<String, dynamic> student) {
    Color statusColor = student['status'] == 'Present'
        ? AppColors.success
        : student['status'] == 'Absent'
            ? AppColors.error
            : AppColors.warning;
    IconData statusIcon = student['status'] == 'Present'
        ? Icons.check_circle_rounded
        : student['status'] == 'Absent'
            ? Icons.cancel_rounded
            : Icons.access_time_rounded;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(student['avatar']),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    student['name'],
                    style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(student['class'], style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 12)),
          ),
          Expanded(
            flex: 1,
            child: Text(student['gpa'], style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(statusIcon, color: statusColor, size: 11),
                  SizedBox(width: 4),
                  Text(
                    student['status'],
                    style: GoogleFonts.poppins(color: statusColor, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingEvents() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Upcoming Events', style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w700)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('3 events', style: GoogleFonts.poppins(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          SizedBox(height: 14),
          ...(_upcomingEvents.map((event) => _buildEventItem(event)).toList()),
        ],
      ),
    );
  }

  Widget _buildEventItem(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 52,
            decoration: BoxDecoration(
              color: event['color'],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: (event['color'] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(event['icon'], color: event['color'], size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event['title'], style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w600)),
                SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded, size: 10, color: AppColors.textGrey),
                    SizedBox(width: 4),
                    Text('${event['date']} · ${event['time']}', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 11)),
                    SizedBox(width: 8),
                    Icon(Icons.people_alt_rounded, size: 10, color: AppColors.textGrey),
                    SizedBox(width: 4),
                    Text(event['participants'], style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.person_add_rounded, 'label': 'Add Student', 'color': AppColors.primary, 'bg': Color(0xFFEDECFF)},
      {'icon': Icons.assignment_rounded, 'label': 'New Report', 'color': AppColors.secondary, 'bg': Color(0xFFFFECF0)},
      {'icon': Icons.schedule_rounded, 'label': 'Schedule', 'color': AppColors.accent, 'bg': Color(0xFFE8FDF5)},
      {'icon': Icons.announcement_rounded, 'label': 'Announce', 'color': AppColors.accentOrange, 'bg': Color(0xFFFFF6E8)},
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w700)),
          SizedBox(height: 14),
          Row(
            children: actions.map((action) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: action['bg'] as Color,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Icon(action['icon'] as IconData, color: action['color'] as Color, size: 22),
                        SizedBox(height: 6),
                        Text(
                          action['label'] as String,
                          style: GoogleFonts.poppins(color: action['color'] as Color, fontSize: 10, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectPerformance() {
    return Container(
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Subject Performance', style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w700)),
                  Text('Average scores this term', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 12)),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    Text('Term 2', style: GoogleFonts.poppins(color: AppColors.textMedium, fontSize: 12, fontWeight: FontWeight.w500)),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textGrey, size: 16),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ..._subjects.map((subject) => _buildSubjectBar(subject)).toList(),
        ],
      ),
    );
  }

  Widget _buildSubjectBar(Map<String, dynamic> subject) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: (subject['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(subject['icon'] as IconData, color: subject['color'] as Color, size: 16),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(subject['name'] as String, style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 13, fontWeight: FontWeight.w600)),
                        Row(
                          children: [
                            Text('${((subject['progress'] as double) * 100).toInt()}%', style: GoogleFonts.poppins(color: subject['color'] as Color, fontSize: 13, fontWeight: FontWeight.w700)),
                            SizedBox(width: 8),
                            Text('${subject['students']} students', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: subject['progress'] as double,
                        backgroundColor: (subject['color'] as Color).withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(subject['color'] as Color),
                        minHeight: 7,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityFeed() {
    final activities = [
      {'icon': Icons.person_add_rounded, 'color': AppColors.primary, 'title': 'New student enrolled', 'subtitle': 'Marcus Lee joined Grade 10-A', 'time': '2 min ago'},
      {'icon': Icons.assignment_turned_in_rounded, 'color': AppColors.accent, 'title': 'Exam results published', 'subtitle': 'Mid-term results for Grade 11', 'time': '18 min ago'},
      {'icon': Icons.payment_rounded, 'color': AppColors.accentOrange, 'title': 'Fee payment received', 'subtitle': '\$1,200 from Emily Turner', 'time': '1 hr ago'},
      {'icon': Icons.event_available_rounded, 'color': AppColors.secondary, 'title': 'Event confirmed', 'subtitle': 'Science Exhibition approved', 'time': '3 hr ago'},
      {'icon': Icons.grade_rounded, 'color': AppColors.indigo, 'title': 'Grade report updated', 'subtitle': 'Mathematics Q4 scores added', 'time': '5 hr ago'},
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Activity', style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 15, fontWeight: FontWeight.w700)),
              Icon(Icons.more_horiz_rounded, color: AppColors.textGrey, size: 20),
            ],
          ),
          SizedBox(height: 16),
          ...activities.map((activity) => _buildActivityItem(activity)).toList(),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (activity['color'] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(activity['icon'] as IconData, color: activity['color'] as Color, size: 17),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity['title'] as String, style: GoogleFonts.poppins(color: AppColors.textDark, fontSize: 12.5, fontWeight: FontWeight.w600)),
                SizedBox(height: 2),
                Text(activity['subtitle'] as String, style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 11.5), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          SizedBox(width: 6),
          Text(activity['time'] as String, style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 10.5)),
        ],
      ),
    );
  }

  Widget _buildAnnouncementBanner() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E1E2D), Color(0xFF2A2A45)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accentOrange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.campaign_rounded, color: AppColors.accentOrange, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.accentOrange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('ANNOUNCEMENT', style: GoogleFonts.poppins(color: AppColors.accentOrange, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1)),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  'Winter Break starts Dec 30 – Jan 10. All semester reports must be submitted by Dec 27.',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500, height: 1.5),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.accentOrange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('Read More', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}