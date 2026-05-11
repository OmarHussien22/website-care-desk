import '../../../../core/network_structure/params/params.dart';

class CheckInvitationCodeParams extends Params {
  final String invitationCode;

  CheckInvitationCodeParams({required this.invitationCode});

  @override
  Map<String, dynamic> toJson() => {
        'invitation_code': invitationCode,
      };
}
