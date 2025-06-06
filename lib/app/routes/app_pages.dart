import 'package:get/get.dart';

import '../modules/LeaveRequest/bindings/leave_request_binding.dart';
import '../modules/LeaveRequest/views/leave_request_view.dart';
import '../modules/attendance/bindings/attendance_binding.dart';
import '../modules/attendance/views/attendance_view.dart';
import '../modules/clock_in/bindings/clock_in_binding.dart';
import '../modules/clock_in/views/clock_in_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/face_recognition/bindings/face_recognition_binding.dart';
import '../modules/face_recognition/views/face_recognition_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/leave/bindings/leave_binding.dart';
import '../modules/leave/views/leave_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/submit_leave/bindings/submit_leave_binding.dart';
import '../modules/submit_leave/views/submit_leave_view.dart';
import '../modules/tenant/bindings/tenant_binding.dart';
import '../modules/tenant/views/tenant_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
      children: [
        GetPage(
          name: _Paths.ATTENDANCE,
          page: () => AttendanceView(),
          binding: AttendanceBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.LEAVE_REQUEST,
      page: () => const LeaveRequestView(),
      binding: LeaveRequestBinding(),
    ),
    GetPage(
      name: _Paths.TENANT,
      page: () => const TenantView(),
      binding: TenantBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LEAVE,
      page: () => const LeaveView(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SUBMIT_LEAVE,
      page: () => const SubmitLeaveView(),
      binding: SubmitLeaveBinding(),
    ),
    GetPage(
      name: _Paths.CLOCK_IN,
      page: () => const ClockInView(),
      binding: ClockInBinding(),
    ),
    GetPage(
      name: _Paths.FACE_RECOGNITION,
      page: () => const FaceRecognitionView(),
      binding: FaceRecognitionBinding(),
    ),
  ];
}
