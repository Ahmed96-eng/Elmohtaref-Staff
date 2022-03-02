abstract class AppState {}

class AppInitialState extends AppState {}

class ChangeOnlineExpandState extends AppState {}

class ChangeGoExpandState extends AppState {}

class ChangeMoreDetailsState extends AppState {}

class ChangeCancelTaskExpandState extends AppState {}

class ChangeStoresExpandState extends AppState {}

class ChangePaymentExpandState extends AppState {}

class ChangeListTileValueState extends AppState {}

///start reset
///
class ResetPolyLineState extends AppState {}

///
///end reset
///
/// Start TIMER
class TimerIncressState extends AppState {}

class TimerCancelState extends AppState {}

/// End TIMER
///
///Start MAP
///
class AddPolyLineState extends AppState {}

///
///End MAP
///start get currrent address and location
class GetCurrentLocationFromLatLngSuccessState extends AppState {}

class GetCurrentAddressFromLatLngSuccessState extends AppState {}

///end get currrent address and location
///

/// start online
class OnlineStaustLoadingState extends AppState {}

class OnlineStaustSuccessState extends AppState {}

class OnlineStaustErrorState extends AppState {}

/// end online
///
///
/// start profile data

class GetProfileLoadingState extends AppState {}

class GetProfileSuccessState extends AppState {}

class GetProfileErrorState extends AppState {}

/// end profile data
///
///
///

///start update profile
class UpdateProfileLoadingState extends AppState {}

class UpdateProfileSuccessState extends AppState {}

class UpdateProfileErrorState extends AppState {}

///end update profile
///
///
///
/// start delete account

class DeleteAccountLoadingState extends AppState {}

class DeleteAccountSuccessState extends AppState {}

class DeleteAccountErrorState extends AppState {}

/// end delete account
///
///
/// start cancel task
class CancelTaskLoadingState extends AppState {}

class CancelTaskSuccessState extends AppState {}

class CancelTaskErrorState extends AppState {}

/// end cancel task
///
///
/// start CustomerRefusePay

class CustomerRefusePayLoadingState extends AppState {}

class CustomerRefusePaySuccessState extends AppState {}

class CustomerRefusePayErrorState extends AppState {}

/// end CustomerRefusePay
///
///
/// start Get Tasks data

class GetTasksLoadingState extends AppState {}

class GetTasksSuccessState extends AppState {}

class GetTasksErrorState extends AppState {}

class GetTasksPaginationLoadingState extends AppState {}

class GetTasksPaginationSuccessState extends AppState {}

class GetTasksPaginationErrorState extends AppState {}

/// end Get Tasks data
///
///
///
/// start TaskDetailsData

class GetTaskDetailsDataLoadingState extends AppState {}

class GetTaskDetailsDataSuccessState extends AppState {}

class GetTaskDetailsDataErrorState extends AppState {}

/// end TaskDetailsData
///
///
///
///
///
/// start chat message

class SendMessageSuccessState extends AppState {}

class SendMessageErrorState extends AppState {}

class SendSenderMessageSuccessState extends AppState {}

class SendSenderMessageErrorState extends AppState {}

class GetMessagesSuccessState extends AppState {}

class GetSenderMessagesSuccessState extends AppState {}

class DeleteMessagesSuccessState extends AppState {}

class DeleteMessagesErrorState extends AppState {}

/// end chat
///
///
///start  change passport image
class PickedPassportImageSuccessState extends AppState {}

class PickedPassportImageErrorState extends AppState {}

/// end change passport image
///
///
///
/// start change profile image
class PickedProfileImageSuccessState extends AppState {}

class PickedProfileImageErrorState extends AppState {}

/// end change profile image
///
///
/// start notification
class ChangeNotificationToggleState extends AppState {}

/// end notification
///
///
/// start ArriveNotification

class ArriveNotificationLoadingState extends AppState {}

class ArriveNotificationSuccessState extends AppState {}

class ArriveNotificationErrorState extends AppState {}

/// end ArriveNotification
///
///
/// start GET STORES

class GetStoresLoadingState extends AppState {}

class GetStoresSuccessState extends AppState {}

class GetStoresErrorState extends AppState {}

/// end GEt STORES
///
///
///
/// start Rate Customer

class RateCustomerSwapState extends AppState {}

class RateCustomerLoadingState extends AppState {}

class RateCustomerSuccessState extends AppState {}

class RateCustomerErrorState extends AppState {}

/// end Rate Customer
///
///
///
///
/// start Statics data

class GetStaticsLoadingState extends AppState {}

class GetStaticsSuccessState extends AppState {}

class GetStaticsErrorState extends AppState {}

/// end Statics data
///
///
/// start Statics Tasks data

class GetStaticsTasksLoadingState extends AppState {}

class GetStaticsTasksSuccessState extends AppState {}

class GetStaticsTasksErrorState extends AppState {}

/// end Statics TAsks data
///
///
///
///
///
/// start Weekly Summary data

class GetWeeklySummaryLoadingState extends AppState {}

class GetWeeklySummarySuccessState extends AppState {}

class GetWeeklySummaryErrorState extends AppState {}

/// end Weekly Summary data
///
///
///
///
/// start Today Summary data

class GetTodaySummaryLoadingState extends AppState {}

class GetTodaySummarySuccessState extends AppState {}

class GetTodaySummaryErrorState extends AppState {}

/// end Today Summary data
///
///
///
/// start Today Wallet data

class GetTodayWalletLoadingState extends AppState {}

class GetTodayWalletSuccessState extends AppState {}

class GetTodayWalletErrorState extends AppState {}

/// end Today Wallet data
///
/// start Weekly Wallet data

class GetWeeklyWalletLoadingState extends AppState {}

class GetWeeklyWalletSuccessState extends AppState {}

class GetWeeklyWalletErrorState extends AppState {}

/// end Weekly Wallet data
///
///
/// start Confirm Pay

class ConfirmPayLoadingState extends AppState {}

class ConfirmPaySuccessState extends AppState {}

class ConfirmPayErrorState extends AppState {}

/// end Confirm Pay
///
/// start confirmPaymentBody

class ConfirmPaymentBodyState extends AppState {}

/// end confirmPaymentBody
///
///
/// start Staff Offer to Customer

class StaffOfferToCustomerLoadingState extends AppState {}

class StaffOfferToCustomerSuccessState extends AppState {}

class StaffOfferToCustomerErrorState extends AppState {}

/// end Staff Offer to Customer
///
///
/// start CancelReason

class CancelReasonLoadingState extends AppState {}

class CancelReasonSuccessState extends AppState {}

class CancelReasonErrorState extends AppState {}

/// end CancelReason
///
///
/// start SendComplaint

class SendComplaintLoadingState extends AppState {}

class SendComplaintSuccessState extends AppState {}

class SendComplaintErrorState extends AppState {}

/// end SendComplaint
