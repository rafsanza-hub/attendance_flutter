import 'package:flutter/material.dart';

class LeaveRequestView extends StatefulWidget {
  const LeaveRequestView({Key? key}) : super(key: key);

  @override
  State<LeaveRequestView> createState() => _LeaveRequestViewState();
}

class _LeaveRequestViewState extends State<LeaveRequestView> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Upcoming', 'Past', 'Team Leave'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildLeaveStatusCards(),
              const SizedBox(height: 24),
              _buildTabBar(),
              const SizedBox(height: 16),
              Expanded(
                child: _buildLeaveList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'All Leaves',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLeaveStatusCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatusCard(
            'Leave\nBalance', '20', Colors.blue.shade50, Colors.blue),
        _buildStatusCard(
            'Leave\nApproved', '2', Colors.green.shade50, Colors.green),
        _buildStatusCard(
            'Leave\nPending', '4', Colors.teal.shade50, Colors.teal),
        _buildStatusCard(
            'Leave\nCancelled', '10', Colors.red.shade50, Colors.red),
      ],
    );
  }

  Widget _buildStatusCard(
      String title, String count, Color backgroundColor, Color borderColor) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor.withOpacity(0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: borderColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: List.generate(
          _tabs.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                // setState(() {
                //   _selectedTabIndex = index;
                // });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedTabIndex == index ? Colors.blue : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  _tabs[index],
                  style: TextStyle(
                    color: _selectedTabIndex == index
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveList() {
    if (_selectedTabIndex == 2) {
      // Team Leave tab
      return _buildTeamLeaveContent();
    } else {
      // Original Upcoming/Past tab content
      return ListView(
        children: [
          _buildLeaveItem(
            date: 'Apr 15, 2023 - Apr 18, 2023',
            applyDays: '3 Days',
            leaveBalance: '16',
            approvedBy: 'Martin Deo',
            isApproved: true,
          ),
          const SizedBox(height: 16),
          _buildLeaveItem(
            date: 'Mar 10, 2023 - Mar 12, 2023',
            applyDays: '2 Days',
            leaveBalance: '19',
            approvedBy: 'Martin Deo',
            isApproved: true,
          ),
        ],
      );
    }
  }

  Widget _buildTeamLeaveContent() {
    return ListView(
      children: [
        _buildTeamLeaveItem(
          name: 'Jane Cooper',
          date: 'Apr 15, 2023 - Apr 18, 2023',
          avatarUrl: 'https://i.pravatar.cc/150?img=1',
        ),
        const SizedBox(height: 16),
        _buildTeamLeaveItem(
          name: 'Leslie Alexander',
          date: 'Apr 10, 2023 - Apr 12, 2023',
          avatarUrl: 'https://i.pravatar.cc/150?img=2',
        ),
        const SizedBox(height: 16),
        _buildTeamLeaveItem(
          name: 'Jenny Wilson',
          date: 'May 08, 2023 - May 12, 2023',
          avatarUrl: 'https://i.pravatar.cc/150?img=3',
        ),
      ],
    );
  }

  Widget _buildTeamLeaveItem({
    required String name,
    required String date,
    required String avatarUrl,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.close, color: Colors.white),
                  label: const Text(
                    'Reject',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.red.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.teal.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveItem({
    required String date,
    required String applyDays,
    required String leaveBalance,
    required String approvedBy,
    required bool isApproved,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (isApproved)
                const Text(
                  'Approved',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Apply Days',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      applyDays,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Leave Balance',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      leaveBalance,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Approved By',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      approvedBy,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
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
}
