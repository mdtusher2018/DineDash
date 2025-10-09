

import 'package:flutter_riverpod/flutter_riverpod.dart';

void resetSession(WidgetRef ref) {
  
  // // 🔁 Authentication
  // ref.invalidate(signInControllerProvider);
  // ref.invalidate(signUpControllerProvider);
  // ref.invalidate(afterSignUpOtpControllerProvider);
  // ref.invalidate(forgetPasswordControllerProvider);
  // ref.invalidate(forgotPasswordOtpControllerProvider);
  // ref.invalidate(createNewPasswordControllerProvider);

  // // 🔁 Notifications & Profile
  // ref.invalidate(notificationControllerProvider);
  // ref.invalidate(runningHistoryControllerProvider);

  // // 🔁 Core Services
  // ref.invalidate(apiServiceProvider);
  // ref.invalidate(apiClientProvider);
  // ref.invalidate(localStorageProvider);

  // // 🔁 Community Module
  // ref.invalidate(communityControllerProvider);
  // ref.invalidate(activeChallengeControllerProvider);
  // ref.invalidate(leaderboardControllerProvider);
  // ref.invalidate(feedControllerProvider);
  // ref.invalidate(myPostControllerProvider);
  // ref.invalidate(communityPostEditCreateProvider);

  // // ❗️ScrollControllers (autoDispose) – optional reset if you're using them during session
  // ref.invalidate(activeChallengeScrollControllerProvider);
  // ref.invalidate(feedScrollControllerProvider);
  // ref.invalidate(myPostScrollControllerProvider);
  // ref.invalidate(myWorkoutScrollControllerProvider);

  // // 🔁 Home
  // ref.invalidate(homeControllerProvider);
  // ref.invalidate(workoutControllerProvider);
  // ref.invalidate(myWorkoutControllerProvider);
  // ref.invalidate(nutritionTrackerControllerProvider);
  // ref.invalidate(runningGpsControllerProvider);

  // // Notifications & Profile
  // ref.invalidate(notificationControllerProvider);
  // ref.invalidate(notificationsScrollControllerProvider); // ← ✅ New addition
  // ref.invalidate(runningHistoryControllerProvider);

  // // Personalization (NEW!)
  // ref.invalidate(personalizationControllerProvider);

  // // Profile-related providers
  // ref.invalidate(changePasswordControllerProvider);
  // ref.invalidate(profileControllerProvider);
  // ref.invalidate(faqControllerProvider);
  // ref.invalidate(feedbackControllerProvider);
  // ref.invalidate(badgeShelfProvider);
  // ref.invalidate(runningHistoryControllerProvider);

  // // Scroll controller for running history (autoDispose)
  // ref.invalidate(runningHistoryScrollControllerProvider);

  // // Progress providers
  // ref.invalidate(progressControllerProvider);
  // ref.invalidate(recentSessionsProvider);

  // // Training
  // ref.invalidate(trainingControllerProvider);
  // ref.invalidate(completedTrainingScrollControllerProvider);

  // // ⚠️ Not directly invalidating family providers like:
  // // - postLikeDeleteControllerProvider
  // // - postDetailsProvider
  // // These require specific arguments. You can handle them explicitly if needed, e.g.:
  // // ref.invalidate(postDetailsProvider('post-id-here'));
}
