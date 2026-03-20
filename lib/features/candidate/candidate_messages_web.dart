import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hireiq/shared/theme.dart';
import 'package:hireiq/shared/components/web_layout.dart';

class CandidateMessagesWeb extends ConsumerStatefulWidget {
  const CandidateMessagesWeb({super.key});
  @override
  ConsumerState<CandidateMessagesWeb> createState() => _State();
}

class _State extends ConsumerState<CandidateMessagesWeb> {
  int _selected = 0;
  final _ctrl = TextEditingController();

  static const _convos = [
    _Person('Nomvula Dlamini', 'AgentFlow Recruitment', 'Looking forward to connecting!', '2m', 2),
    _Person('Sipho Mokoena', 'TechFlow Solutions', 'Can we schedule a call?', '1h', 0),
    _Person('Anele Khumalo', 'Capitec Bank', 'Interview confirmed for 25 March', '5h', 1),
    _Person('Priya Naidoo', 'HireIQ Team', 'Your profile has been reviewed', '1d', 0),
  ];

  static final _msgs = [
    _Msg('Hi Thabo! We have an exciting Senior Flutter Developer role at TechFlow Solutions that matches your profile 94%. Would you be interested in a quick call?', false),
    _Msg('That sounds great! I\'d love to learn more about the role.', true),
    _Msg('Perfect! The role involves leading the mobile chapter and building next-gen fintech apps. The salary range is R85k–R120k/month.', false),
    _Msg('Excellent! When would be a good time for an initial chat?', true),
    _Msg('Looking forward to connecting!', false),
  ];

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      child: SizedBox(
        height: 700,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Row(children: [
            // Left: conversation list
            SizedBox(width: 300, child: Container(
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: const BorderRadius.horizontal(left: Radius.circular(HireIQTheme.radiusLg)), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(children: [
                Container(padding: const EdgeInsets.all(16), decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: HireIQTheme.borderLight))), child: TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search_rounded, size: 16), hintText: 'Search messages...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusSm)), contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)))),
                Expanded(child: ListView.separated(
                  itemCount: _convos.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, color: HireIQTheme.borderLight),
                  itemBuilder: (_, i) {
                    final c = _convos[i];
                    final isActive = i == _selected;
                    return InkWell(
                      onTap: () => setState(() => _selected = i),
                      child: Container(color: isActive ? HireIQTheme.primaryNavy.withValues(alpha: 0.04) : null, padding: const EdgeInsets.all(14), child: Row(children: [
                        Stack(children: [
                          CircleAvatar(backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.15), child: Text(c.name.substring(0, 1), style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))),
                          if (c.unread > 0) Positioned(right: 0, top: 0, child: Container(width: 16, height: 16, decoration: const BoxDecoration(color: HireIQTheme.primaryTeal, shape: BoxShape.circle), child: Center(child: Text('${c.unread}', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white))))),
                        ]),
                        const SizedBox(width: 10),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [Expanded(child: Text(c.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))), Text(c.time, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted))]),
                          Text(c.company, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
                          Text(c.last, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted), overflow: TextOverflow.ellipsis),
                        ])),
                      ])),
                    );
                  },
                )),
              ]),
            )),
            // Centre: message thread
            Expanded(child: Container(
              decoration: BoxDecoration(color: HireIQTheme.background, border: Border.symmetric(vertical: BorderSide(color: HireIQTheme.borderLight))),
              child: Column(children: [
                Container(padding: const EdgeInsets.all(16), color: HireIQTheme.surfaceWhite, child: Row(children: [
                  CircleAvatar(backgroundColor: HireIQTheme.primaryTeal.withValues(alpha: 0.15), child: Text(_convos[_selected].name.substring(0, 1), style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: HireIQTheme.primaryTeal))),
                  const SizedBox(width: 12),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(_convos[_selected].name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary)),
                    Text(_convos[_selected].company, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                  ]),
                ])),
                const Divider(height: 1, color: HireIQTheme.borderLight),
                Expanded(child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _msgs.length,
                  itemBuilder: (_, i) {
                    final m = _msgs[i];
                    return Align(alignment: m.isMe ? Alignment.centerRight : Alignment.centerLeft, child: Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), constraints: const BoxConstraints(maxWidth: 400), decoration: BoxDecoration(color: m.isMe ? HireIQTheme.primaryNavy : HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: m.isMe ? null : Border.all(color: HireIQTheme.borderLight)), child: Text(m.text, style: GoogleFonts.inter(fontSize: 13, color: m.isMe ? Colors.white : HireIQTheme.textPrimary, height: 1.55))));
                  },
                )),
                Container(padding: const EdgeInsets.all(12), color: HireIQTheme.surfaceWhite, child: Row(children: [
                  Expanded(child: TextField(controller: _ctrl, decoration: InputDecoration(hintText: 'Type a message...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)))),
                  const SizedBox(width: 10),
                  IconButton(onPressed: () {}, style: IconButton.styleFrom(backgroundColor: HireIQTheme.primaryTeal, foregroundColor: Colors.white), icon: const Icon(Icons.send_rounded, size: 18)),
                ])),
              ]),
            )),
            // Right: info panel
            SizedBox(width: 240, child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: HireIQTheme.surfaceWhite, borderRadius: const BorderRadius.horizontal(right: Radius.circular(HireIQTheme.radiusLg)), border: Border.all(color: HireIQTheme.borderLight)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Contact Info', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                const SizedBox(height: 16),
                Text(_convos[_selected].name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                Text(_convos[_selected].company, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
                const SizedBox(height: 16),
                const Divider(color: HireIQTheme.borderLight),
                const SizedBox(height: 16),
                Text('Shared', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
                const SizedBox(height: 8),
                Text('0 files', style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted)),
              ]),
            )),
          ]),
        ),
      ),
    );
  }
}

class _Person { const _Person(this.name, this.company, this.last, this.time, this.unread); final String name, company, last, time; final int unread; }
class _Msg { const _Msg(this.text, this.isMe); final String text; final bool isMe; }
