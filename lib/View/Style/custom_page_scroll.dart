// ignore_for_file: curly_braces_in_flow_control_structures, unused_element, unnecessary_null_comparison, deprecated_new_in_comment_reference

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show objectRuntimeType, precisionErrorTolerance;
import 'dart:math' as math;

import 'package:flutter/physics.dart';

class CustomXPageScrollPhysics extends ScrollPhysics {

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) => const PageScrollPhysics();

  @override
  SpringDescription get spring =>
      const SpringDescription(mass: 100, stiffness: 100, damping: 100);
}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class CustomPageScrollPhysics extends ScrollPhysics {
  /// Creates physics for a [PageView].
  const CustomPageScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  PageScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PageScrollPhysics(parent: buildParent(ancestor));
  }

  double _getPage(ScrollMetrics position) {
    if (position is _PagePosition) return position.page!;
    return position.pixels / position.viewportDimension;
  }

  double _getPixels(ScrollMetrics position, double page) {
    if (position is _PagePosition) return position.getPixelsFromPage(page);
    return page * position.viewportDimension;
  }

  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = _getPage(position);
    if (velocity < -tolerance.velocity)
      page -= 0.5;
    else if (velocity > tolerance.velocity) page += 0.5;
    return _getPixels(position, page.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return CustomScrollSpringSimulation(
          spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class _PagePosition extends ScrollPositionWithSingleContext
    implements PageMetrics {
  _PagePosition({
    required ScrollPhysics physics,
    required ScrollContext context,
    this.initialPage = 0,
    bool keepPage = true,
    double viewportFraction = 1.0,
    ScrollPosition? oldPosition,
  })  : assert(initialPage != null),
        assert(keepPage != null),
        assert(viewportFraction != null),
        assert(viewportFraction > 0.0),
        _viewportFraction = viewportFraction,
        _pageToUseOnStartup = initialPage.toDouble(),
        super(
          physics: physics,
          context: context,
          initialPixels: null,
          keepScrollOffset: keepPage,
          oldPosition: oldPosition,
        );

  final int initialPage;
  double _pageToUseOnStartup;
  // When the viewport has a zero-size, the `page` can not
  // be retrieved by `getPageFromPixels`, so we need to cache the page
  // for use when resizing the viewport to non-zero next time.
  double? _cachedPage;

  @override
  Future<void> ensureVisible(
    RenderObject object, {
    double alignment = 0.0,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
    ScrollPositionAlignmentPolicy alignmentPolicy =
        ScrollPositionAlignmentPolicy.explicit,
    RenderObject? targetRenderObject,
  }) {
    // Since the _PagePosition is intended to cover the available space within
    // its viewport, stop trying to move the target render object to the center
    // - otherwise, could end up changing which page is visible and moving the
    // targetRenderObject out of the viewport.
    return super.ensureVisible(
      object,
      alignment: alignment,
      duration: duration,
      curve: curve,
      alignmentPolicy: alignmentPolicy,
    );
  }

  @override
  double get viewportFraction => _viewportFraction;
  double _viewportFraction;
  set viewportFraction(double value) {
    if (_viewportFraction == value) return;
    final double? oldPage = page;
    _viewportFraction = value;
    if (oldPage != null) forcePixels(getPixelsFromPage(oldPage));
  }

  // The amount of offset that will be added to [minScrollExtent] and subtracted
  // from [maxScrollExtent], such that every page will properly snap to the center
  // of the viewport when viewportFraction is greater than 1.
  //
  // The value is 0 if viewportFraction is less than or equal to 1, larger than 0
  // otherwise.
  double get _initialPageOffset =>
      math.max(0, viewportDimension * (viewportFraction - 1) / 2);

  double getPageFromPixels(double pixels, double viewportDimension) {
    assert(viewportDimension > 0.0);
    final double actual = math.max(0.0, pixels - _initialPageOffset) /
        (viewportDimension * viewportFraction);
    final double round = actual.roundToDouble();
    if ((actual - round).abs() < precisionErrorTolerance) {
      return round;
    }
    return actual;
  }

  double getPixelsFromPage(double page) {
    return page * viewportDimension * viewportFraction + _initialPageOffset;
  }

  @override
  double? get page {
    assert(
      !hasPixels || hasContentDimensions,
      'Page value is only available after content dimensions are established.',
    );
    return !hasPixels || !hasContentDimensions
        ? null
        : _cachedPage ??
            getPageFromPixels(pixels.clamp(minScrollExtent, maxScrollExtent),
                viewportDimension);
  }

  @override
  void saveScrollOffset() {
    PageStorage.of(context.storageContext)?.writeState(context.storageContext,
        _cachedPage ?? getPageFromPixels(pixels, viewportDimension));
  }

  @override
  void restoreScrollOffset() {
    if (!hasPixels) {
      final double? value = PageStorage.of(context.storageContext)
          ?.readState(context.storageContext) as double?;
      if (value != null) _pageToUseOnStartup = value;
    }
  }

  @override
  void saveOffset() {
    context.saveOffset(
        _cachedPage ?? getPageFromPixels(pixels, viewportDimension));
  }

  @override
  void restoreOffset(double offset, {bool initialRestore = false}) {
    assert(initialRestore != null);
    assert(offset != null);
    if (initialRestore) {
      _pageToUseOnStartup = offset;
    } else {
      jumpTo(getPixelsFromPage(offset));
    }
  }

  @override
  bool applyViewportDimension(double viewportDimension) {
    final double? oldViewportDimensions =
        hasViewportDimension ? this.viewportDimension : null;
    if (viewportDimension == oldViewportDimensions) {
      return true;
    }
    final bool result = super.applyViewportDimension(viewportDimension);
    final double? oldPixels = hasPixels ? pixels : null;
    double page;
    if (oldPixels == null) {
      page = _pageToUseOnStartup;
    } else if (oldViewportDimensions == 0.0) {
      // If resize from zero, we should use the _cachedPage to recover the state.
      page = _cachedPage!;
    } else {
      page = getPageFromPixels(oldPixels, oldViewportDimensions!);
    }
    final double newPixels = getPixelsFromPage(page);

    // If the viewportDimension is zero, cache the page
    // in case the viewport is resized to be non-zero.
    _cachedPage = (viewportDimension == 0.0) ? page : null;

    if (newPixels != oldPixels) {
      correctPixels(newPixels);
      return false;
    }
    return result;
  }

  @override
  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent) {
    final double newMinScrollExtent = minScrollExtent + _initialPageOffset;
    return super.applyContentDimensions(
      newMinScrollExtent,
      math.max(newMinScrollExtent, maxScrollExtent - _initialPageOffset),
    );
  }

  @override
  PageMetrics copyWith({
    double? minScrollExtent,
    double? maxScrollExtent,
    double? pixels,
    double? viewportDimension,
    AxisDirection? axisDirection,
    double? viewportFraction,
  }) {
    return PageMetrics(
      minScrollExtent: minScrollExtent ??
          (hasContentDimensions ? this.minScrollExtent : null),
      maxScrollExtent: maxScrollExtent ??
          (hasContentDimensions ? this.maxScrollExtent : null),
      pixels: pixels ?? (hasPixels ? this.pixels : null),
      viewportDimension: viewportDimension ??
          (hasViewportDimension ? this.viewportDimension : null),
      axisDirection: axisDirection ?? this.axisDirection,
      viewportFraction: viewportFraction ?? this.viewportFraction,
    );
  }
}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class CustomScrollSpringSimulation extends CustomSpringSimulation {
  /// Creates a spring simulation from the provided spring description, start
  /// distance, end distance, and initial velocity.
  ///
  /// See the [new SpringSimulation] constructor on the superclass for a
  /// discussion of the arguments' units.
  CustomScrollSpringSimulation(
    SpringDescription spring,
    double start,
    double end,
    double velocity, {
    Tolerance tolerance = Tolerance.defaultTolerance,
  }) : super(spring, start, end, velocity, tolerance: tolerance);

  @override
  double x(double time) => isDone(time) ? _endPosition : super.x(time);
}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class CustomSpringSimulation extends Simulation {
  /// Creates a spring simulation from the provided spring description, start
  /// distance, end distance, and initial velocity.
  ///
  /// The units for the start and end distance arguments are arbitrary, but must
  /// be consistent with the units used for other lengths in the system.
  ///
  /// The units for the velocity are L/T, where L is the aforementioned
  /// arbitrary unit of length, and T is the time unit used for driving the
  /// [CustomSpringSimulation].
  CustomSpringSimulation(
    SpringDescription spring,
    double start,
    double end,
    double velocity, {
    Tolerance tolerance = Tolerance.defaultTolerance,
  })  : _endPosition = end,
        _solution = _SpringSolution(spring, start - end, velocity),
        super(tolerance: tolerance);

  final double _endPosition;
  final _SpringSolution _solution;

  /// The kind of spring being simulated, for debugging purposes.
  ///
  /// This is derived from the [SpringDescription] provided to the [new
  /// CustomSpringSimulation] constructor.
  SpringType get type => _solution.type;

  @override
  double x(double time) => _endPosition + _solution.x(time);

  @override
  double dx(double time) => _solution.dx(time);

  @override
  bool isDone(double time) {
    return nearZero(_solution.x(time), tolerance.distance) &&
        nearZero(_solution.dx(time), tolerance.velocity);
  }

  @override
  String toString() =>
      '${objectRuntimeType(this, 'CustomSpringSimulation')}(end: ${_endPosition.toStringAsFixed(1)}, $type)';
}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

abstract class _SpringSolution {
  factory _SpringSolution(
    SpringDescription spring,
    double initialPosition,
    double initialVelocity,
  ) {
    assert(spring != null);
    assert(spring.mass != null);
    assert(spring.stiffness != null);
    assert(spring.damping != null);
    assert(initialPosition != null);
    assert(initialVelocity != null);
    final double cmk =
        spring.damping * spring.damping - 4 * spring.mass * spring.stiffness;
    if (cmk == 0.0)
      return _CriticalSolution(spring, initialPosition, initialVelocity);
    if (cmk > 0.0)
      return _OverdampedSolution(spring, initialPosition, initialVelocity);
    return _UnderdampedSolution(spring, initialPosition, initialVelocity);
  }

  double x(double time);
  double dx(double time);
  SpringType get type;
}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class _CriticalSolution implements _SpringSolution {
  factory _CriticalSolution(
    SpringDescription spring,
    double distance,
    double velocity,
  ) {
    final double r = -spring.damping / (2.0 * spring.mass);
    final double c1 = distance;
    final double c2 = velocity / (r * distance);
    return _CriticalSolution.withArgs(r, c1, c2);
  }

  _CriticalSolution.withArgs(double r, double c1, double c2)
      : _r = r,
        _c1 = c1,
        _c2 = c2;

  final double _r, _c1, _c2;

  @override
  double x(double time) {
    return (_c1 + _c2 * time) * math.pow(math.e, _r * time);
  }

  @override
  double dx(double time) {
    final double power = math.pow(math.e, _r * time) as double;
    return _r * (_c1 + _c2 * time) * power + _c2 * power;
  }

  @override
  SpringType get type => SpringType.criticallyDamped;
}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class _OverdampedSolution implements _SpringSolution {
  factory _OverdampedSolution(
    SpringDescription spring,
    double distance,
    double velocity,
  ) {
    final double cmk =
        spring.damping * spring.damping - 4 * spring.mass * spring.stiffness;
    final double r1 = (-spring.damping - math.sqrt(cmk)) / (2.0 * spring.mass);
    final double r2 = (-spring.damping + math.sqrt(cmk)) / (2.0 * spring.mass);
    final double c2 = (velocity - r1 * distance) / (r2 - r1);
    final double c1 = distance - c2;
    return _OverdampedSolution.withArgs(r1, r2, c1, c2);
  }

  _OverdampedSolution.withArgs(double r1, double r2, double c1, double c2)
      : _r1 = r1,
        _r2 = r2,
        _c1 = c1,
        _c2 = c2;

  final double _r1, _r2, _c1, _c2;

  @override
  double x(double time) {
    return _c1 * math.pow(math.e, _r1 * time) +
        _c2 * math.pow(math.e, _r2 * time);
  }

  @override
  double dx(double time) {
    return _c1 * _r1 * math.pow(math.e, _r1 * time) +
        _c2 * _r2 * math.pow(math.e, _r2 * time);
  }

  @override
  SpringType get type => SpringType.overDamped;
}

// ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class _UnderdampedSolution implements _SpringSolution {
  factory _UnderdampedSolution(
    SpringDescription spring,
    double distance,
    double velocity,
  ) {
    final double w = math.sqrt(4.0 * spring.mass * spring.stiffness -
            spring.damping * spring.damping) /
        (2.0 * spring.mass);
    final double r = -(spring.damping / 2.0 * spring.mass);
    final double c1 = distance;
    final double c2 = (velocity - r * distance) / w;
    return _UnderdampedSolution.withArgs(w, r, c1, c2);
  }

  _UnderdampedSolution.withArgs(double w, double r, double c1, double c2)
      : _w = w,
        _r = r,
        _c1 = c1,
        _c2 = c2;

  final double _w, _r, _c1, _c2;

  @override
  double x(double time) {
    return (math.pow(math.e, _r * time) as double) *
        (_c1 * math.cos(_w * time) + _c2 * math.sin(_w * time));
  }

  @override
  double dx(double time) {
    final double power = math.pow(math.e, _r * time) as double;
    final double cosine = math.cos(_w * time);
    final double sine = math.sin(_w * time);
    return power * (_c2 * _w * cosine - _c1 * _w * sine) +
        _r * power * (_c2 * sine + _c1 * cosine);
  }

  @override
  SpringType get type => SpringType.underDamped;
}
