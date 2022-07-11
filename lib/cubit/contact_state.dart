part of 'contact_cubit.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {
  final ContactUsModel contact;

  ContactSuccess(this.contact);
  @override
  // TODO: implement props
  List<Object> get props => [contact];
}

class ContactFailed extends ContactState {
  final String error;
  ContactFailed(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
