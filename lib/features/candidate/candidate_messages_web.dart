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
  int _selectedConv = 0;
  final _msgController = TextEditingController();

  static const _convs = [
    _Conv('Sarah M.', 'TechFlow Solutions', 'Are you available for a call tomorrow?', '10m', 2, true),
    _Conv('David K.', 'Capitec Bank', 'Your application has been reviewed', '2h', 0, false),
    _Conv('Nomvula S.', 'HireIQ Support', 'Your PassportIQ is now verified ✓', '1d', 0, false),
    _Conv('Ruan vN.', 'Standard Bank', 'Can you send your portfolio?', '2d', 1, false),
  ];

  static const _msgs = [
    _Msg('Hi Thabo! We reviewed your application and would love to chat.', false, '10:00'),
    _Msg('Thanks Sarah! I\'m excited about the opportunity. When works for you?', true, '10:05'),
    _Msg('Are you available for a call tomorrow at 10am?', false, '10:10'),
    _Msg('That works perfectly. I\'ll send you my calendar.', true, '10:12'),
    _Msg('Are you available for a call tomorrow?', false, '10:30'),
  ];

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final conv = _convs[_selectedConv];
    return WebLayout(
      showFooter: false,
      child: SizedBox(
        height: 700,
        child: Row(children: [
          // Left: conversation list
          Container(
            width: 300,
            decoration: const BoxDecoration(color: HireIQTheme.surfaceWhite, border: Border(right: BorderSide(color: HireIQTheme.borderLight))),
            child: Column(children: [
              Padding(padding: const EdgeInsets.all(16), child: Column(children: [
                Row(children: [Text('Messages', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))]),
                const SizedBox(height: 10),
                TextField(decoration: InputDecoration(hintText: 'Search conversations...', prefixIcon: const Icon(Icons.search_rounded, size: 16), border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusMd)), contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), hintStyle: GoogleFonts.inter(fontSize: 12)), style: GoogleFonts.inter(fontSize: 12)),
              ])),
              const Divider(height: 1, color: HireIQTheme.borderLight),
              Expanded(child: ListView.builder(
                itemCount: _convs.length,
                itemBuilder: (_, i) {
                  final c = _convs[i];
                  final sel = _selectedConv == i;
                  return InkWell(
                    onTap: () => setState(() => _selectedConv = i),
                    child: Container(
                      color: sel ? HireIQTheme.primaryTeal.withValues(alpha: 0.05) : null,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(children: [
                        CircleAvatar(radius: 20, backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1), child: Text(c.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            Expanded(child: Text(c.name, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: HireIQTheme.textPrimary))),
                            Text(c.time, style: GoogleFonts.inter(fontSize: 10, color: HireIQTheme.textMuted)),
                          ]),
                          Text(c.company, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.primaryTeal, fontWeight: FontWeight.w600)),
                          Text(c.preview, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted), overflow: TextOverflow.ellipsis),
                        ])),
                        if (c.unread > 0) ...[
                          const SizedBox(width: 6),
                          Container(width: 18, height: 18, decoration: BoxDecoration(color: HireIQTheme.primaryTeal, shape: BoxShape.circle), child: Center(child: Text('${c.unread}', style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white)))),
                        ],
                      ]),
                    ),
                  );
                },
              )),
            ]),
          ),
          // Centre: message thread
          Expanded(child: Column(children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), decoration: const BoxDecoration(color: HireIQTheme.surfaceWhite, border: Border(bottom: BorderSide(color: HireIQTheme.borderLight))), child: Row(children: [
              CircleAvatar(radius: 18, backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1), child: Text(conv.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy))),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(conv.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                Text(conv.company, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
              ]),
              const Spacer(),
              if (conv.isRecruiter) Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.primaryTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Recruiter', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: HireIQTheme.primaryTeal))),
            ])),
            Expanded(child: ListView(padding: const EdgeInsets.all(20), children: [
              Center(child: Container(margin: const EdgeInsets.only(bottom: 16), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), child: Text('Today', style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)))),
              ..._msgs.map((m) => Align(
                alignment: m.isMine ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(color: m.isMine ? HireIQTheme.primaryTeal : HireIQTheme.surfaceWhite, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: m.isMine ? null : Border.all(color: HireIQTheme.borderLight)),
                  child: Column(crossAxisAlignment: m.isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start, children: [
                    Text(m.text, style: GoogleFonts.inter(fontSize: 13, color: m.isMine ? Colors.white : HireIQTheme.textPrimary, height: 1.4)),
                    const SizedBox(height: 4),
                    Text(m.time, style: GoogleFonts.inter(fontSize: 10, color: m.isMine ? Colors.white60 : HireIQTheme.textMuted)),
                  ]),
                ),
              )),
            ])),
            Container(padding: const EdgeInsets.all(16), decoration: const BoxDecoration(color: HireIQTheme.surfaceWhite, border: Border(top: BorderSide(color: HireIQTheme.borderLight))), child: Row(children: [
              Expanded(child: TextField(controller: _msgController, decoration: InputDecoration(hintText: 'Type a message...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(HireIQTheme.radiusFull)), contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12), hintStyle: GoogleFonts.inter(fontSize: 13)))),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: HireIQTheme.primaryTeal, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.all(14), shape: const CircleBorder()), child: const Icon(Icons.send_rounded, size: 18)),
            ])),
          ])),
          // Right: conversation info
          Container(
            width: 280,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: HireIQTheme.surfaceWhite, border: Border(left: BorderSide(color: HireIQTheme.borderLight))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(child: CircleAvatar(radius: 32, backgroundColor: HireIQTheme.primaryNavy.withValues(alpha: 0.1), child: Text(conv.name.substring(0, 1), style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: HireIQTheme.primaryNavy)))),
              const SizedBox(height: 10),
              Center(child: Text(conv.name, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy))),
              Center(child: Text(conv.company, style: GoogleFonts.inter(fontSize: 12, color: HireIQTheme.textMuted))),
              const Divider(height: 24, color: HireIQTheme.borderLight),
              Text('Shared Job', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.textMuted)),
              const SizedBox(height: 8),
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: HireIQTheme.background, borderRadius: BorderRadius.circular(HireIQTheme.radiusMd), border: Border.all(color: HireIQTheme.borderLight)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Senior Flutter Developer', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: HireIQTheme.primaryNavy)),
                Text(conv.company, style: GoogleFonts.inter(fontSize: 11, color: HireIQTheme.textMuted)),
              ])),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Conv {
  const _Conv(this.name, this.company, this.preview, this.time, this.unread, this.isRecruiter);
  final String name, company, preview, time;
  final int unread;
  final bool isRecruiter;
}

class _Msg {
  const _Msg(this.text, this.isMine, this.time);
  final String text, time;
  final bool isMine;
}
