import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({Key? key}) : super(key: key);

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage>
    with TickerProviderStateMixin {
  // Original accessibility settings
  bool talkBackEnabled = false;
  bool selectToSpeakEnabled = false;
  bool soundAmplifierEnabled = false;
  bool liveTranscribeEnabled = false;
  bool soundNotificationsEnabled = false;
  bool voiceAccessEnabled = false;
  bool switchAccessEnabled = false;
  bool universalSwitchEnabled = false;
  bool assistantMenuEnabled = false;
  bool mousePointerEnabled = false;
  bool stickyKeysEnabled = false;
  bool slowKeysEnabled = false;
  bool bounceKeysEnabled = false;
  bool highContrastTextEnabled = false;
  bool highContrastKeyboardEnabled = false;
  bool colorInversionEnabled = false;
  bool colorCorrectionEnabled = false;
  bool removeAnimationsEnabled = false;
  bool flashNotificationEnabled = false;
  bool magnificationEnabled = false;
  bool magnificationShortcutEnabled = false;

  // Heart easter egg setting
  bool heartModeEnabled = false;

  double fontSizeScale = 1.0;
  double displaySizeScale = 1.0;
  double pointerSpeed = 1.0;
  double clickDelay = 0.1;
  double holdDelay = 0.5;
  double ignoreRepeatDelay = 0.5;

  // Heart easter egg variables
  List<HeartParticle> hearts = [];
  late AnimationController _heartController;
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat();
    
    _heartController.addListener(() {
      if (heartModeEnabled) {
        setState(() {
          // Remove completed hearts
          hearts.removeWhere((heart) => heart.progress >= 1.0);
          
          // Add new hearts periodically
          if (_random.nextDouble() < 0.15) {
            hearts.add(HeartParticle(
              startX: _random.nextDouble(),
              startY: 1.0 + _random.nextDouble() * 0.2,
              endX: _random.nextDouble(),
              endY: -0.2 - _random.nextDouble() * 0.2,
              size: _random.nextDouble() * 15 + 20,
              rotation: _random.nextDouble() * 2 * math.pi,
              speed: _random.nextDouble() * 0.5 + 0.5,
            ));
          }
          
          // Update existing hearts
          for (var heart in hearts) {
            heart.update();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _toggleHeartMode() {
    setState(() {
      heartModeEnabled = !heartModeEnabled;
      if (!heartModeEnabled) {
        hearts.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0A0A),
          foregroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        cardColor: const Color(0xFF161616),
        dividerColor: const Color(0xFF2A2A2A),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A0A0A),
          title: const Text(
            'Accessibility',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Screen reader'),
                  _buildSettingsGroup([
                    _buildSwitchTile(
                      'TalkBack',
                      'Spoken feedback to help you navigate your device',
                      talkBackEnabled,
                      (value) => setState(() => talkBackEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Select to Speak',
                      'Tap items to hear them read aloud',
                      selectToSpeakEnabled,
                      (value) => setState(() => selectToSpeakEnabled = value),
                    ),
                  ]),
                  
                  _buildSectionHeader('Audio'),
                  _buildSettingsGroup([
                    _buildSwitchTile(
                      'Sound Amplifier',
                      'Enhance audio from your device and environment',
                      soundAmplifierEnabled,
                      (value) => setState(() => soundAmplifierEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Live Transcribe',
                      'Real-time transcription of speech and sounds',
                      liveTranscribeEnabled,
                      (value) => setState(() => liveTranscribeEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Sound notifications',
                      'Get notified when baby crying or doorbell rings',
                      soundNotificationsEnabled,
                      (value) => setState(() => soundNotificationsEnabled = value),
                    ),
                  ]),
                  
                  _buildSectionHeader('Motor and cognition'),
                  _buildSettingsGroup([
                    _buildSwitchTile(
                      'Voice Access',
                      'Control your device with spoken commands',
                      voiceAccessEnabled,
                      (value) => setState(() => voiceAccessEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Switch Access',
                      'Use switches to control your device',
                      switchAccessEnabled,
                      (value) => setState(() => switchAccessEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Universal Switch',
                      'Use external switches or gestures',
                      universalSwitchEnabled,
                      (value) => setState(() => universalSwitchEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Assistant menu',
                      'Large on-screen menu for common actions',
                      assistantMenuEnabled,
                      (value) => setState(() => assistantMenuEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Mouse pointer',
                      'Show pointer when using mouse',
                      mousePointerEnabled,
                      (value) => setState(() => mousePointerEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSliderTile(
                      'Pointer speed',
                      'Adjust mouse pointer speed',
                      pointerSpeed,
                      0.5,
                      2.0,
                      (value) => setState(() => pointerSpeed = value),
                    ),
                    _buildDivider(),
                    _buildSliderTile(
                      'Click after pointer stops',
                      'Delay before click is registered',
                      clickDelay,
                      0.1,
                      2.0,
                      (value) => setState(() => clickDelay = value),
                    ),
                  ]),
                  
                  _buildSectionHeader('Advanced settings'),
                  _buildSettingsGroup([
                    _buildSwitchTile(
                      'Sticky keys',
                      'Press modifier keys one at a time',
                      stickyKeysEnabled,
                      (value) => setState(() => stickyKeysEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Slow keys',
                      'Adjust how long to hold keys',
                      slowKeysEnabled,
                      (value) => setState(() => slowKeysEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Bounce keys',
                      'Ignore fast duplicate key presses',
                      bounceKeysEnabled,
                      (value) => setState(() => bounceKeysEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSliderTile(
                      'Hold delay',
                      'Time to hold before long press',
                      holdDelay,
                      0.1,
                      2.0,
                      (value) => setState(() => holdDelay = value),
                    ),
                    _buildDivider(),
                    _buildSliderTile(
                      'Ignore repeat',
                      'Ignore repeated touches',
                      ignoreRepeatDelay,
                      0.1,
                      2.0,
                      (value) => setState(() => ignoreRepeatDelay = value),
                    ),
                    _buildDivider(),
                    // Easter egg setting hidden in advanced settings
                    _buildSwitchTile(
                      'Heart mode',
                      'Enable floating heart animations',
                      heartModeEnabled,
                      (value) => _toggleHeartMode(),
                    ),
                  ]),
                  
                  _buildSectionHeader('Display'),
                  _buildSettingsGroup([
                    _buildSwitchTile(
                      'High contrast text',
                      'Make text easier to read',
                      highContrastTextEnabled,
                      (value) => setState(() => highContrastTextEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'High contrast keyboard',
                      'Make keyboard keys more visible',
                      highContrastKeyboardEnabled,
                      (value) => setState(() => highContrastKeyboardEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Color inversion',
                      'Reverse display colors',
                      colorInversionEnabled,
                      (value) => setState(() => colorInversionEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Color correction',
                      'Adjust colors for colorblindness',
                      colorCorrectionEnabled,
                      (value) => setState(() => colorCorrectionEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Remove animations',
                      'Reduce motion and animations',
                      removeAnimationsEnabled,
                      (value) => setState(() => removeAnimationsEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSliderTile(
                      'Font size',
                      'Make text bigger or smaller',
                      fontSizeScale,
                      0.8,
                      1.5,
                      (value) => setState(() => fontSizeScale = value),
                    ),
                    _buildDivider(),
                    _buildSliderTile(
                      'Display size',
                      'Make items on screen bigger or smaller',
                      displaySizeScale,
                      0.8,
                      1.3,
                      (value) => setState(() => displaySizeScale = value),
                    ),
                  ]),
                  
                  _buildSectionHeader('Hearing enhancements'),
                  _buildSettingsGroup([
                    _buildSwitchTile(
                      'Flash notification',
                      'Flash camera light for notifications',
                      flashNotificationEnabled,
                      (value) => setState(() => flashNotificationEnabled = value),
                    ),
                  ]),
                  
                  _buildSectionHeader('Vision enhancements'),
                  _buildSettingsGroup([
                    _buildSwitchTile(
                      'Magnification',
                      'Zoom in on screen content',
                      magnificationEnabled,
                      (value) => setState(() => magnificationEnabled = value),
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Magnification shortcut',
                      'Triple-tap to zoom',
                      magnificationShortcutEnabled,
                      (value) => setState(() => magnificationShortcutEnabled = value),
                    ),
                  ]),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
            // Heart particles overlay
            if (heartModeEnabled)
              IgnorePointer(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CustomPaint(
                    painter: HeartPainter(hearts),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF4A90E2),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2A2A), width: 0.5),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 0.5,
      color: const Color(0xFF2A2A2A),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFE8E8E8),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF8A8A8A),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: const Color(0xFF4A90E2),
                activeTrackColor: const Color(0xFF4A90E2).withOpacity(0.3),
                inactiveTrackColor: const Color(0xFF3A3A3A),
                inactiveThumbColor: const Color(0xFF6A6A6A),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderTile(
    String title,
    String subtitle,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFE8E8E8),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8A8A8A),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                min.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8A8A8A),
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFF4A90E2),
                    inactiveTrackColor: const Color(0xFF3A3A3A),
                    thumbColor: const Color(0xFF4A90E2),
                    overlayColor: const Color(0xFF4A90E2).withOpacity(0.2),
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                  ),
                  child: Slider(
                    value: value,
                    min: min,
                    max: max,
                    divisions: 20,
                    onChanged: onChanged,
                  ),
                ),
              ),
              Text(
                max.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8A8A8A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeartParticle {
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final double size;
  final double rotation;
  final double speed;
  double progress = 0.0;
  double currentX = 0.0;
  double currentY = 0.0;
  double currentRotation = 0.0;
  double opacity = 1.0;
  double scale = 1.0;

  HeartParticle({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.size,
    required this.rotation,
    required this.speed,
  }) {
    currentX = startX;
    currentY = startY;
    currentRotation = rotation;
  }

  void update() {
    progress += speed * 0.008;
    
    if (progress > 1.0) progress = 1.0;
    
    // Smooth easing
    double easedProgress = 1.0 - math.pow(1.0 - progress, 2.0);
    
    // Add floating motion
    double floatOffset = math.sin(progress * math.pi * 4) * 0.02;
    
    currentX = startX + (endX - startX) * easedProgress + floatOffset;
    currentY = startY + (endY - startY) * easedProgress;
    currentRotation = rotation + (progress * 2 * math.pi);
    
    // Opacity and scale effects
    if (progress < 0.1) {
      opacity = progress / 0.1;
      scale = 0.5 + (progress / 0.1) * 0.5;
    } else if (progress > 0.8) {
      opacity = 1.0 - (progress - 0.8) / 0.2;
      scale = 1.0 + (progress - 0.8) / 0.2 * 0.3;
    } else {
      opacity = 1.0;
      scale = 1.0;
    }
  }
}

class HeartPainter extends CustomPainter {
  final List<HeartParticle> hearts;

  HeartPainter(this.hearts);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final shadowPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    for (var heart in hearts) {
      canvas.save();
      
      // Move to heart position
      canvas.translate(
        heart.currentX * size.width,
        heart.currentY * size.height,
      );
      
      // Scale and rotate
      canvas.scale(heart.scale);
      canvas.rotate(heart.currentRotation);
      
      // Draw shadow
      shadowPaint.color = const Color(0xFFFF69B4).withOpacity(heart.opacity * 0.3);
      canvas.translate(2, 2);
      _drawHeart(canvas, shadowPaint, heart.size);
      canvas.translate(-2, -2);
      
      // Draw main heart with gradient effect
      paint.shader = RadialGradient(
        colors: [
          const Color(0xFFFF1493).withOpacity(heart.opacity),
          const Color(0xFFFF69B4).withOpacity(heart.opacity * 0.8),
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: heart.size));
      
      _drawHeart(canvas, paint, heart.size);
      
      canvas.restore();
    }
  }

  void _drawHeart(Canvas canvas, Paint paint, double size) {
    final path = Path();
    
    // More refined heart shape
    double heartSize = size * 0.8;
    
    // Left curve
    path.moveTo(0, heartSize * 0.3);
    path.cubicTo(
      -heartSize * 0.5, -heartSize * 0.2,
      -heartSize * 0.8, heartSize * 0.2,
      0, heartSize * 0.8
    );
    
    // Right curve
    path.cubicTo(
      heartSize * 0.8, heartSize * 0.2,
      heartSize * 0.5, -heartSize * 0.2,
      0, heartSize * 0.3
    );
    
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}