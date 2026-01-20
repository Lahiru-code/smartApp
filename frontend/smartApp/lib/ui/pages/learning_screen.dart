/*import 'package:flutter/material.dart';
import 'app_shell.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int tab = 0; // 0 chat, 1 code, 2 math

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Mathematics',
      subtitle: 'Algebra',
      selectedRoute: '/learning',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              _PillTabs(
                labels: const ['Chat', 'Code', 'Math'],
                selectedIndex: tab,
                onChanged: (i) => setState(() => tab = i),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _CardSection(
            title: '',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome to your Mathematics session on Algebra! How can I help you\ntoday?",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  '12:47:06 AM',
                  style: TextStyle(
                      fontSize: 11.5, color: Colors.black.withOpacity(0.5)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 420),
          _ChatComposer(
            hint: 'Ask anything...',
            onSend: () {},
          ),
        ],
      ),
    );
  }
}

/* ------------ widgets ------------ */

class _CardSection extends StatelessWidget {
  const _CardSection({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
              blurRadius: 26,
              offset: const Offset(0, 16),
              color: Colors.black.withOpacity(0.08)),
        ],
      ),
      child: child,
    );
  }
}

class _PillTabs extends StatelessWidget {
  const _PillTabs({
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(labels.length, (i) {
          final selected = i == selectedIndex;
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => onChanged(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF2563EB) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                labels[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color:
                      selected ? Colors.white : Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer({required this.hint, required this.onSend});
  final String hint;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: Row(
        children: [
          _CircleIcon(icon: Icons.mic_none),
          const SizedBox(width: 10),
          _CircleIcon(icon: Icons.image_outlined),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.black.withOpacity(0.08)),
              ),
              alignment: Alignment.centerLeft,
              child: Text(hint,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.30),
                      fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: onSend,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(999),
              ),
              child:
                  const Icon(Icons.send_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Icon(icon, color: Colors.black.withOpacity(0.55)),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'app_shell.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int tab = 0; // 0 = Chat, 1 = Code, 2 = Math

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Mathematics',
      subtitle: 'Algebra',
      selectedRoute: '/learning',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              _PillTabs(
                labels: const ['Chat', 'Code', 'Math'],
                selectedIndex: tab,
                onChanged: (i) => setState(() => tab = i),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (tab == 0) _ChatTab(),
          if (tab == 1) _CodeTab(),
          if (tab == 2) _MathTab(),
        ],
      ),
    );
  }
}

/* -------------------- CHAT TAB -------------------- */

class _ChatTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome to your Mathematics session on Algebra!\nHow can I help you today?",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                '12:47 AM',
                style: TextStyle(
                    fontSize: 11.5, color: Colors.black.withOpacity(0.5)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 300),
        _ChatComposer(hint: 'Ask anything...', onSend: () {}),
      ],
    );
  }
}

/* -------------------- CODE TAB -------------------- */

class _CodeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _CardSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Python', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Container(
            height: 220,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.08)),
            ),
            child: const Text(
              '# Write your code here\n'
              'def hello_world():\n'
              '    print("Hello, world!")',
              style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              ElevatedButton(onPressed: () {}, child: const Text('Run Code')),
              const SizedBox(width: 10),
              OutlinedButton(onPressed: () {}, child: const Text('Debug')),
              const Spacer(),
              OutlinedButton(onPressed: () {}, child: const Text('Get Help')),
            ],
          )
        ],
      ),
    );
  }
}

/* -------------------- MATH TAB -------------------- */

class _MathTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _CardSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Math Equation Solver',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: 'e.g. 2x + 5 = 15',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.black.withOpacity(0.15),
                  style: BorderStyle.solid),
            ),
            child: Center(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Enable Drawing'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Solve Equation'),
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------- SHARED WIDGETS -------------------- */

class _CardSection extends StatelessWidget {
  const _CardSection({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            blurRadius: 26,
            offset: const Offset(0, 16),
            color: Colors.black.withOpacity(0.08),
          )
        ],
      ),
      child: child,
    );
  }
}

class _PillTabs extends StatelessWidget {
  const _PillTabs({
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(labels.length, (i) {
          final selected = i == selectedIndex;
          return InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => onChanged(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF2563EB) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                labels[i],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color:
                      selected ? Colors.white : Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ChatComposer extends StatelessWidget {
  const _ChatComposer({required this.hint, required this.onSend});
  final String hint;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.mic_none)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.image_outlined)),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        IconButton(onPressed: onSend, icon: const Icon(Icons.send)),
      ],
    );
  }
}
