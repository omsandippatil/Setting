import 'package:flutter/material.dart';

class AccessibilityPage extends StatefulWidget {
  const AccessibilityPage({Key? key}) : super(key: key);

  @override
  State<AccessibilityPage> createState() => _AccessibilityPageState();
}

class _AccessibilityPageState extends State<AccessibilityPage> {
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

  double fontSizeScale = 1.0;
  double displaySizeScale = 1.0;
  double pointerSpeed = 1.0;
  double clickDelay = 0.1;
  double holdDelay = 0.5;
  double ignoreRepeatDelay = 0.5;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardColor: const Color(0xFF1E1E1E),
        dividerColor: const Color(0xFF2D2D2D),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Accessibility',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
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
                _buildSwitchTile(
                  'Live Transcribe',
                  'Real-time transcription of speech and sounds',
                  liveTranscribeEnabled,
                  (value) => setState(() => liveTranscribeEnabled = value),
                ),
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
                _buildSwitchTile(
                  'Switch Access',
                  'Use switches to control your device',
                  switchAccessEnabled,
                  (value) => setState(() => switchAccessEnabled = value),
                ),
                _buildSwitchTile(
                  'Universal Switch',
                  'Use external switches or gestures',
                  universalSwitchEnabled,
                  (value) => setState(() => universalSwitchEnabled = value),
                ),
                _buildSwitchTile(
                  'Assistant menu',
                  'Large on-screen menu for common actions',
                  assistantMenuEnabled,
                  (value) => setState(() => assistantMenuEnabled = value),
                ),
                _buildSwitchTile(
                  'Mouse pointer',
                  'Show pointer when using mouse',
                  mousePointerEnabled,
                  (value) => setState(() => mousePointerEnabled = value),
                ),
                _buildSliderTile(
                  'Pointer speed',
                  'Adjust mouse pointer speed',
                  pointerSpeed,
                  0.5,
                  2.0,
                  (value) => setState(() => pointerSpeed = value),
                ),
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
                _buildSwitchTile(
                  'Slow keys',
                  'Adjust how long to hold keys',
                  slowKeysEnabled,
                  (value) => setState(() => slowKeysEnabled = value),
                ),
                _buildSwitchTile(
                  'Bounce keys',
                  'Ignore fast duplicate key presses',
                  bounceKeysEnabled,
                  (value) => setState(() => bounceKeysEnabled = value),
                ),
                _buildSliderTile(
                  'Hold delay',
                  'Time to hold before long press',
                  holdDelay,
                  0.1,
                  2.0,
                  (value) => setState(() => holdDelay = value),
                ),
                _buildSliderTile(
                  'Ignore repeat',
                  'Ignore repeated touches',
                  ignoreRepeatDelay,
                  0.1,
                  2.0,
                  (value) => setState(() => ignoreRepeatDelay = value),
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
                _buildSwitchTile(
                  'High contrast keyboard',
                  'Make keyboard keys more visible',
                  highContrastKeyboardEnabled,
                  (value) => setState(() => highContrastKeyboardEnabled = value),
                ),
                _buildSwitchTile(
                  'Color inversion',
                  'Reverse display colors',
                  colorInversionEnabled,
                  (value) => setState(() => colorInversionEnabled = value),
                ),
                _buildSwitchTile(
                  'Color correction',
                  'Adjust colors for colorblindness',
                  colorCorrectionEnabled,
                  (value) => setState(() => colorCorrectionEnabled = value),
                ),
                _buildSwitchTile(
                  'Remove animations',
                  'Reduce motion and animations',
                  removeAnimationsEnabled,
                  (value) => setState(() => removeAnimationsEnabled = value),
                ),
                _buildSliderTile(
                  'Font size',
                  'Make text bigger or smaller',
                  fontSizeScale,
                  0.8,
                  1.5,
                  (value) => setState(() => fontSizeScale = value),
                ),
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
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1976D2),
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
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
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
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
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: const Color(0xFF1976D2),
                inactiveTrackColor: const Color(0xFF424242),
                inactiveThumbColor: const Color(0xFF9E9E9E),
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF9E9E9E),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                min.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFF1976D2),
                    inactiveTrackColor: const Color(0xFF424242),
                    thumbColor: const Color(0xFF1976D2),
                    overlayColor: const Color(0xFF1976D2).withOpacity(0.3),
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
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
                  color: Color(0xFF9E9E9E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}