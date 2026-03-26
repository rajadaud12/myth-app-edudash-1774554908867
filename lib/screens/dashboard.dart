import 'package:flutter/material.dart';
import 'package:edudash_app/utils/colors.dart'; 
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _statCards = [
    {
      'title': 'Total Students',
      'value': '3,248',
      'change': '+12%',
      'positive': true,
      'icon': Icons.school_rounded,
      'color': AppColors.statCard1,
    },
    {
      'title': 'Teachers',
      'value': '184',
      'change': '+4%',
      'positive': true,
      'icon': Icons.person_rounded,
      'color': AppColors.statCard2,
    },
    {
      'title': 'Attendance',
      'value': '94.2%',
      'change': '-1.3%',
      'positive': false,
      'icon': Icons.check_circle_rounded,
      'color': AppColors.statCard3,
    },
    {
      'title': 'Revenue',
      'value': '\$84.5K',
      'change': '+8%',
      'positive': true,
      'icon': Icons.attach_money_rounded,
      'color': AppColors.statCard4,
    },
  ];

  final List<Map<String, dynamic>> _recentStudents = [
    {
      'name': 'Sophia Carter',
      'class': 'Grade 10-A',
      'status': 'Present',
      'avatar': 'https://i.pravatar.cc/150?img=47',
    },
    {
      'name': 'Liam Johnson',
      'class': 'Grade 9-B',
      'status': 'Absent',
      'avatar': 'https://i.pravatar.cc/150?img=12',
    },
    {
      'name': 'Emma Williams',
      'class': 'Grade 11-C',
      'status': 'Present',
      'avatar': 'https://i.pravatar.cc/150?img=45',
    },
    {
      'name': 'Noah Brown',
      'class': 'Grade 8-A',
      'status': 'Late',
      'avatar': 'https://i.pravatar.cc/150?img=15',
    },
    {
      'name': 'Olivia Davis',
      'class': 'Grade 12-B',
      'status': 'Present',
      'avatar': 'https://i.pravatar.cc/150?img=49',
    },
  ];

  final List<Map<String, dynamic>> _upcomingEvents = [
    {
      'title': 'Science Exhibition',
      'date': 'Dec 18',
      'time': '9:00 AM',
      'color': AppColors.primary,
      'icon': Icons.science_rounded,
    },
    {
      'title': 'Parent-Teacher Meet',
      'date': 'Dec 22',
      'time': '2:00 PM',
      'color': AppColors.secondary,
      'icon': Icons.groups_rounded,
    },
    {
      'title': 'Annual Sports Day',
      'date': 'Dec 28',
      'time': '8:00 AM',
      'color': AppColors.accent,
      'icon': Icons.sports_soccer_rounded,
    },
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.dashboard_rounded, 'label': 'Dashboard'},
    {'icon': Icons.school_rounded, 'label': 'Students'},
    {'icon': Icons.person_rounded, 'label': 'Teachers'},
    {'icon': Icons.bar_chart_rounded, 'label': 'Reports'},
    {'icon': Icons.settings_rounded, 'label': 'Settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
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
                            Expanded(
                              flex: 3,
                              child: _buildRecentStudentsTable(),
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              flex: 2,
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
                        _buildProgressSection(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 240,
      color: AppColors.navBarBg,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.school_rounded, color: AppColors.textLight, size: 22),
                ),
                SizedBox(width: 12),
                Text(
                  'EduDash',
                  style: GoogleFonts.poppins(
                    color: AppColors.textLight,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: Colors.white.withOpacity(0.08), thickness: 1),
          ),
          SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _navItems.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(color: AppColors.primary.withOpacity(0.5), width: 1)
                          : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _navItems[index]['icon'],
                          color: isSelected ? AppColors.primary : AppColors.textGrey,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          _navItems[index]['label'],
                          style: GoogleFonts.poppins(
                            color: isSelected ? AppColors.textLight : AppColors.textGrey,
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                        if (isSelected) ...[Spacer(), Container(width: 4, height: 4, decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle))],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=68'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Robert Lee',
                          style: GoogleFonts.poppins(
                            color: AppColors.textLight,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Administrator',
                          style: GoogleFonts.poppins(
                            color: AppColors.textGrey,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.logout_rounded, color: AppColors.textGrey, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Dashboard Overview',
            style: GoogleFonts.poppins(
              color: AppColors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
          Container(
            width: 240,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                SizedBox(width: 12),
                Icon(Icons.search_rounded, color: AppColors.textGrey, size: 18),
                SizedBox(width: 8),
                Text(
                  'Search anything...',
                  style: GoogleFonts.poppins(
                    color: AppColors.textGrey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Stack(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Icon(Icons.notifications_rounded, color: AppColors.textDark, size: 20),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.cardWhite, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 12),
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=68'),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.gradientStart, Color(0xFF9B8FFF), AppColors.gradientEnd],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning, Dr. Robert! 👋',
                  style: GoogleFonts.poppins(
                    color: AppColors.textLight,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Here is what is happening at Greenfield Academy today.',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    _buildBannerBadge(Icons.calendar_today_rounded, 'Dec 15, 2024'),
                    SizedBox(width: 16),
                    _buildBannerBadge(Icons.wb_sunny_rounded, 'Term 2 - Week 8'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          Image.network(
            'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?w=180&q=80',
            width: 160,
            height: 110,
            fit: BoxFit.cover,
            loadingBuilder: (ctx, child, progress) {
              if (progress == null) return ClipRRect(borderRadius: BorderRadius.circular(12), child: child);
              return Container(
                width: 160,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
              );
            },
            errorBuilder: (ctx, e, s) => Container(
              width: 160,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.school_rounded, color: Colors.white, size: 48),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerBadge(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCards() {
    return Row(
      children: _statCards.map((card) {
        int index = _statCards.indexOf(card);
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < _statCards.length - 1 ? 16 : 0),
            child: _buildStatCard(card),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> card) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
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
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: card['color'].withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(card['icon'], color: card['color'], size: 22),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: card['positive']
                      ? AppColors.success.withOpacity(0.12)
                      : AppColors.error.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      card['positive'] ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                      color: card['positive'] ? AppColors.success : AppColors.error,
                      size: 12,
                    ),
                    SizedBox(width: 2),
                    Text(
                      card['change'],
                      style: GoogleFonts.poppins(
                        color: card['positive'] ? AppColors.success : AppColors.error,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            card['value'],
            style: GoogleFonts.poppins(
              color: AppColors.textDark,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            card['title'],
            style: GoogleFonts.poppins(
              color: AppColors.textGrey,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentStudentsTable() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Students',
                style: GoogleFonts.poppins(
                  color: AppColors.textDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('Name', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600))),
                Expanded(flex: 2, child: Text('Class', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600))),
                Expanded(flex: 1, child: Text('Status', style: GoogleFonts.poppins(color: AppColors.textGrey, fontSize: 12, fontWeight: FontWeight.w600))),
              ],
            ),
          ),
          SizedBox(height: 8),
          ...(_recentStudents.map((student) => _buildStudentRow(student)).toList()),
        ],
      ),
    );
  }

  Widget _buildStudentRow(Map<String, dynamic> student) {
    Color statusColor = student['status'] == 'Present'
        ? AppColors.success
        : student['status'] == 'Absent'
            ? AppColors.error
            : AppColors.warning;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(student['avatar']),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    student['name'],
                    style: GoogleFonts.poppins(
                      color: AppColors.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              student['class'],
              style: GoogleFonts.poppins(
                color: AppColors.textGrey,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                student['status'],
                style: GoogleFonts.poppins(
                  color: statusColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Events',
            style: GoogleFonts.poppins(
              color: AppColors.textDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          ...(_upcomingEvents.map((event) => _buildEventItem(event)).toList()),
        ],
      ),
    );
  }

  Widget _buildEventItem(Map<String, dynamic> event) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: event['color'].withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: event['color'].withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(event['icon'], color: event['color'], size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'],
                  style: GoogleFonts.poppins(
                    color: AppColors.textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '${event['date']} · ${event['time']}',
                  style: GoogleFonts.poppins(
                    color: AppColors.textGrey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: AppColors.textGrey, size: 18),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.person_add_rounded, 'label': 'Add Student', 'color': AppColors.primary},
      {'icon': Icons.assignment_rounded, 'label': 'New Report', 'color': AppColors.secondary},
      {'icon': Icons.schedule_rounded, 'label': 'Schedule', 'color': AppColors.accent},
      {'icon': Icons.announcement_rounded, 'label': 'Announce', 'color': AppColors.accentOrange},
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: GoogleFonts.poppins(
              color: AppColors.textDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: actions.map((action) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: (action['color'] as Color).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(action['icon'] as IconData, color: action['color'] as Color, size: 20),
                      ),
                      SizedBox(height: 6),
                      Text(
                        action['label'] as String,
                        style: GoogleFonts.poppins(
                          color: AppColors.textGrey,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    final subjects = [
      {'name': 'Mathematics', 'progress': 0.82, 'color': AppColors.primary},
      {'name': 'Science', 'progress': 0.74, 'color': AppColors.accent},
      {'name': 'English', 'progress': 0.91, 'color': AppColors.secondary},
      {'name': 'History', 'progress': 0.65, 'color': AppColors.accentOrange},
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subject Performance Overview',
                style: GoogleFonts.poppins(
                  color: AppColors.textDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    Text(
                      'This Term',
                      style: GoogleFonts.poppins(
                        color: AppColors.textGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textGrey, size: 16),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: subjects.map((subject) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: subjects.indexOf(subject) < subjects.length - 1 ? 20 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            subject['name'] as String,
                            style: GoogleFonts.poppins(
                              color: AppColors.textDark,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${((subject['progress'] as double) * 100).toInt()}%',
                            style: GoogleFonts.poppins(
                              color: subject['color'] as Color,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: subject['progress'] as double,
                          backgroundColor: (subject['color'] as Color).withOpacity(0.12),
                          valueColor: AlwaysStoppedAnimation<Color>(subject['color'] as Color),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}