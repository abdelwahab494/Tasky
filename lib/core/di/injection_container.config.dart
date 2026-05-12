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

import '../../features/home_widget/data/datasource/tasks_widget_datasource.dart'
    as _i135;
import '../../features/home_widget/data/repositories/tasks_widget_repo_impl.dart'
    as _i202;
import '../../features/home_widget/domain/usecases/sync_widget.dart' as _i916;
import '../../features/notes/data/datasources/notes_local_datasource.dart'
    as _i43;
import '../../features/notes/data/repositories/notes_repo_impl.dart' as _i694;
import '../../features/notes/domain/usecases/add_note.dart' as _i760;
import '../../features/notes/domain/usecases/delete_all_notes.dart' as _i455;
import '../../features/notes/domain/usecases/delete_notes.dart' as _i741;
import '../../features/notes/domain/usecases/get_notes.dart' as _i348;
import '../../features/notes/domain/usecases/update_note.dart' as _i397;
import '../../features/notes/presentation/bloc/notes_bloc.dart' as _i207;
import '../../features/settings/data/datasource/settings_datasource.dart'
    as _i294;
import '../../features/settings/data/repo/settings_repo_impl.dart' as _i812;
import '../../features/settings/domain/usecase/get_settings.dart' as _i393;
import '../../features/settings/domain/usecase/toggle_theme.dart' as _i925;
import '../../features/settings/presentation/bloc/settings_bloc.dart' as _i585;
import '../../features/tasks/data/datasourses/tasks_local_datasource.dart'
    as _i457;
import '../../features/tasks/data/repo/tasks_repo_impl.dart' as _i722;
import '../../features/tasks/domain/usecases/add_task.dart' as _i793;
import '../../features/tasks/domain/usecases/delete_all_tasks.dart' as _i802;
import '../../features/tasks/domain/usecases/delete_task.dart' as _i840;
import '../../features/tasks/domain/usecases/get_home_user.dart' as _i549;
import '../../features/tasks/domain/usecases/get_tasks.dart' as _i517;
import '../../features/tasks/domain/usecases/update_task.dart' as _i739;
import '../../features/tasks/presentation/bloc/tasks_bloc.dart' as _i447;
import '../../features/user/data/datasources/user_local_datasource.dart'
    as _i798;
import '../../features/user/data/repositories/user_repo_impl.dart' as _i287;
import '../../features/user/domain/usecases/get_current_user.dart' as _i284;
import '../../features/user/domain/usecases/login.dart' as _i966;
import '../../features/user/domain/usecases/logout.dart' as _i487;
import '../../features/user/domain/usecases/pick_image.dart' as _i58;
import '../../features/user/domain/usecases/save_user.dart' as _i80;
import '../../features/user/presentation/bloc/user_bloc.dart' as _i747;
import '../helpers/session_helper.dart' as _i802;
import '../imports.dart' as _i1072;
import 'app_module.dart' as _i460;

const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.factoryAsync<_i1072.Isar>(() => appModule.isar, preResolve: true);
    gh.lazySingleton<_i43.NotesLocalDatasource>(
      () => _i43.NotesIsarDatasource(gh<_i1072.Isar>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i135.TasksWidgetDatasource>(
      () => _i135.TasksWidgetDatasourceImpl(gh<_i1072.Isar>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i294.SettingsDatasource>(
      () => _i294.SettingsIsarDatasource(gh<_i1072.Isar>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i457.TasksLocalDatasource>(
      () => _i457.TasksIsarDatasource(gh<_i1072.Isar>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i798.UserLocalDatasource>(
      () => _i798.UserIsarDatasource(gh<_i1072.Isar>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i1072.UserRepo>(
      () => _i287.UserRepoImpl(gh<_i1072.UserLocalDatasource>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i1072.TasksWidgetRepo>(
      () => _i202.TasksWidgetRepoImpl(gh<_i1072.TasksWidgetDatasource>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i916.SyncWidgetUsecase>(
      () => _i916.SyncWidgetUsecase(gh<_i1072.TasksWidgetRepo>()),
    );
    gh.lazySingleton<_i284.GetCurrentUserUsecase>(
      () => _i284.GetCurrentUserUsecase(gh<_i1072.UserRepo>()),
    );
    gh.lazySingleton<_i966.LoginUsecase>(
      () => _i966.LoginUsecase(gh<_i1072.UserRepo>()),
    );
    gh.lazySingleton<_i487.LogoutUsecase>(
      () => _i487.LogoutUsecase(gh<_i1072.UserRepo>()),
    );
    gh.lazySingleton<_i58.PickImageUsecase>(
      () => _i58.PickImageUsecase(gh<_i1072.UserRepo>()),
    );
    gh.lazySingleton<_i80.SaveUserUsecase>(
      () => _i80.SaveUserUsecase(gh<_i1072.UserRepo>()),
    );
    gh.lazySingleton<_i802.SessionHelper>(
      () => _i802.SessionHelper(gh<_i1072.UserRepo>(), gh<_i1072.Isar>()),
    );
    gh.lazySingleton<_i1072.SettingsRepo>(
      () => _i812.SettingsRepoImpl(gh<_i1072.SettingsDatasource>()),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i1072.NotesRepo>(
      () => _i694.NotesRepoImpl(
        gh<_i1072.NotesLocalDatasource>(),
        gh<_i1072.SessionHelper>(),
      ),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i760.AddNoteUsecase>(
      () => _i760.AddNoteUsecase(gh<_i1072.NotesRepo>()),
    );
    gh.lazySingleton<_i455.DeleteAllNotesUsecase>(
      () => _i455.DeleteAllNotesUsecase(gh<_i1072.NotesRepo>()),
    );
    gh.lazySingleton<_i741.DeleteNotesUsecase>(
      () => _i741.DeleteNotesUsecase(gh<_i1072.NotesRepo>()),
    );
    gh.lazySingleton<_i348.GetNotesUsecase>(
      () => _i348.GetNotesUsecase(gh<_i1072.NotesRepo>()),
    );
    gh.lazySingleton<_i397.UpdateNoteUsecase>(
      () => _i397.UpdateNoteUsecase(gh<_i1072.NotesRepo>()),
    );
    gh.factory<_i747.UserBloc>(
      () => _i747.UserBloc(
        getCurrentUserUsecase: gh<_i1072.GetCurrentUserUsecase>(),
        loginUsecase: gh<_i1072.LoginUsecase>(),
        logoutUsecase: gh<_i1072.LogoutUsecase>(),
        saveUserUsecase: gh<_i1072.SaveUserUsecase>(),
        pickImageUsecase: gh<_i1072.PickImageUsecase>(),
      ),
    );
    gh.lazySingleton<_i1072.TasksRepo>(
      () => _i722.TasksRepoImpl(
        gh<_i1072.TasksLocalDatasource>(),
        gh<_i1072.SessionHelper>(),
      ),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i393.GetSettingsUsecase>(
      () => _i393.GetSettingsUsecase(gh<_i1072.SettingsRepo>()),
    );
    gh.lazySingleton<_i925.ToggleThemeUsecase>(
      () => _i925.ToggleThemeUsecase(gh<_i1072.SettingsRepo>()),
    );
    gh.lazySingleton<_i793.AddTaskUsecase>(
      () => _i793.AddTaskUsecase(gh<_i1072.TasksRepo>()),
    );
    gh.lazySingleton<_i802.DeleteAllTasksUsecase>(
      () => _i802.DeleteAllTasksUsecase(gh<_i1072.TasksRepo>()),
    );
    gh.lazySingleton<_i840.DeleteTaskUsecase>(
      () => _i840.DeleteTaskUsecase(gh<_i1072.TasksRepo>()),
    );
    gh.lazySingleton<_i549.GetHomeUserUsecase>(
      () => _i549.GetHomeUserUsecase(gh<_i1072.TasksRepo>()),
    );
    gh.lazySingleton<_i517.GetTasksUsecase>(
      () => _i517.GetTasksUsecase(gh<_i1072.TasksRepo>()),
    );
    gh.lazySingleton<_i739.UpdateTaskUsecase>(
      () => _i739.UpdateTaskUsecase(gh<_i1072.TasksRepo>()),
    );
    gh.factory<_i207.NotesBloc>(
      () => _i207.NotesBloc(
        getNotesUsecase: gh<_i1072.GetNotesUsecase>(),
        addNoteUsecase: gh<_i1072.AddNoteUsecase>(),
        deleteAllTasksUsecase: gh<_i1072.DeleteAllTasksUsecase>(),
        deleteNotesUsecase: gh<_i1072.DeleteNotesUsecase>(),
        updateNoteUsecase: gh<_i1072.UpdateNoteUsecase>(),
      ),
    );
    gh.factory<_i585.SettingsBloc>(
      () => _i585.SettingsBloc(
        getSettingsUsecase: gh<_i1072.GetSettingsUsecase>(),
        toggleThemeUsecase: gh<_i1072.ToggleThemeUsecase>(),
      ),
    );
    gh.factory<_i447.TasksBloc>(
      () => _i447.TasksBloc(
        addTaskUsecase: gh<_i1072.AddTaskUsecase>(),
        updateTaskUsecase: gh<_i1072.UpdateTaskUsecase>(),
        deleteTaskUsecase: gh<_i1072.DeleteTaskUsecase>(),
        getTasksUsecase: gh<_i1072.GetTasksUsecase>(),
        deleteAllTasksUsecase: gh<_i1072.DeleteAllTasksUsecase>(),
        getHomeUserUsecase: gh<_i1072.GetHomeUserUsecase>(),
        syncWidgetUsecase: gh<_i1072.SyncWidgetUsecase>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i460.AppModule {}
