import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme.dart';

class CrmPipelineScreen extends StatefulWidget {
  const CrmPipelineScreen({super.key});

  @override
  State<CrmPipelineScreen> createState() => _CrmPipelineScreenState();
}

class _CrmPipelineScreenState extends State<CrmPipelineScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HireIQColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        title: const Text(
          'CRM Pipeline',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: HireIQColors.navy),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: HireIQColors.teal,
          unselectedLabelColor: HireIQColors.textMuted,
          indicatorColor: HireIQColors.teal,
          isScrollable: true,
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(text: 'Sourced'),
            Tab(text: 'Screening'),
            Tab(text: 'Interview'),
            Tab(text: 'Hired'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPipelineList(['Alex Rivera', 'Elena Soph', 'Marcus Chen']),
          _buildPipelineList(['Sarah Miller', 'David Park']),
          _buildPipelineList(['James Wilson']),
          _buildPipelineList(['Olivia Garcia']),
        ],
      ),
    );
  }

  Widget _buildPipelineList(List<String> names) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: names.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: HireIQColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: HireIQColors.silver),
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: HireIQColors.teal,
                child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(names[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: HireIQColors.navy)),
                    const Text('Match Score: 92%',
                        style: TextStyle(
                            fontSize: 12,
                            color: HireIQColors.teal,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Icon(Icons.drag_indicator_rounded,
                  color: HireIQColors.silver),
            ],
          ),
        );
      },
    );
  }
}
