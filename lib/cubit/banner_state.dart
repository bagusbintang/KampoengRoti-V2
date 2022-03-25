part of 'banner_cubit.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerSuccess extends BannerState {
  final List<BannerModel> banners;
  BannerSuccess(this.banners);
  @override
  // TODO: implement props
  List<Object> get props => [banners];
}

class BannerFailed extends BannerState {
  final String error;

  BannerFailed(this.error);

  @override
  // TODO: implement props
  List<Object> get props => [error];
}
