//PFP:Mohammed Afeefuddin (002828362),Muhammad Samad Khan (002839953),Muhammad Mustufa (003030444)

import 'package:flutter/material.dart';

void main() {
  runApp(const CyberTactileApp());
}

class CyberTactileApp extends StatefulWidget {
  const CyberTactileApp({super.key});

  @override
  State<CyberTactileApp> createState() => _CyberTactileAppState();
}

class _CyberTactileAppState extends State<CyberTactileApp> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF00D4FF),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      title: 'Cyber-Tactile Command Deck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
        scaffoldBackgroundColor: isDarkMode
            ? const Color(0xFF07121D)
            : const Color(0xFFF3F7FA),
        fontFamily: 'monospace',
      ),
      home: CommandDeckScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: () => setState(() => isDarkMode = !isDarkMode),
      ),
    );
  }
}

class CommandDeckScreen extends StatefulWidget {
  const CommandDeckScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  final bool isDarkMode;
  final VoidCallback onThemeChanged;

  @override
  State<CommandDeckScreen> createState() => _CommandDeckScreenState();
}

class _CommandDeckScreenState extends State<CommandDeckScreen> {
  int energy = 100;
  int rescues = 0;
  double chargeLevel = 0;
  bool shieldActive = false;
  String heroStatus = 'ON PATROL';

  void _activateLaser() {
    if (energy < 25) return;
    setState(() {
      energy -= 25;
      chargeLevel = 0;
      heroStatus = 'LASER BLAST DEPLOYED';
    });
  }

  void _activateForcefield() {
    if (energy < 15) return;
    setState(() {
      energy -= 15;
      shieldActive = !shieldActive;
      heroStatus = shieldActive ? 'FORCEFIELD ONLINE' : 'FORCEFIELD STANDBY';
    });
  }

  void _completeRescue() {
    setState(() {
      rescues++;
      heroStatus = rescues >= 3 ? 'CITY SAVED!' : 'CIVILIAN RESCUED';
    });
  }

  void _recharge() {
    setState(() {
      energy = 100;
      heroStatus = 'POWER CELLS RECHARGED';
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isSaved = rescues >= 3;
    final panelColor = widget.isDarkMode
        ? const Color(0xFF102333)
        : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CYBER-TACTILE // COMMAND DECK'),
        actions: [
          IconButton(
            tooltip: 'Switch theme',
            onPressed: widget.onThemeChanged,
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TitleHeader(),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: panelColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colors.primary.withOpacity(.35),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: MetricBadge(
                            label: 'ENERGY',
                            value: '$energy%',
                            icon: Icons.bolt,
                            color: energy <= 25 ? colors.error : colors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MetricBadge(
                            label: 'RESCUES',
                            value: '$rescues / 3',
                            icon: Icons.people_alt,
                            color: isSaved
                                ? Colors.greenAccent
                                : colors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  StatusBanner(status: heroStatus, isSaved: isSaved),
                  const SizedBox(height: 22),
                  Text(
                    'TACTICAL COMMANDS',
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final buttonWidth = constraints.maxWidth > 620
                          ? (constraints.maxWidth - 18) / 2
                          : constraints.maxWidth;
                      return Wrap(
                        spacing: 18,
                        runSpacing: 18,
                        children: [
                          TactileActionButton(
                            width: buttonWidth,
                            icon: Icons.flash_on,
                            label: 'LASER BLAST',
                            detail: 'COSTS 25 ENERGY',
                            color: Colors.amber,
                            enabled: energy >= 25,
                            onPressed: _activateLaser,
                          ),
                          TactileActionButton(
                            width: buttonWidth,
                            icon: shieldActive
                                ? Icons.shield
                                : Icons.shield_outlined,
                            label: shieldActive ? 'DROP SHIELD' : 'FORCEFIELD',
                            detail: 'COSTS 15 ENERGY',
                            color: Colors.cyanAccent,
                            enabled: energy >= 15,
                            onPressed: _activateForcefield,
                          ),
                          TactileActionButton(
                            width: buttonWidth,
                            icon: Icons.volunteer_activism,
                            label: 'RESCUE CIVILIANS',
                            detail: 'MISSION PROGRESS +1',
                            color: Colors.greenAccent,
                            enabled: !isSaved,
                            onPressed: _completeRescue,
                          ),
                          TactileActionButton(
                            width: buttonWidth,
                            icon: Icons.battery_charging_full,
                            label: 'RECHARGE',
                            detail: 'RESTORE TO 100%',
                            color: Colors.orangeAccent,
                            enabled: energy < 100,
                            onPressed: _recharge,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 26),
                  Text(
                    'LASER CHARGE',
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Slider(
                    value: chargeLevel,
                    onChanged: (value) => setState(() => chargeLevel = value),
                    label: '${chargeLevel.toInt()}%',
                  ),
                  Text(
                    '${chargeLevel.toInt()}% CHARGED',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleHeader extends StatelessWidget {
  const TitleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(Icons.shield_moon, size: 40, color: colors.primary),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SENTINEL-07',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                'CITY EMERGENCY RESPONSE UNIT',
                style: TextStyle(fontSize: 11, letterSpacing: 1.2),
              ),
            ],
          ),
        ),
        const Icon(Icons.wifi, color: Colors.greenAccent),
      ],
    );
  }
}

class MetricBadge extends StatelessWidget {
  const MetricBadge({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 10)),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class StatusBanner extends StatelessWidget {
  const StatusBanner({super.key, required this.status, required this.isSaved});

  final String status;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    final color = isSaved
        ? Colors.greenAccent
        : Theme.of(context).colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Text(
        'STATUS // $status',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }
}

class TactileActionButton extends StatefulWidget {
  const TactileActionButton({
    super.key,
    required this.width,
    required this.icon,
    required this.label,
    required this.detail,
    required this.color,
    required this.enabled,
    required this.onPressed,
  });

  final double width;
  final IconData icon;
  final String label;
  final String detail;
  final Color color;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  State<TactileActionButton> createState() => _TactileActionButtonState();
}

class _TactileActionButtonState extends State<TactileActionButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final activeColor = widget.enabled ? widget.color : Colors.grey;
    return GestureDetector(
      onTapDown: widget.enabled
          ? (_) => setState(() => isPressed = true)
          : null,
      onTapUp: widget.enabled
          ? (_) {
              setState(() => isPressed = false);
              widget.onPressed();
            }
          : null,
      onTapCancel: widget.enabled
          ? () => setState(() => isPressed = false)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 110),
        width: widget.width,
        height: 104,
        padding: const EdgeInsets.all(16),
        transform: Matrix4.translationValues(0, isPressed ? 3 : 0, 0),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(widget.enabled ? 1 : .5),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: activeColor.withOpacity(widget.enabled ? .75 : .35),
          ),
          boxShadow: isPressed || !widget.enabled
              ? const []
              : [
                  BoxShadow(
                    color: activeColor.withOpacity(.18),
                    blurRadius: 16,
                    offset: const Offset(0, 7),
                  ),
                ],
        ),
        child: Row(
          children: [
            Icon(widget.icon, size: 34, color: activeColor),
            const SizedBox(width: 14),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: activeColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.detail,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
