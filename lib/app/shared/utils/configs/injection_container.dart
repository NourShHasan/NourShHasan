// import 'dart:async';

// import 'package:abwaab_revamp_v1/features/league/data/datasources/leaderboard_remote_data_source.dart';
// import 'package:abwaab_revamp_v1/features/league/data/datasources/league_subjects_remote_data_source.dart';
// import 'package:abwaab_revamp_v1/features/league/data/repositories/leaderboard_repository_impl.dart';
// import 'package:abwaab_revamp_v1/features/league/data/repositories/league_subjects_repository_imp.dart';
// import 'package:abwaab_revamp_v1/features/league/domain/repositories/leaderboard_repository.dart';
// import 'package:abwaab_revamp_v1/features/league/domain/repositories/league_subjects_repository.dart';
// import 'package:abwaab_revamp_v1/features/league/domain/usecases/leaderboard_use_cases.dart';
// import 'package:abwaab_revamp_v1/features/league/domain/usecases/league_subjects_use_cases.dart';
// import 'package:abwaab_revamp_v1/features/topics/topic.export.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../core/core.export.dart';
// import '../core/services/geolocation_service.dart';
// import '../features/features.export.dart';
// import '../features/league/data/datasources/nakama_remote_data_source.dart';
// import 'app_env.dart' show appEnv;
// import 'bloc_providers.dart';
// import 'config.export.dart';

// /// Instance of Get It
// final GetIt getIt = GetIt.instance;

// /// Initialize dependencies for the project and inject them into context.
// Widget setupDependencies({required Widget child}) => listOfBlocProviders(child);

// /// {@start_documentation}
// ///
// /// [DependencyInjectionInit] the base class that contains all dependencies that
// /// registered while the app opened some of them registered lazy and others
// /// immediately registered.
// /// That class help to register (UseCases), (DataSource) and (Repositories) classes
// /// and inject one to another to help app to use one instance of some important classes.
// ///
// /// {@end_documentation}
// class DependencyInjectionInit {
//   static final DependencyInjectionInit _singleton = DependencyInjectionInit._();

//   factory DependencyInjectionInit() => _singleton;

//   DependencyInjectionInit._() {
//     _initFirebase();
//   }

//   /// Register the Basic Singleton
//   Future<void> registerSingleton() async {
//     getIt.registerLazySingleton(() => appEnv);

//     /// create a instance of Shared Prefs classes.
//     final sharedPreferences = await SharedPreferences.getInstance();
//     final sharedPrefsClient = SharedPrefsClient(sharedPreferences);
//     getIt.registerLazySingleton(() => sharedPreferences);
//     getIt.registerLazySingleton(() => sharedPrefsClient);

//     /// register Dio Package
//     getIt.registerLazySingleton(() => Dio());

//     /// network info
//     final networkInterface = NetworkImpl(getIt(), appEnv, enableLog: true);
//     getIt.registerLazySingleton(() => networkInterface);

//     final nakamaImpl = NakamaRemoteDataSource(appEnv);
//     getIt.registerLazySingleton(() => nakamaImpl);

//     /// Init Use Cases
//     final authUseCase = _initAuth(networkInterface);
//     getIt.registerLazySingleton(() => authUseCase);

//     final subjectUseCase = _initSubjects(networkInterface);
//     final topicUseCase = _initTopicUseCases(networkInterface);
//     final initFlutterDownloader = _initFlutterDownloader();
//     final programUseCases = _initProgramUseCases(networkInterface);
//     final examUseCases = _initExamUseCases(networkInterface);
//     final callUseCases = _initSessionUseCases(networkInterface);
//     final subscriptionUseCases = _initSubscriptionUseCases(networkInterface);
//     final profileUseCases = _initProfileUseCases(networkInterface);
//     final lessonUseCases = _initLessonUseCases(networkInterface);
//     final activationUseCases = _initActivationUseCases(networkInterface);
//     final collectionUseCases = _initCollectionUseCases(networkInterface);
//     final practiceUseCase = _initPracticeUseCase(networkInterface);
//     final zendeskUseCase = _initZendeskUseCase(networkInterface);
//     final homeUseCase = _homeUseCase(networkInterface);
//     final notificationsUseCase = _notificationsUseCase(networkInterface);

//     // Init League Use Cases
//     final leagueSubjectsUseCases = _initSubjectsUseCases(networkInterface);
//     final leaderBoardUseCases = _initLeaderboardUseCases(networkInterface);

//     // Init Services
//     final geolocationService = _initGeolocationService(networkInterface);

//     // Init MT UseCases
//     final subUseCases = _initSubscriptionMTUseCase(networkInterface);
//     final microTutoringUseCases = _initMTUseCases(networkInterface);


//     /// Register Use Cases
//     getIt.registerLazySingleton(() => subjectUseCase);
//     getIt.registerLazySingleton(() => programUseCases);
//     getIt.registerLazySingleton(() => topicUseCase);
//     getIt.registerLazySingleton(() => initFlutterDownloader);
//     getIt.registerLazySingleton(() => examUseCases);
//     getIt.registerLazySingleton(() => callUseCases);
//     getIt.registerLazySingleton(() => microTutoringUseCases);
//     getIt.registerLazySingleton(() => subscriptionUseCases);
//     getIt.registerLazySingleton(() => profileUseCases);
//     getIt.registerLazySingleton(() => lessonUseCases);
//     getIt.registerLazySingleton(() => activationUseCases);
//     getIt.registerLazySingleton(() => collectionUseCases);
//     getIt.registerLazySingleton(() => practiceUseCase);
//     getIt.registerLazySingleton(() => leagueSubjectsUseCases);
//     getIt.registerLazySingleton(() => leaderBoardUseCases);
//     getIt.registerLazySingleton(() => zendeskUseCase);
//     getIt.registerLazySingleton(() => homeUseCase);
//     getIt.registerLazySingleton(() => notificationsUseCase);
//     getIt.registerLazySingleton(() => subUseCases);


//     /// Register Services
//     getIt.registerLazySingleton(() => geolocationService);
//   }

//   /// Init Firebase Services
//   Future<void> _initFirebase() async {
//     try {
//       // Initialize App with firebase
//       await Firebase.initializeApp(name: 'main', options: firebaseOptions);
//     } on FirebaseException catch (error) {
//       debugPrint('error of Firebase $error');
//     }
//   }

//   /// Init Flutter Downloader
//   Future<void> _initFlutterDownloader() async {
//     await FlutterDownloader.initialize(debug: false);
//   }

//   /// Init Login [ DataSources, Repositories ]
//   AuthenticationUseCases _initAuth(NetworkInterface networkInterface) {
//     LoginRemoteDataSource? _loginRemoteDSImpl;
//     SignUpRepository? _signUpRepository;
//     SignUpRemoteDataSource? _signUpRemoteDataSourceImpl;
//     LoginRepository? _loginRepository;
//     UserLocalDataSource? _userLocalDataSource;
//     UserRepository? _userRepository;
//     UserRemoteDataSource? _userRemoteDataSource;

//     // init Remote Data Source
//     _loginRemoteDSImpl = LoginRemoteDataSourceImpl(networkInterface);
//     _signUpRemoteDataSourceImpl = SignUpRemoteDsImpl(networkInterface);

//     // init local data source
//     _userLocalDataSource = UserLocalDataSourceImpl(getIt(), getIt());

//     // init repositories
//     _loginRepository = LoginRepositoryImpl(
//       _userLocalDataSource,
//       _loginRemoteDSImpl,
//     );

//     _signUpRepository = SignUpRepositoryImpl(
//       _signUpRemoteDataSourceImpl,
//       _userLocalDataSource,
//     );

//     //init user remote data sources
//     _userRemoteDataSource = UserRemoteDataSourceImpl(networkInterface);

//     _userRepository = UserRepositoryImpl(
//       _userLocalDataSource,
//       getIt(),
//       _loginRemoteDSImpl,
//       _userRemoteDataSource,
//     );

//     // register user repository
//     getIt.registerLazySingleton(() => _userRepository!);
//     getIt.registerLazySingleton(() => UserUseCases(_userRepository!));

//     // use cases
//     return AuthenticationUseCases(
//       _loginRepository,
//       _signUpRepository,
//       _userRepository,
//     );
//   }

//   /// Init Subjects UseCases
//   SubjectUseCases _initSubjects(NetworkInterface networkInterface) {
//     SubjectRemoteDataSource? _subjectRemoteDataSource;
//     SubjectRepository? _subjectRepository;

//     // init Remote Data Source
//     _subjectRemoteDataSource = SubjectRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _subjectRepository =
//         SubjectRepositoryImpl(_subjectRemoteDataSource, getIt());

//     // use cases
//     return SubjectUseCases(_subjectRepository);
//   }

//   /// Init Program Use Cases [ DataSources, Repositories ]
//   ProgramUseCases _initProgramUseCases(NetworkInterface networkInterface) {
//     ProgramRemoteDataSource? _programRemoteDSImpl;
//     ProgramRepository? _programRepository;

//     // init Remote Data Source
//     _programRemoteDSImpl = ProgramRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _programRepository = ProgramRepositoryImpl(getIt(), _programRemoteDSImpl);

//     // use cases
//     return ProgramUseCases(_programRepository);
//   }

//   /// Init Topic Use Cases [ DataSources, Repositories ]
//   TopicUseCases _initTopicUseCases(NetworkInterface networkInterface) {
//     TopicRemoteDataSource? _topicRemoteDSImpl;
//     TopicRepository? _topicRepository;

//     // init Remote Data Source
//     _topicRemoteDSImpl = TopicRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _topicRepository = TopicRepositoryImpl(_topicRemoteDSImpl, getIt());

//     // use cases
//     return TopicUseCases(_topicRepository);
//   }

//   /// Init Exams Use Cases [ DataSources, Repositories ]
//   ExamUseCases _initExamUseCases(NetworkInterface networkInterface) {
//     ExamRemoteDataSources? _examRemoteDSImpl;
//     ExamRepository? _examRepository;

//     // init Remote Data Source
//     _examRemoteDSImpl = ExamRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _examRepository = ExamRepositoryImpl(_examRemoteDSImpl, getIt());

//     // use cases
//     return ExamUseCases(_examRepository);
//   }

//   /// Init Session Use Cases [ DataSources, Repositories ]
//   SessionUseCases _initSessionUseCases(NetworkInterface networkInterface) {
//     SessionRemoteDataSource? _sessionRemoteDSImpl;
//     SessionRepository? _sessionRepository;

//     // init Remote Data Source
//     _sessionRemoteDSImpl = SessionRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _sessionRepository =
//         SessionRepositoryImpl(_sessionRemoteDSImpl, getIt(), getIt());

//     // use cases
//     return SessionUseCases(_sessionRepository);
//   }

//   /// Init MicroTutoring Use Cases [ DataSources, Repositories ]
//   MicroTutoringUseCases _initMTUseCases(NetworkInterface networkInterface) {
//     FirebaseRemoteDataSource? _firebaseRemoteDSImpl;
//     FirebaseRepository? _firebaseRepo;

//     QuestionRemoteDataSource? _questionRemoteDSImpl;
//     QuestionRepository? _questionRepo;

//     // init Remote Data Source
//     _firebaseRemoteDSImpl = FirebaseRemoteDataSourceImpl(networkInterface);
//     _questionRemoteDSImpl = QuestionRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _firebaseRepo =
//         FirebaseRepositoryImpl(_firebaseRemoteDSImpl, getIt(), getIt());

//     _questionRepo = QuestionRepositoryImpl(_questionRemoteDSImpl, getIt());

//     // use cases
//     return MicroTutoringUseCases(_firebaseRepo, _questionRepo);
//   }

//   /// Init Subscription Use Cases [ DataSources, Repositories ]
//   SubscriptionUseCases _initSubscriptionUseCases(
//     NetworkInterface networkInterface,
//   ) {
//     SubscriptionRemoteDataSource? _subscriptionRemoteDSImpl;
//     SubscriptionRepository? _subscriptionRepository;

//     // init Remote Data Source
//     _subscriptionRemoteDSImpl =
//         SubscriptionRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _subscriptionRepository =
//         SubscriptionRepositoryImpl(_subscriptionRemoteDSImpl, getIt());

//     // use cases
//     return SubscriptionUseCases(_subscriptionRepository);
//   }

//   /// Init Profile Use Cases [ DataSources, Repositories ]
//   ProfileUseCases _initProfileUseCases(NetworkInterface networkInterface) {
//     ProfileRemoteDataSource? _profileRemoteDSImpl;
//     ProfileRepository? _profileRepository;
//     UserLocalDataSource? _userLocalDataSource;

//     // init Remote Data Source
//     _profileRemoteDSImpl = ProfileRemoteDataSourceImpl(networkInterface);

//     _userLocalDataSource = UserLocalDataSourceImpl(getIt(), getIt());

//     // init repositories
//     _profileRepository = ProfileRepositoryImpl(
//       _profileRemoteDSImpl,
//       getIt(),
//       getIt(),
//       _userLocalDataSource,
//     );

//     // use cases
//     return ProfileUseCases(_profileRepository);
//   }

//   /// Init Lesson Use Cases [ DataSources, Repositories ]
//   LessonUseCases _initLessonUseCases(NetworkInterface networkInterface) {
//     LessonRemoteDataSource? _lessonRemoteDS;
//     LessonRepository? _lessonRepository;

//     // init Remote Data Source
//     _lessonRemoteDS = LessonRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _lessonRepository = LessonRepositoryImpl(_lessonRemoteDS, getIt());

//     // use cases
//     return LessonUseCases(_lessonRepository);
//   }

//   /// Init Activation Use Cases [ DataSources, Repositories ]
//   ActivationUseCases _initActivationUseCases(
//       NetworkInterface networkInterface) {
//     ActivationRemoteDataSource? _activationRemoteDS;
//     ActivationRepository? _activationRepository;

//     // init Remote Data Source
//     _activationRemoteDS = ActivationRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _activationRepository =
//         ActivationRepositoriesImpl(_activationRemoteDS, getIt());

//     // use cases
//     return ActivationUseCases(_activationRepository);
//   }

//   /// Init Collection Use Cases [ DataSources, Repositories ]
//   CollectionUseCase _initCollectionUseCases(NetworkInterface networkInterface) {
//     CollectionRemoteDataSource? _collectionRemoteDS;
//     CollectionRepository? _collectionRepository;

//     // init Remote Data Source
//     _collectionRemoteDS = CollectionRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _collectionRepository =
//         CollectionRepositoryImpl(_collectionRemoteDS, getIt());

//     // use cases
//     return CollectionUseCase(_collectionRepository);
//   }

//   /// Init Practice Use Cases [ DataSources, Repositories ]
//   PracticeUseCase _initPracticeUseCase(NetworkInterface networkInterface) {
//     PracticeRemoteDataSource? _practiceRemoteDS;
//     PracticeRepository? _practiceRepository;

//     // init Remote Data Source
//     _practiceRemoteDS = PracticeRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _practiceRepository = PracticeRepositoriesImpl(_practiceRemoteDS, getIt());

//     // use cases
//     return PracticeUseCase(_practiceRepository);
//   }

//   /// Init Subjects Use Cases [ DataSources, Repositories ]
//   LeagueSubjectsUseCases _initSubjectsUseCases(
//       NetworkInterface networkInterface) {
//     LeagueSubjectsRemoteDataSource? _SubjectsRemoteDSImpl;
//     LeagueSubjectsRepository? _subjectsRepository;

//     // init Remote Data Source
//     _SubjectsRemoteDSImpl =
//         LeagueSubjectsRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _subjectsRepository =
//         LeagueSubjectsRepositoryImpl(_SubjectsRemoteDSImpl, getIt());

//     // use cases
//     return LeagueSubjectsUseCases(_subjectsRepository);
//   }

//   LeaderboardUseCases _initLeaderboardUseCases(
//       NetworkInterface networkInterface) {
//     LeaderboardRemoteDataSource? _leaderboardRemoteDataSourceImpl;
//     LeaderboardRepository? _leaderBoardRepository;

//     // init Remote Data Source
//     _leaderboardRemoteDataSourceImpl =
//         LeaderboardRemoteDataSourceImpl(networkInterface);

//     // init repositories
//     _leaderBoardRepository =
//         LeaderboardRepositoryImpl(_leaderboardRemoteDataSourceImpl, getIt());

//     // use cases
//     return LeaderboardUseCases(_leaderBoardRepository);
//   }

//   ZendeskUsecase _initZendeskUseCase(NetworkInterface networkInterface) {
//     ZendeskRemoteDataSource? _zendeskRemoteDS;
//     ZendeskRepository? _zendeskRepository;

//     _zendeskRemoteDS = ZendeskRemoteDataSourceImpl(networkInterface);
//     _zendeskRepository = ZendeskRepositoriesImpl(_zendeskRemoteDS, getIt());

//     return ZendeskUsecase(_zendeskRepository);
//   }

//   /// Init Geolocation Services
//   GeoLocationService _initGeolocationService(
//     NetworkInterface networkInterface,
//   ) {
//     GeoLocationService? _geoLocationService;

//     _geoLocationService = GeoLocationServiceImpl(networkInterface, getIt());

//     return _geoLocationService;
//   }

//   /// Init Home UseCases
//   HomeUseCase _homeUseCase(NetworkInterface networkInterface) {
//     HomeRemoteDataSource? _homeRemoteDS;
//     HomeRepository? _homeRepository;

//     _homeRemoteDS = HomeRemoteDataSourceImpl(networkInterface);
//     _homeRepository = HomeRepositoriesImpl(_homeRemoteDS, getIt());

//     return HomeUseCase(_homeRepository);
//   }

//   /// Init Subscription MT UseCases
//   MTSubscriptionUseCase _initSubscriptionMTUseCase(
//     NetworkInterface networkInterface,
//   ) {
//     SubscriptionMTRemoteDS? _subscriptionMTRemoteDS;
//     MTSubscriptionRepository? _subscriptionMTRepository;

//     _subscriptionMTRemoteDS = SubscriptionMTRemoteDSImpl(networkInterface);
//     _subscriptionMTRepository = MTSubscriptionRepoImpl(_subscriptionMTRemoteDS, getIt());

//     return MTSubscriptionUseCase(_subscriptionMTRepository);
//   }

//   NotificationsUseCase _notificationsUseCase(NetworkInterface networkInterface) {
//     NotificationsRemoteDataSource? _notificationsRemoteDS;
//     NotificationsRepository? _notificationsRepository;

//     _notificationsRemoteDS = NotificationsRemoteDataSourceImpl(networkInterface);
//     _notificationsRepository = NotificationsRepositoryImpl(_notificationsRemoteDS, getIt());

//     return NotificationsUseCase(_notificationsRepository);
//   }
// }
