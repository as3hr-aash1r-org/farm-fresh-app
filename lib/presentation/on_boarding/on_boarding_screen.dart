import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';
import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';
import '../../helpers/styles/app_color.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _backgroundController;
  late AnimationController _particleController;

  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _backgroundOpacity;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimationSequence();
    _checkAuthenticationStatus();
  }

  void _initializeAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _logoRotation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // Background animations
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _backgroundOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _backgroundController,
        curve: Curves.easeIn,
      ),
    );

    // Particle animations
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _particleController,
        curve: Curves.linear,
      ),
    );
  }

  void _startAnimationSequence() async {
    // Start background animation immediately
    _backgroundController.forward();

    // Start particle animation
    _particleController.repeat();

    // Delay then start logo animation
    await Future.delayed(const Duration(milliseconds: 500));
    _logoController.forward();

    // Delay then start text animation
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();
  }

  void _checkAuthenticationStatus() async {
    // Wait for animations to play
    await Future.delayed(const Duration(milliseconds: 4500));

    if (mounted) {
      localStorageRepository.getValue("token").then(
            (response) => response.fold(
              (error) => AppNavigation.pushReplacement(RouteName.bottomBar),
              (token) => AppNavigation.pushReplacement(RouteName.bottomBar),
            ),
          );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _logoController,
          _textController,
          _backgroundController,
          _particleController,
        ]),
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.primary.withOpacity(_backgroundOpacity.value),
                  AppColor.green.withOpacity(_backgroundOpacity.value),
                  AppColor.lightYellow
                      .withOpacity(_backgroundOpacity.value * 0.8),
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Animated background particles
                ..._buildBackgroundParticles(),

                // Floating mango shapes
                ..._buildFloatingMangos(),

                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with animations
                      Transform.scale(
                        scale: _logoScale.value,
                        child: Transform.rotate(
                          angle: _logoRotation.value,
                          child: Image.asset(
                            AppImages.splash,
                            scale: 4.0,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // App title with slide animation
                      SlideTransition(
                        position: _textSlide,
                        child: FadeTransition(
                          opacity: _textFade,
                          child: _buildAppTitle(),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Subtitle with fade animation
                      FadeTransition(
                        opacity: _textFade,
                        child: _buildSubtitle(),
                      ),

                      const SizedBox(height: 50),

                      // Loading indicator
                      FadeTransition(
                        opacity: _textFade,
                        child: _buildLoadingIndicator(),
                      ),
                    ],
                  ),
                ),

                // Bottom decoration
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: FadeTransition(
                    opacity: _backgroundOpacity,
                    child: _buildBottomDecoration(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppTitle() {
    return Column(
      children: [
        const Text(
          "Farm Fresh Shop",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 8,
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      "Premium Quality • Farm Fresh • Delivered with Love",
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withOpacity(0.8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Loading your fresh experience...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomDecoration() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.2),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            "🌟 Taste the Difference 🌟",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackgroundParticles() {
    return List.generate(15, (index) {
      final delay = index * 0.1;
      final animationValue = (_particleAnimation.value + delay) % 1.0;

      return Positioned(
        left: (index * 50.0) % MediaQuery.of(context).size.width,
        top: MediaQuery.of(context).size.height * animationValue,
        child: Opacity(
          opacity: (0.3 * _backgroundOpacity.value * (1 - animationValue))
              .clamp(0.0, 1.0),
          child: Container(
            width: 4 + (index % 3) * 2,
            height: 4 + (index % 3) * 2,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    });
  }

  List<Widget> _buildFloatingMangos() {
    return List.generate(6, (index) {
      final animationValue =
          (_particleAnimation.value * 0.5 + index * 0.2) % 1.0;
      final xOffset =
          50.0 + (index * 60.0) % (MediaQuery.of(context).size.width - 100);
      final yOffset =
          100.0 + animationValue * (MediaQuery.of(context).size.height - 200);

      return Positioned(
        left: xOffset,
        top: yOffset,
        child: Transform.rotate(
          angle: animationValue * 6.28, // Full rotation
          child: Opacity(
            opacity: (0.15 * _backgroundOpacity.value).clamp(0.0, 1.0),
            child: Text(
              index % 2 == 0 ? "🥭" : "🍃",
              style: TextStyle(
                fontSize: 20 + (index % 3) * 10,
              ),
            ),
          ),
        ),
      );
    });
  }
}
