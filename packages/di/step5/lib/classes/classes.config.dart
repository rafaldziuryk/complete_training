// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'classes.dart' as _i656;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i656.DataSource1>(() => _i656.DataSource1());
  gh.singleton<_i656.DataSource2>(() => _i656.DataSource2());
  gh.singleton<_i656.Repository2>(
    () => _i656.Repository2DBImplementation(),
    instanceName: 'db',
  );
  gh.singleton<_i656.Repository2>(
    () => _i656.Repository2SPImplementation(),
    instanceName: 'sp',
  );
  gh.factory<_i656.UseCase2>(() => _i656.UseCase2(
        dbRepository: gh<_i656.Repository2>(instanceName: 'db'),
        spRepository: gh<_i656.Repository2>(instanceName: 'sp'),
      ));
  gh.factory<_i656.Repository1>(() => _i656.Repository1Impl(
        dataSource1: gh<_i656.DataSource1>(),
        dataSource2: gh<_i656.DataSource2>(),
      ));
  gh.factoryParam<_i656.UseCase3, String, dynamic>((
    name,
    _,
  ) =>
      _i656.UseCase3(
        repository1: gh<_i656.Repository1>(),
        name: name,
      ));
  return getIt;
}
